//
//  SignupModel.swift
//  Sioeye
//
//  Created by alvin zheng on 16/8/8.
//  Copyright © 2016年 Sioeye Inc. All rights reserved.
//

import Foundation

// MARK: signup  model
struct SignupModel {
    var phone: String? {
        didSet {
            guard phone != nil else {
                return
            }
            email = nil
            phoneSMCode = nil
        }
    }
    var phoneSMCode: String?
    var email: String? {
        didSet {
            guard email != nil else {
                return
            }
            phone = nil
            phoneSMCode = nil
        }
    }
    var nickName: String?
    var password: String?
}
