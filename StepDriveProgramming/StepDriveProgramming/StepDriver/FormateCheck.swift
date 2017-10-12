//
//  ContryPicker.swift
//  Sioeye
//
//  Created by alvin zheng on 16/7/28.
//  Copyright © 2016年 Sioeye Inc. All rights reserved.
//

import Foundation

// MARK: Format Checking
/**
 Sign up Format Checking
 */
// TODO update this!
struct FormatCheck {

    static let verifyCodeLengt: Int = 6
    static  func isValidEmail(_ testStr: String) -> Bool {
        // lVerbose("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr) && testStr.characters.count <= 48
    }

    static func nicknameCheck(_ text: String) -> Bool {
        return text.characters.count >= 4 && text.characters.count <= 30
    }

    static func phoneNumberCheck(_ text: String) -> Bool {
        return text.characters.count >= 5
    }

    static func passwordCheck(_ text: String) -> Bool {
        return text.characters.count >= 6 && text.characters.count <= 16
    }

    static func sioeyeIdCheck(_ text: String) -> Bool {
//        return text.characters.count >= 3
        let count = text.characters.count
        if count > 15 || count < 4 {
            return false
        }
        let sioidReg = "[A-Z0-9a-z_+]"
        let idTest = NSPredicate(format:"SELF MATCHES %@", sioidReg)
        let res = idTest.evaluate(with: text)
        return res
    }

    static func phoneSMSCodeCheck(_ code: String) -> Bool {
        return code.characters.count == verifyCodeLengt
    }

    static func illegalCharacterCheck(_ text: String) -> Bool {
        let pattern = "[/\\[\\]\":;|<>+=,?*／【】：；，？＜＞［］＋＝｜“”＊]"
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let res = regex.firstMatch(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.characters.count))
        return res != nil
    }
}

enum InputError: Error {
    case illegalCharacter
}

extension InputError {
    var description: String {
        switch self {
        case .illegalCharacter:
            return "illegal character"

        }
    }
}
