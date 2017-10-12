//
//  RegisterConfigure.swift
//  SPA
//
//  Created by alvin zheng on 16/8/1.
//  Copyright © 2016年 alvin. All rights reserved.
//

import Foundation
import UIKit

enum SioeyeStep {
    case regMenue
    case wechatLogin
    case weiboLogin
    case qqLogin
    case login
    case phoneRegist
    case phoneCodeSend
    case phoneCodeValidate
    case emailRegist
    case creatPassword
    case createName
    case recommandFriends
    case complete
    case cancel
}

extension SioeyeStep: ChainAble {
    var nextStep: SioeyeStep? {
        switch self {
        case .regMenue:
            return .phoneRegist
        case .login:
            return .complete
        case .phoneRegist:
            return .phoneCodeSend
        case .phoneCodeSend:
            return .phoneCodeValidate
        case .phoneCodeValidate:
            return .creatPassword
        case .emailRegist:
            return .creatPassword
        case .creatPassword:
            return .createName
        case .createName:
            return .recommandFriends
        case .recommandFriends:
            return .complete
        case .wechatLogin, .weiboLogin, .qqLogin:
            return .complete
        case .complete:
            return nil
        case .cancel:
            return nil
        }
    }

    var previouseStep: SioeyeStep? {
        switch self {
        case .phoneCodeSend:
            return .phoneRegist
        case .phoneCodeValidate:
            return .phoneRegist
        case .createName:
            return .creatPassword
        case .recommandFriends:
            return .complete
        case .complete:
            return nil
        case .cancel:
            return nil
        case .creatPassword:
            // can be PhoneRegist or Email Regist, should manul set this action,
            //this is just a default value
            return .regMenue
        default:
            return .regMenue
        }
    }
}


class LoginGuider: NSObject {

    typealias TransFormAction = (_ from: SioeyeStep, _ to: SioeyeStep) -> Void
    typealias BeginAction = (_ begin: SioeyeStep) -> Void

    fileprivate var actor: SioeyeAction<SioeyeStep>!
    var driver: SioeyeDriver<SioeyeStep, SioeyeAction<SioeyeStep>>?

    var navVC: UINavigationController!
    fileprivate var showedInVC: UIViewController?

    override init() {
        super.init()
        let transation: TransFormAction = self.transation
        let beginAct: BeginAction = self.onBegin
        actor = SioeyeAction<SioeyeStep>(transFormAction: transation, beginAction: beginAct)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func beginWithViewController(_ showedInVC: UIViewController, success: ResultPlugin? = nil, cancel: ResultPlugin? = nil) {
        self.showedInVC = showedInVC
        driver = SioeyeDriver<SioeyeStep, SioeyeAction<SioeyeStep>>(step:SioeyeStep.regMenue, actor:actor)
        if success != nil {
            successPlugin = success
        }
        if cancel != nil {
            cancelPlugin = cancel
        }
    }

    // MARK: model
    var signupModel: SignupModel?

    // custom plugin, 添加额外操作
    typealias ResultPlugin = () -> Void

    var successPlugin: ResultPlugin?
    var cancelPlugin: ResultPlugin?

    var isFirstLogin = false
}



// MARK: register
extension LoginGuider {
    func register(_ handle: @escaping (_ result: Bool, _ errorInfo: String?) -> Void) {
        guard signupModel != nil else {
            handle(false, "sign model not exsist")
            return
        }
        // do register logic.
        let result = true
        let error: String? = nil
        if result {
            self.handleRegisterSuccess(true)
            handle(true, nil)
        } else {
            handle(false, "\(error)")
        }
    }

    func handleRegisterSuccess(_ isThird: Bool) {
        //对注册成功做一些集中处理
    }
}

// MARK: Register Transation
extension LoginGuider {
    //界面转换
    fileprivate func transation(_ from: SioeyeStep, to: SioeyeStep) {
        switch to {
        case .regMenue:
            self.onBegin(.regMenue)

        case .login:
            let vc = UIViewController()
            vc.title = "login"
            self.navVC.pushViewController(vc, animated: true)

        case .phoneRegist:
            let vc = UIViewController()
            vc.title = "phone register"
            self.navVC.pushViewController(vc, animated: true)

        case .phoneCodeSend:
            let vc = UIViewController()
            vc.title = "phone code send"
            self.navVC.pushViewController(vc, animated: true)

        case .phoneCodeValidate:
            let vc = UIViewController()
            vc.title = "phone code validate"
            self.navVC.pushViewController(vc, animated: true)

        case .emailRegist:
            let vc = UIViewController()
            vc.title = "email regist"
            self.navVC.pushViewController(vc, animated: true)

        case .creatPassword:
            let vc = UIViewController()
            vc.title = "create password"
            self.navVC.pushViewController(vc, animated: true)

        case .createName:
            let vc = UIViewController()
            vc.title = "create name"
            self.navVC.pushViewController(vc, animated: true)

        case .recommandFriends:
            let vc = UIViewController()
            vc.title = "recommand friends"
            self.navVC.pushViewController(vc, animated: true)

        case .complete:
            self.onComplete()

        case .cancel:
            self.onCancel()

        case .weiboLogin:
            break
        case .qqLogin:
            break
        case .wechatLogin:
            break
        }
    }

    //the begin action
    func onBegin(_ startStep: SioeyeStep) {
        guard startStep == .regMenue else {
            fatalError("sioeye register must begin with regmenue")
        }
        signupModel = SignupModel()
        guard navVC != nil else {

            let rootVC = UIViewController()
            navVC = UINavigationController.init(rootViewController: rootVC)
            navVC.interactivePopGestureRecognizer?.isEnabled = false
            self.showedInVC?.present(navVC, animated: true, completion: nil)
            return
        }
        _ = self.navVC?.popToRootViewController(animated: true)
    }

    // the complete action
    func onComplete() {
        self.navVC.dismiss(animated: false, completion: {
            self.successPlugin?()
            self.successPlugin = nil
            self.cancelPlugin = nil
            self.showedInVC = nil
        })
        //others ,notify, cache ,etc.
    }

    func onCancel() {
        self.navVC.dismiss(animated: true, completion: {
            self.cancelPlugin?()
            self.successPlugin = nil
            self.cancelPlugin = nil
            self.showedInVC = nil
        })
        //others ,notify, cache ,etc.
    }
}

// MARK: Test
extension LoginGuider {
    func testRun() {
        let delayTime = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            _ = self.driver?.gotoNext()
            self.testRun()
        }
    }
}
