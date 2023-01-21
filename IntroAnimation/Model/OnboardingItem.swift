//
//  OnboardingItem.swift
//  IntroAnimation
//
//  Created by Berkay Disli on 20.01.2023.
//

import Foundation
import Lottie

struct OnboardingItem: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var subtitle: String
    var lottieView: LottieAnimationView = .init()
}
