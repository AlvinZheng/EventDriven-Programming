//
//  SioeyeRegisterControllerAction.swift
//  Sioeye
//
//  Created by alvin zheng on 16/8/8.
//  Copyright © 2016年 Sioeye Inc. All rights reserved.
//


//响应每个步骤controller的事件， 用来驱动流程
/*
import Foundation

extension LoginGuider: MenuViewControllerAction {
    func onWeiboLogin() {
        _ = driver?.gotoStep(SioeyeStep.weiboLogin)
    }

    func onQQLogin() {
        _ = driver?.gotoStep(SioeyeStep.qqLogin)
    }

    func onWechatLogin() {
        _ = driver?.gotoStep(SioeyeStep.wechatLogin)
    }

    func onClose() {
        _ = driver?.gotoStep(SioeyeStep.cancel)
    }

    func onSignup() {
        _ = driver?.gotoNext()
    }

    func onLogin() {
        _ = driver?.gotoStep(SioeyeStep.login)
    }
}

extension LoginGuider: PhoneSetViewControllerAction {
    func onPhoneSetContinue(_ phone: String) {
        signupModel?.phone = phone
        _ = driver?.gotoNext()
    }

    func onPhoneSetCancel() {
        signupModel?.phone = nil
        _ = driver?.gotoPreviouse()
    }
    func onSwitchToEmail() {
        signupModel?.phone = nil
        _ = driver?.gotoStep(SioeyeStep.emailRegist)
    }
}

extension LoginGuider: LoginViewControllerAction {
    func onLoginCancel() {
        _ = driver?.gotoPreviouse()
    }
    func onLoginSuccess() {
        _ = driver?.gotoNext()
    }
}

extension LoginGuider: PhoneSendValidateAction {
    func onPhoneSendValidateNext() {
        _ = driver?.gotoNext()
    }
    func onPhoneSendValidateCancel() {
        _ = driver?.gotoPreviouse()
    }
}

extension LoginGuider: PhoneValidateAction {
    func onPhoneValidateSuccess(_ code: String) {
        signupModel?.phoneSMCode = code
        _ = driver?.gotoNext()
    }

    func onPhoneValidateCancel() {
        signupModel?.phoneSMCode = nil
        _ = driver?.gotoPreviouse()
    }
}

extension LoginGuider: EmailSetViewControllerAction {
    func onEmailSetCancel() {
        signupModel?.email = nil
        _ = driver?.gotoPreviouse()
    }

    func onSwitchToPhoneSet() {
        signupModel?.email = nil
        _ = driver?.gotoStep(SioeyeStep.phoneRegist)
    }

    func onEmailSetSuccess(_ email: String) {
        signupModel?.email = email
        _ = driver?.gotoNext()
    }
}

extension LoginGuider: PasswordSetViewControllerAction {
    func onPasswordSetCancel() {
        signupModel?.password = nil
        if signupModel?.phone != nil {
            _ = driver?.gotoStep(.phoneRegist)
        } else {
            _ = driver?.gotoStep(.emailRegist)
        }
    }

    func onPasswordSetSuccess(_ password: String) {
        signupModel?.password = password
        _ = driver?.gotoNext()
    }
}

extension LoginGuider: NameSetViewControllerAction {

    func onNameSetSuccess(_ nickName: String) {
        signupModel?.nickName = nickName
        register { (result, errorInfo) in
            if result {
                _ = self.driver?.gotoNext()
            } else {
                if let errorInfo = errorInfo {
                    (self.navVC.topViewController as? BaseViewController)?.showAlert(errorInfo)
                }
            }
        }
    }

    func onNameSetCancel() {
        signupModel?.nickName = nil
        _ = driver?.gotoPreviouse()
    }
}

extension LoginGuider: RecommandViewControllerAction {
    func onRecommandFinish() {
        _ = driver?.gotoNext()
    }

    func onRecommandCancel() {
        _ = driver?.gotoNext()
    }
}

extension LoginGuider: ThirdLoginAction {
    func onThirdLoginSuccess(isFirstLogin isFirst: Bool) {
        isThirdLoginProcess = false
        thirdLoginGuider = nil
        if isFirst {
            _ = driver?.gotoStep(.recommandFriends)
            handleRegisterSuccess(true)
        } else {
            _ = driver?.gotoNext()
        }
        dismissLoading()
    }
    func onThirdLoginFailed(_ errorInfo: String?) {
        isThirdLoginProcess = false
        dismissLoading()
        thirdLoginGuider = nil
        _ = driver?.gotoPreviouse()
    }
    func onThirdLoginCancel() {
        isThirdLoginProcess = false
        dismissLoading()
        thirdLoginGuider = nil
        _ = driver?.gotoPreviouse()
    }
}*/
