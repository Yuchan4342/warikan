//
//  warikanUITests.swift
//  warikanUITests
//
//  Created by 岩田裕登 on 2017/05/30.
//  Copyright © 2017年 岩田裕登. All rights reserved.
//

import XCTest

class warikanUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        // 「Calculate」ボタンを取得
        let myButton1 = app.buttons["myButton1"]
        // 上のテキストフィールドを取得
        let myTextField1 = app.textFields["myTextField1"]
        // 上のテキストフィールドをタップしてフォーカスを当てる
        myTextField1.tap()
        // 2500と入力
        myTextField1.typeText("2500")
        // 下のテキストフィールドを取得
        let myTextField2 = app.textFields["myTextField2"]
        // 下のテキストフィールドをタップしてフォーカスを当てる
        myTextField2.tap()
        // 5と入力
        myTextField2.typeText("5")
        // ボタンをタップ
        myButton1.tap()
        let myLabel1 = app.staticTexts["myLabel1"]
        // 結果を表示するラベルのテキストが「一人500円！」になっていれば成功
        XCTAssertEqual(myLabel1.label, "一人500円！")
    }
    
}
