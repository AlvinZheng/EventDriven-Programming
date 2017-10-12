//
//  ForgetPwdGuider.swift
//  Sioeye
//
//  Created by alvin zheng on 16/8/9.
//  Copyright © 2016年 Sioeye Inc. All rights reserved.
//

import Foundation
import UIKit

enum ForgetStep {
    case byEmail
    case byPhone
    case phoneCodeSend
    case phoneCodeValidate
    case resetPassword
    case complete
    case cancel
}

extension ForgetStep: ChainAble {
    var nextStep: ForgetStep? {
        switch self {
        case .byEmail:
            return .complete
        case .byPhone:
            return .phoneCodeSend
        case .phoneCodeSend:
            return .phoneCodeValidate
        case .phoneCodeValidate:
            return .resetPassword
        case .resetPassword:
            return .complete

        case .complete:
            return nil

        case .cancel:
            return nil
        }
    }

    var previouseStep: ForgetStep? {
        switch self {
        case .byEmail:
            return .cancel
        case .byPhone:
            return .cancel
        case .phoneCodeSend:
            return .byPhone
        case .phoneCodeValidate:
            return .byPhone
        case .resetPassword:
            return .byPhone

        case .complete:
            return nil

        case .cancel:
            return nil
        }
    }
}

struct ForgetPwdModel {
    var email: String?
    var phone: String?
    var verifyCode: String?
    var newPassword: String?
}

class ForgetPwsGuider: NSObject {
    typealias TransFormAction = (_ from: ForgetStep, _ to: ForgetStep) -> Void
    typealias BeginAction = (_ begin: ForgetStep) -> Void

    fileprivate var actor: SioeyeAction<ForgetStep>!
    fileprivate var model: ForgetPwdModel!

    var driver: SioeyeDriver<ForgetStep, SioeyeAction<ForgetStep>>?

    var navVC: UINavigationController!
    fileprivate var rootVC: UIViewController?

    override init() {
        super.init()
        model = ForgetPwdModel()
        let transation: TransFormAction = self.transation
        let beginAct: BeginAction = self.onBegin
        actor = SioeyeAction<ForgetStep>(transFormAction: transation, beginAction: beginAct)
    }

    func beginWithViewController(_ nvController: UINavigationController?) {
        navVC = nvController
        rootVC = navVC?.topViewController
        driver = SioeyeDriver<ForgetStep, SioeyeAction<ForgetStep>>(step:ForgetStep.byEmail, actor:actor)
    }
}

// MARK: Transation
extension ForgetPwsGuider {
    fileprivate func transation(_ from: ForgetStep, to: ForgetStep) {
        switch to {
        case .byEmail:
            self.onBegin(.byEmail)

        case .byPhone:
            break

        case .phoneCodeSend:
            break

        case .phoneCodeValidate:
            break

        case .resetPassword:
            break

        case .complete:
            self.onComplete()

        case .cancel:
            self.onCancel()

        }

    }

    func onBegin(_ startStep: ForgetStep) {
        guard startStep == .byEmail else {
            fatalError("sioeye register must begin with regmenue")
        }
        guard navVC != nil else {
            return
        }
        model = ForgetPwdModel()
//        self.navVC?.pushViewController(emailVC, animated: true)
    }

    func onComplete() {
        if rootVC != nil {
            _ = self.navVC?.popToViewController(rootVC!, animated: true)
        } else {
            self.navVC?.dismiss(animated: true, completion: {})
        }
    }

    func onCancel() {
        if rootVC != nil {
            _ = self.navVC?.popToViewController(rootVC!, animated: true)
        } else {
            self.navVC?.dismiss(animated: true, completion: {})
        }
    }
}

/*
// MARK: Controller Action delegate
extension ForgetPwsGuider: EmailSetViewControllerAction {
    func onEmailSetCancel() {
        _ = driver?.gotoPreviouse()
    }

    func onSwitchToPhoneSet() {
        model?.email = nil
        _ = driver?.gotoStep(.byPhone)
    }

    func onEmailSetSuccess(_ email: String) {
        //TODO emial rest
        model?.email = email
        let eml = email
        let currentVC = navVC?.topViewController as? BaseViewController
        currentVC?.showProgressHUD()
        Cloud.sharedInstance.resetPasswordFromEmail(eml) { (response) in
            currentVC?.dismissProgressHUD()
            switch response {
            case .success(_):
                _ = self.driver?.gotoNext()
                if let topVC = self.navVC?.topViewController as? BaseViewController {
                    topVC.showHUDToast(R.string.localizable.loginViewResetPasswordByEmailSucces())
                }
            case .failure(let err):
                lError("\(err)")
                if let emailSetVC = self.navVC?.topViewController as? EmailSetViewController {
                    emailSetVC.setView.showRemind(err.description)
                }
            }
        }
    }
}

extension ForgetPwsGuider: PhoneSetViewControllerAction {
    func onPhoneSetContinue(_ phone: String) {
        model?.phone = phone
        _ = driver?.gotoNext()
    }

    func onPhoneSetCancel() {
        _ = driver?.gotoPreviouse()
    }

    func onSwitchToEmail() {
        model?.phone = nil
        _ = driver?.gotoStep(.byEmail)
    }
}

extension ForgetPwsGuider: PhoneSendValidateAction {
    func onPhoneSendValidateNext() {
        _ = driver?.gotoNext()
    }
    func onPhoneSendValidateCancel() {
        _ = driver?.gotoPreviouse()
    }
}

extension ForgetPwsGuider: PhoneValidateAction {
    func onPhoneValidateSuccess(_ code: String) {
        model?.verifyCode = code
        _ = driver?.gotoNext()
    }

    func onPhoneValidateCancel() {
        _ = driver?.gotoPreviouse()
    }
}

extension ForgetPwsGuider: PasswordSetViewControllerAction {
    func onPasswordSetCancel() {
        _ = driver?.gotoPreviouse()
    }

    func onPasswordSetSuccess(_ password: String) {
        model?.newPassword = password
        Cloud.sharedInstance.resetPassword(model.phone!, newPassword: model.newPassword!, verifyCode: model.verifyCode!) { (response) in
            switch response {
            case .success(_):
                _ = self.driver?.gotoNext()
                if let topVC = self.navVC?.topViewController as? BaseViewController {
                    topVC.showHUDToast(R.string.localizable.loginViewPassWordChanged())
                }
            case .failure(let err):
                lError("\(err)")
                if let topVC = self.navVC?.topViewController as? BaseViewController {
                    topVC.showHUDToast(err.description)
                }
            }
        }
    }
}*/
