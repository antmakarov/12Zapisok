//
//  OnboardingStepViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 08.12.2019.
//  Copyright © 2019 A.Makarov. All rights reserved.
//

protocol OnboardingStepViewModeling {
    func title() -> String
    func details() -> String
    func image() -> String
    func actionTitle() -> String
    func isHideSkipButton() -> Bool
    func isNeedAnswerButtons() -> Bool
    func performAction(action: OnboardingAction, actionCompletion: (() -> Void)?)
}

final class OnboardingStepViewModel {
    
    private let stepTitle: String
    private let stepDetails: String
    private let stepImage: String
    private let stepActionTitle: String
    private let isHideSkip: Bool
    private let isNeedAnswer: Bool
    private let action: (OnboardingAction, (() -> Void)?) -> Void

    init(title: String,
         details: String,
         image: String,
         actionTitle: String,
         isHideSkip: Bool = false,
         isNeedAnswer: Bool = false,
         action: (@escaping (OnboardingAction, (() -> Void)?) -> Void)) {
        stepTitle = title
        stepDetails = details
        stepImage = image
        stepActionTitle = actionTitle
        self.isHideSkip = isHideSkip
        self.isNeedAnswer = isNeedAnswer
        self.action = action
    }
}

// MARK: - OnboardingStepViewModeling Public Methods

extension OnboardingStepViewModel: OnboardingStepViewModeling {
    public func title() -> String {
        return stepTitle
    }
    
    public func details() -> String {
        return stepDetails
    }
    
    public func image() -> String {
        return stepImage
    }
    
    public func actionTitle() -> String {
        return stepActionTitle
    }
    
    public func isHideSkipButton() -> Bool {
        return isHideSkip
    }
    
    public func isNeedAnswerButtons() -> Bool {
        return isNeedAnswer
    }
    
    public func performAction(action: OnboardingAction, actionCompletion: (() -> Void)?) {
        self.action(action, actionCompletion)
    }
}
