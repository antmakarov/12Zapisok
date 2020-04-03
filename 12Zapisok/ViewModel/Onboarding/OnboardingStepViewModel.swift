//
//  OnboardingStepViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

import Foundation

protocol OnboardingStepViewModeling {
    func title() -> String
    func details() -> String
    func image() -> String
    func actionTitle() -> String
    func isHideSkipButton() -> Bool
    func isNeedAnswerButtons() -> Bool
    func performAction(action: OnboardingAction, actionCompletion: (() -> Void)?)
}

class OnboardingStepViewModel {
    
    private let stepTitle: String
    private let stepDetails: String
    private let stepImage: String
    private let stepActionTitle: String
    private let isHideSkip: Bool
    private let isNeedAnswer: Bool
    private let action: (OnboardingAction, (() -> Void)?) -> Void

    init(title: String, details: String, image: String, actionTitle: String, isHideSkip: Bool = false, isNeedAnswer: Bool = false, action: (@escaping (OnboardingAction, (() -> Void)?) -> Void)) {
        stepTitle = title
        stepDetails = details
        stepImage = image
        stepActionTitle = actionTitle
        self.isHideSkip = isHideSkip
        self.isNeedAnswer = isNeedAnswer
        self.action = action
    }
}

extension OnboardingStepViewModel: OnboardingStepViewModeling {
    func title() -> String {
        return stepTitle
    }
    
    func details() -> String {
        return stepDetails
    }
    
    func image() -> String {
        return stepImage
    }
    
    func actionTitle() -> String {
        return stepActionTitle
    }
    
    func isHideSkipButton() -> Bool {
        return isHideSkip
    }
    
    func isNeedAnswerButtons() -> Bool {
        return isNeedAnswer
    }
    
    func performAction(action: OnboardingAction, actionCompletion: (() -> Void)?) {
        self.action(action, actionCompletion)
    }
}
