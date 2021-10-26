//
//  AuthenticationPracticeValidatation.swift
//  AuthenticationPracticeValidatation
//
//  Created by Swasthik K S on 21/10/21.
//

import XCTest
@testable import AuthenticationPractice

class AuthenticationPracticeValidatation: XCTestCase {
    
    func testCheckLoginValidationWithAllEmptyFieldsReturnErrorString() {
        let result = LoginViewController().validateUser(email: "", password: "")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testCheckLoginValidationWithEmailEmptyFieldReturnErrorString() {
        let result = LoginViewController().validateUser(email: "", password: "123456")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testCheckLoginValidationWithPasswordEmptyFieldReturnErrorString() {
        let result = LoginViewController().validateUser(email: "abc@gmail.com", password: "")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }

    func testCheckSignUpValidationWithAllEmptyFieldsReturnErrorString() {
        let result = SignUpViewController().validateUser(username: "", email: "", password: "")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testCheckSignUpValidationWithUsernameEmptyFieldReturnErrorString() {
        let result = SignUpViewController().validateUser(username: "", email: "abc@gmail.com", password: "123456")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testCheckSignUpValidationWithEmailEmptyFieldReturnErrorString() {
        let result = SignUpViewController().validateUser(username: "abc", email: "", password: "123456")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testCheckSignUpValidationWithPasswordEmptyFieldReturnErrorString() {
        let result = SignUpViewController().validateUser(username: "abc", email: "abc@gmail.com", password: "")
        
        XCTAssertEqual(result, messageConstants.emptyFields)
    }
    
    func testValidateEmailFormatWithInvalidEmailReturnFalse() {
        let view = UIViewController()
        let result1 = view.emailValidation(email: "abc")
        let result2 = view.emailValidation(email: "abc@gmail")
        let result3 = view.emailValidation(email: "abc@gmail.")
        let result4 = view.emailValidation(email: "abc.gmail.com")
        
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        XCTAssertFalse(result3)
        XCTAssertFalse(result4)
    }
    
    func testValidateEmailFormatWithValidEmailReturnTrue() {
        let result = UIViewController().emailValidation(email: "abc@gmail.com")
        XCTAssertTrue(result)
    }
    
    func testValidatePasswordFormatWithInvalidPasswordReturnFalse() {
        let view = UIViewController()
        
        //Minimum 8 Characters
        let result1 = view.passwordValidation(password: "abc12#")
        
        //Atleast 1 Number
        let result2 = view.passwordValidation(password: "abcdefghij")
        
        //Atleast 1 Special Character
        let result3 = view.passwordValidation(password: "abcd1234")
        
        XCTAssertFalse(result1)
        XCTAssertFalse(result2)
        XCTAssertFalse(result3)
    }
    
    func testValidatePasswordFormatWithValidPasswordReturnTrue() {
        let result = UIViewController().passwordValidation(password: "abcd1234%")
        XCTAssertTrue(result)
    }
}
