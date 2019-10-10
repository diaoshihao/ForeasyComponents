//
//  HYTextField.swift
//  HYLibarary
//
//  Created by 刁世浩 on 2019/9/17.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import UIKit

protocol HYTextFieldDelegate: NSObjectProtocol {
    func textFieldDidChangeText(_ textField: HYTextField)
    
    func textFieldDidEndEditing(_ textField: HYTextField)
    
    func textFieldDidBeginEditing(_ textField: HYTextField)
    
    func textFieldShouldClear(_ textField: HYTextField) -> Bool
    
    func textFieldShouldReturn(_ textField: HYTextField) -> Bool
    
    func textFieldShouldEndEditing(_ textField: HYTextField) -> Bool
    
    func textFieldShouldBeginEditing(_ textField: HYTextField) -> Bool
    
    func textField(_ textField: HYTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    func textFieldDidLimited(_ textField: HYTextField, limit: HYTextField.LimitInfoType)
    
}

extension HYTextFieldDelegate {
    func textFieldDidChangeText(_ textField: HYTextField) { }
    
    func textFieldDidEndEditing(_ textField: HYTextField) { }
    
    func textFieldDidBeginEditing(_ textField: HYTextField) { }
    
    func textFieldShouldClear(_ textField: HYTextField) -> Bool { return true }
    
    func textFieldShouldReturn(_ textField: HYTextField) -> Bool { return true }
    
    func textFieldShouldEndEditing(_ textField: HYTextField) -> Bool { return true }
    
    func textFieldShouldBeginEditing(_ textField: HYTextField) -> Bool { return true }
    
    func textField(_ textField: HYTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    
    func textFieldDidLimited(_ textField: HYTextField, limit: HYTextField.LimitInfoType) { }
}

extension HYTextField {
    
    enum LimitStyle {
        case none               // 无限制
        case length(len: UInt)  // 限制长度
        case number(lower: Double?, upper: Double?, type: LimitNumberType) // 限制大小（上下限）
    }
    
    enum LimitNumberType {
        case integer             // 整数
        case decimal(place: Int) // 小数，place: 小数点位数，小于0 不限制位数
    }
    
    enum LimitInfoType {
        case length(len: UInt)      // 超出长度
        case decimal(place: Int)    // 超出小数点位数
        case outOfBounds(bounds: Double, isUpper: Bool)     // 超出数字范围
        case invalidate(string: String)     // 非法输入(如数字输入下输入字母等)
    }
}

class HYTextField: UITextField {

    var limit: LimitStyle = .none
    
    weak var hyDelegate: HYTextFieldDelegate?
    
    override var delegate: UITextFieldDelegate? {
        set {
            super.delegate = self
        }
        get {
            return self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        addTarget(self, action: #selector(textFieldEditingChange(_:)), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HYTextField {
    @objc func textFieldEditingChange(_ textField: UITextField) {
        
        hyDelegate?.textFieldDidChangeText(self)
        
        // 非长度限制，返回
        guard case let LimitStyle.length(len) = limit else { return }
        
        if let lang = UIApplication.shared.textInputMode?.primaryLanguage, lang == "zh-Hans" {
            // 获取高亮部分，有高亮不进行字数统计和限制
            guard let selectedRange = textField.markedTextRange else { return }
            guard let _ = textField.position(from: selectedRange.start, offset: 0) else { return }
        }
        
        // 长度统计限制
        guard let text = textField.text else { return }
        if text.count > len {
            textField.text = String(text.prefix(Int(len)))
            hyDelegate?.textFieldDidLimited(self, limit: .length(len: len))
        }
    }
}

extension HYTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 删除
        if string.isEmpty {
            return true
        }
        
        let text = textField.text ?? ""
        guard let swiftRange = Range(range, in: text) else { return false }
        let toBeString = text.replacingCharacters(in: swiftRange, with: string)
        
        // 限制输入数字类型
        if case let LimitStyle.number(lower, upper, type) = limit {
            
            var characters = "1234567890"
            // 小数，可输入小数点
            if case LimitNumberType.decimal = type {
                characters.append(".")
            }
            // 最小值小于0，可输入负号
            if let lowerBound = lower, lowerBound < 0 {
                characters.append("-")
            }
            
            // 1. 限制只能输入数字/点/负号
            if toBeString.trimmingCharacters(in: CharacterSet(charactersIn: characters)).count > 0 {
                hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                return false
            }
            
            // 2. 限制负号只能在首位
            if string == "-", text.count > 0 {
                hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                return false
            }
            
            // 3. 当前值为0，且未输入小数点，限制只能输入小数点
            if text == "0" || text == "-0", string != "." {
                hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                return false
            }
            
            // 4. 输入小数点时
            if string == "." {
                // 4.1 限制第一位不能是小数点
                if text.count == 0 {
                    hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                    return false
                }
                // 4.2 限制小数点不能重复
                if text.contains(".") {
                    hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                    return false
                }
                // 4.3 限制负号后不能输入小数点
                if text == "-" {
                    hyDelegate?.textFieldDidLimited(self, limit: .invalidate(string: string))
                    return false
                }
            }
            
            // 5. 限制小数位数
            if text.contains("."), case let LimitNumberType.decimal(place) = type, place >= 0 {
                if let decimalStr = toBeString.components(separatedBy: ".").last, decimalStr.count > place {
                    hyDelegate?.textFieldDidLimited(self, limit: .decimal(place: place))
                    return false
                }
            }
            
            // 6. 限制数字大小
            if let number = Double(toBeString) {
                if let lowerBound = lower, number <= lowerBound {
                    hyDelegate?.textFieldDidLimited(self, limit: .outOfBounds(bounds: lowerBound, isUpper: false))
                    return false
                }
                if let upperBound = upper, number >= upperBound {
                    hyDelegate?.textFieldDidLimited(self, limit: .outOfBounds(bounds: upperBound, isUpper: true))
                    return false
                }
            }
        }
        
        return hyDelegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
}

extension HYTextField {
    func textFieldDidEndEditing(_ textField: UITextField) {
        hyDelegate?.textFieldDidEndEditing(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hyDelegate?.textFieldDidBeginEditing(self)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return hyDelegate?.textFieldShouldClear(self) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return hyDelegate?.textFieldShouldReturn(self) ?? true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return hyDelegate?.textFieldShouldEndEditing(self) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return hyDelegate?.textFieldShouldBeginEditing(self) ?? true
    }
}
