//
//  GenericRegister.swift
//  SPA
//
//  Created by alvin zheng on 16/8/2.
//  Copyright © 2016年 alvin. All rights reserved.
//
//StepDriver 适用于逻辑比较复杂，并且是逻辑是按步骤执行的情况，这种情况通常比较合适的方法是用"事件"去驱动程序逻辑，因此，我们只要定义好了
//各个步骤，并且各个步骤的先后顺序，和相应步骤对应的逻辑和界面转换，那么整个程序也就完成.
//而且可以减少各个步骤，以及步骤对应的逻辑和程序组件的耦合关系，
//对于步骤的顺序改变，等也可以做比较小的修改就可以适应，便于扩展和维护。还可以在整体的视角下掌握所有的步骤流程。同时也便于写测试用例。
//此组件包括几个部分：
//ChainAble: 定义基本的步骤step
//StepAction: 定义对特定步骤切换的响应
//StepDriver: 驱动step，并连接step和stepAction.
//SioeyeDriver: StepDriver 的一个默认实现
//SioeyeAction: StepAction 的一个默认实现

import Foundation


/*
 define the step chain,
 the step drives the ui, and logic.
 the chain confirmed ,the logic were confirmed too.
 use this can not change the step logic customize, because the 
 step is unknown,and the order of the step is confirmed.
 just can backward or forword the chain.
 */
enum StepChain<Element> {
    case empty
    case node(pre:Element, Element, next: Element)
    case cancel
    case complete
}



/*
 simple define of the chain ,the step conform this protocol
 can be a simple chain.
 and use this, user can step out the chain to other chain.
 such as details in StepDriver.gotoStep()
 */
protocol ChainAble: Equatable {
    var nextStep: Self? { get }

    var previouseStep: Self? { get }
}

/*
 descriction of step
 */
protocol StepPresentation {
    var stepName: String { get }
    var stepDescription: String { get }
}

/*
 define the logic ,or ui change,when step value changed,

 */
protocol StepAction {
    associatedtype StepType

    func willChangeToStep(_ step: StepType, from: StepType)
    func didChangeToStep(_ step: StepType)
    func shouldLeaveStep(_ step: StepType) -> Bool

    func begin(_ step: StepType)
}


/*
 the driver ,which used to drive step change,
 then let the Actor to do logic or ui change based on step chain.
 */
protocol StepDriver {

    associatedtype Actor = StepAction
    associatedtype Value = ChainAble

    //actor will do logic and ui change, when current step changed
    var actor: Actor { get }

    //indicated the current step in the step chain
    var currentStep: Value { get set }

    // step through the chain in default action.
    mutating func gotoNext() -> Value
    mutating func gotoPreviouse() -> Value

    // step to other step costom, sometime we should broken the chain,and step to other stepes customize.
    mutating func gotoStep(_ step: Value) -> Value
}


/*
 define default action of actor ,when step change.
 */
extension StepDriver where Actor: StepAction, Value: ChainAble, Actor.StepType == Value {

    mutating func gotoNext() -> Value {

        guard let nextObj = currentStep.nextStep else {
            return currentStep
        }

        if actor.shouldLeaveStep(currentStep) {
            actor.willChangeToStep(nextObj, from: currentStep)
            currentStep = nextObj
            actor.didChangeToStep(currentStep)
        }

        return currentStep
    }

    mutating func gotoPreviouse() -> Value {
        guard let pre = currentStep.previouseStep else {
            return currentStep
        }
        if actor.shouldLeaveStep(currentStep) {
            actor.willChangeToStep(pre, from: currentStep)
            currentStep = pre
            actor.didChangeToStep(currentStep)
        }
        return currentStep
    }

    mutating func gotoStep(_ step: Value) -> Value {
//        guard currentStep != step else {
//            return currentStep
//        }
        if actor.shouldLeaveStep(currentStep) {
            actor.willChangeToStep(step, from: currentStep)
            currentStep = step
            actor.didChangeToStep(currentStep)
        }
        return currentStep
    }

}


/*
 an implement of Step Driver
 */
struct SioeyeDriver< T: ChainAble, A: StepAction>: StepDriver where A.StepType == T {
    fileprivate var sioeyeStep: T
    fileprivate var sioeyeActor: A
    var currentStep: T {
        get {
            return sioeyeStep
        }
        set {
            sioeyeStep = newValue
        }
    }
    var actor: A {
        return sioeyeActor
    }
    init(step: T, actor: A) {
        sioeyeActor = actor
        sioeyeStep = step
        sioeyeActor.begin(sioeyeStep)
    }
}


/*
 an implement of stepAction
 */
struct SioeyeAction<T>: StepAction {

    typealias StepType = T

    func willChangeToStep(_ step: StepType, from: StepType) {
        print("sioeye step: will change to: \(step)")
        transFormAction(from, step)
    }

    func didChangeToStep(_ stepto: StepType) {
        print("sioeye step: did change to : \(stepto)")
    }

    func shouldLeaveStep(_ step: StepType) -> Bool {
        return true
    }

    func begin(_ step: StepType) {
        beginAction(step)
    }

    typealias TransFormAction = (_ from: StepType, _ to: StepType) -> Void
    typealias BeginAction = (_ begin: StepType) -> Void

    var transFormAction: TransFormAction
    var beginAction: BeginAction
    
}
