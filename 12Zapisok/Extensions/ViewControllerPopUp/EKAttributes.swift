//
//  EKAttributes.swift
//  12Zapisok
//
//  Created by Anton Makarov on 05.10.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import SwiftEntryKit

func appearAttributes() -> EKAttributes {
    
    var attributes = EKAttributes.centerFloat
    attributes.displayDuration = .infinity
    attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
    attributes.shadow = .active(
        with: .init(
            color: .black,
            opacity: 0.3,
            radius: 8
        )
    )
    
    attributes.screenInteraction = .dismiss
    attributes.entryInteraction = .absorbTouches
    attributes.scroll = .enabled(
        swipeable: true,
        pullbackAnimation: .jolt
    )
    
    attributes.entranceAnimation = .init(
        translate: .init(
            duration: 0.7,
            spring: .init(damping: 1, initialVelocity: 0)
        ),
        scale: .init(
            from: 1.05,
            to: 1,
            duration: 0.4,
            spring: .init(damping: 1, initialVelocity: 0)
        )
    )
    
    attributes.exitAnimation = .init(
        translate: .init(duration: 0.2)
    )
    attributes.popBehavior = .animated(
        animation: .init(
            translate: .init(duration: 0.2)
        )
    )
    
    attributes.positionConstraints.verticalOffset = 10
    attributes.statusBar = .dark
    return attributes
}
