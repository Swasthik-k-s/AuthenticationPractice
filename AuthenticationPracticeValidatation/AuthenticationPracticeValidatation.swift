//
//  AuthenticationPracticeValidatation.swift
//  AuthenticationPracticeValidatation
//
//  Created by Swasthik K S on 21/10/21.
//

import XCTest
@testable import AuthenticationPractice

class AuthenticationPracticeValidatation: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCheckLoginValidationWithTwoEmptyFieldsReturnErrorString() {
        let result = LoginViewController().validateUser(email: "", password: "")
        
        XCTAssertEqual(result, "Please fill all the Fields")
    }
    
    func testCheckLoginValidationWithEmailEmptyFieldReturnErrorString() {
        let result = LoginViewController().validateUser(email: "", password: "123456")
        
        XCTAssertEqual(result, "Please fill all the Fields")
    }
    
    func testCheckLoginValidationWithPasswordEmptyFieldReturnErrorString() {
        let result = LoginViewController().validateUser(email: "abc@gmail.com", password: "")
        
        XCTAssertEqual(result, "Please fill all the Fields")
    }

}
