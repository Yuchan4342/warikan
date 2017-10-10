//
//  ViewController.swift
//  warikan
//
//  Created by 岩田裕登 on 2017/05/30.
//  Copyright © 2017年 岩田裕登. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextField2: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    
    @IBAction func tapCalculate(_ sender: Any) {
        var x1: Int = 0
        var x2: Int = 0
        // print("x1 = ", x1)
        // print("x2 = ", x2)
        if let text = myTextField.text, let x = Int(text) {
            x1 = x
            print("x1 = ", x1)
        }
        if let text = myTextField2.text, let x = Int(text) {
            x2 = x
            print("x2 = ", x2)
        }
        print("result = ", x1 + x2)
        let y = x1 + x2
        myLabel.text = String(y)
    }
    
    // myLabelがタップされたときクリップボードにコピー
    @IBAction func pressLabel(_ sender: Any?) {
        guard let gesture = sender as? UIGestureRecognizer else { return }
        guard gesture.state == .ended else { return }
        guard let label = gesture.view as? UILabel else { return }
        UIPasteboard.general.string = label.text
        myLabel2.text = "Copied!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // 1.0秒後に実行したい処理
            self.myLabel2.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        self.myTextField.delegate = self
        self.myTextField2.delegate = self
        // myLabelのタップなどに反応可能とする
        myLabel.isUserInteractionEnabled = true
        // 右揃えにする
        myTextField.textAlignment = NSTextAlignment.right
        myTextField2.textAlignment = NSTextAlignment.right
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TextFieldが編集可能となったときの動作
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.perform(#selector(selectAll(_:)), with: nil, afterDelay: 0.05)
        return true
    }
    
    // TextField編集中にReturnが押されたときの動作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // フォーカスを外す
        textField.resignFirstResponder()
        // 次のTag番号を持っているテキストボックスがあれば、フォーカスする
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.myTextField.isFirstResponder) {
            self.myTextField.resignFirstResponder()
        }
        if (self.myTextField2.isFirstResponder) {
            self.myTextField2.resignFirstResponder()
        }
    }
}

