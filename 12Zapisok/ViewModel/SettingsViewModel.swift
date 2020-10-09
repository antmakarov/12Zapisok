//
//  SettingsViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 18.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

protocol SettingsViewModeling: AnyObject {
    var closeButtonPressed: (() -> Void)? { get set }
}

final class SettingsViewModel {
    public var closeButtonPressed: (() -> Void)?

}

extension SettingsViewModel: SettingsViewModeling {
    
}
