//
//  SafetyPayView.swift
//  SafetyPayExample
//
//  Created by Liu Chuan on 2018/4/5.
//  Copyright © 2018年 LC. All rights reserved.
//

import UIKit


/// 安全支付样式
///
/// - ciphertext: 密文
/// - Plaintext: 明文
enum safetyPayStyle {
    /// 密文
    case ciphertext
    /// 明文
    case plaintext
}

/// 安全支付视图
class SafetyPayView: UIView {
    
    // MARK: - 属性
    /// 密码个数
    private let passwordCount =  6
    
    /// 密码点的大小
    private let dotSize = CGSize(width: 10, height: 10)
    
    /// 样式
    public var style = safetyPayStyle.ciphertext {
        didSet {    // 监听数值 `style` 的改变.
            if style != oldValue {
                configPlaintext()
            }else {
                configCiphertext()
            }
        }
    }
    
    // MARK: - 懒加载
    /// 点数组
    private lazy var dotArray = [UIView]()
    
    /// label数组
    private lazy var labelArray = [UILabel]()
    
    /// 密码输入文本框
    private lazy var pswTextField: UITextField = {
        let text = UITextField(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        text.backgroundColor = .clear
        text.textColor = .clear
        text.tintColor = .clear         // 输入框光标的颜色为无色
        text.keyboardType = .numberPad
        text.autocapitalizationType = .none
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.borderWidth = 1
        text.delegate = self
        text.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return text
    }()
    
    // MARK: - 系统初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*** 布局视图的时候调用 ***/
    /*
     为什么要在这个方法中布局子控件.
     因为只调用这个方法, 就表示父控件的尺寸确定
     */
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(pswTextField)
    }
}

// MARK: - 事件监听
extension SafetyPayView {
    
    /// 监听文本输入框内容的改变
    ///
    /// - Parameter textField: 文本输入框
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        print("正在输入--\(textField.text ?? "")")
        
        switch style {
        case .ciphertext:
            handleCiphertext(textField)
        case .plaintext:
            handlePlaintext(textField)
        }
    }
    
}

// MARK: - 私有方法
extension SafetyPayView {
    
    /// 配置密文
    private func configCiphertext() {
        
        /// 每个密码输入框的宽度
        let codeWidth: CGFloat = frame.size.width / CGFloat(passwordCount)
        
        /// 每一个输入框的高度等于当前view的高度
        let codeHeight: CGFloat = bounds.height
        
        /** 循环创建分割线: 5条竖线 **/
        for i in 0 ..< passwordCount - 1 {
            let x: CGFloat = pswTextField.frame.minX + CGFloat(i + 1) * codeWidth
            let lineView = UIView(frame: CGRect(x: x , y: 0, width: 1, height: codeHeight))
            lineView.backgroundColor = UIColor.gray
            addSubview(lineView)
        }
        /** 循环创建小黑点 **/
        for i in 0 ..< passwordCount {
            let viewX: CGFloat = (codeWidth - dotSize.width) / 2 + CGFloat(i) * codeWidth
            let viewY: CGFloat = pswTextField.frame.minY + (codeHeight - dotSize.height) / 2
            let dotView = UIView(frame: CGRect(x: viewX, y: viewY, width: dotSize.width, height: dotSize.height))
            dotView.backgroundColor = .black
            dotView.layer.cornerRadius = dotSize.width / 2
            dotView.clipsToBounds = true
            dotView.isHidden = true
            addSubview(dotView)
            // 把创建的黑色点加入到存放数组中
            dotArray.append(dotView)
        }
    }
    
    /// 配置明文
    private func configPlaintext() {
        
        pswTextField.layer.borderColor = UIColor.clear.cgColor
        
        /// 每个密码输入框的宽度
        let codeWidth: CGFloat = frame.size.width / CGFloat(passwordCount)
        
        /// 每一个输入框的高度等于当前view的高度
        let codeHeight: CGFloat = bounds.height
        
        /** 循环创建label **/
        for i in 0 ..< passwordCount {
            let x: CGFloat = CGFloat(i) * codeWidth
            let label = UILabel(frame: CGRect(x: x , y: 0, width: codeWidth, height: codeHeight))
            //            label.backgroundColor = UIColor.orange
            label.textAlignment = .center
            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderWidth = 1
            label.layer.cornerRadius = codeWidth / 2
            label.layer.masksToBounds = true
            addSubview(label)
            // 把创建的label加入到存放数组中
            labelArray.append(label)
        }
    }
    
    /// 处理密文
    ///
    /// - Parameter textField: 文本输入框
    private func handleCiphertext(_ textField: UITextField) {
        
        /** 重置显示的点 **/
        for dotView: UIView in dotArray {
            dotView.isHidden = true
        }
        // 获取文本输入框的文字个数
        guard let textCount = textField.text?.count else { return }
        for i in 0 ..< textCount { // 隐藏点
            dotArray[i].isHidden = false
        }
        if textField.text?.count == passwordCount {
            print("---输入完毕---")
            pswTextField.resignFirstResponder()   // 收起键盘
        }
    }
    
    /// 处理明文
    ///
    /// - Parameter textField: 文本输入框
    private func handlePlaintext(_ textField: UITextField) {
        
        // 获取文本输入框文字的个数
        guard let index = textField.text?.count else { return }
        
        // 如果个数为0 执行{}外代码
        guard index == 0 else {
            // 获取textfield的文字
            let tt = textField.text! as NSString
            // 设置label的文字
            labelArray[index - 1].text = NSString(format: "%c", tt.character(at: index - 1)) as String
            // 设置label的边框颜色
            labelArray[index - 1].layer.borderColor = UIColor.red.cgColor
            // 设置label的文字颜色
            labelArray[index - 1].textColor = .red
            if index < passwordCount {
                labelArray[index].text = ""
                labelArray[index].layer.borderColor = UIColor.gray.cgColor
            }
            return
        }
        labelArray[0].text = ""
        labelArray[0].layer.borderColor = UIColor.gray.cgColor
    }
}


// MARK: - UITextFieldDelegate
extension SafetyPayView: UITextFieldDelegate {
    
 
    /// 功能：把textField中位置为range的字符串替换为string字符串, 此函数在textField内容被修改时调用
    ///
    /// - Parameters:
    ///   - textField: 响应UITextFieldDelegate协议的UITextField控件。
    ///   - range:  UITextField控件中光标选中的字符串，即被替换的字符串；
    ///   - string: 替换字符串. string.length为0时，表示删除
    /// - Returns: 　true:表示修改生效. false:表示不做修改，textField的内容不变。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("正在输入:....\(string)")

        if string == "\n" {
            // 按回车关闭键盘
            textField.resignFirstResponder()
            return false
        } else if string.count == 0 {
            // 判断是不是删除键
            return true
        } else if (textField.text?.count)! >= passwordCount {
            // 输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
            print("输入的字符个数大于6，后面禁止输入则忽略输入")
            return false
        } else {
            return true
        }
        
    }
    
    
    
    
    
}

