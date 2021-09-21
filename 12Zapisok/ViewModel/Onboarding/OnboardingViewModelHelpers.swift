//
//  OnboardingViewModelHelpers.swift
//  12Zapisok
//
//  Created by Anton Makarov on 21.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import Foundation

extension OnboardingViewModel {

    // MARK: Types of pages

    enum OnbordingItem: CaseIterable {
        case details
        case location
        case city
        case auth
    }

    // MARK: Onboarding step content

    enum Constants {
        enum Details {
            static let title = Localized.onboardingGoChildhood
            static let details = Localized.onboardingGoChildhoodDsc
            static let action = Localized.next
            static let image = Asset.Icons.Onboarding.childhood.name
        }

        enum Location {
            static let title = Localized.onboardingAccessGeo
            static let details = Localized.onboardingAccessGeoDsc
            static let action = Localized.allow
            static let image = Asset.Icons.Onboarding.requestLocation.name
        }

        enum City {
            static let details = Localized.onboardingRightCity
            static let image = Asset.Icons.Onboarding.guessCity.name
        }

        enum CityList {
            static let title = Localized.onboardingChooseCity
            static let details = Localized.onboardingAccessGeoDenied
            static let action = Localized.chooseCity
            static let image = Asset.Icons.Onboarding.cityList.name
        }

        enum Auth {
            static let title = Localized.onboardingLeadProgress
            static let details = Localized.onboardingAuthDsc
            static let action = Localized.onboardingAuth
            static let image = Asset.Icons.Onboarding.auth.name
        }
    }
}
