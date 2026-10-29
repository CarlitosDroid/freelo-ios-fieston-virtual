//
//  Color.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff, opacity: 1)

    }

    static let deep_purple_intense = Color("DeepPurpleIntense")
    static let aquamarine = Color("Aquamarine")
    static let orange_500 = Color("Orange500")
    static let amber_600 = Color("Amber600")
    static let deep_purple_500 = Color("DeepPurple500")
    static let deep_purple_700 = Color("DeepPurple700")
    static let material_white = Color("MaterialWhite")
    static let loginGradientStart = Color("LoginGradientStart")
    static let loginGradientMiddle = Color("LoginGradientMiddle")
    static let loginGradientEnd = Color("LoginGradientEnd")
    static let loginLogoPanel = Color("LoginLogoPanel")
    static let loginLogoBorder = Color("LoginLogoBorder")
    static let loginAccentYellow = Color("LoginAccentYellow")
    static let loginBrandYellow = Color("LoginBrandYellow")
    static let loginBrandTurquoise = Color("LoginBrandTurquoise")
    static let loginBrandPurple = Color("LoginBrandPurple")
    static let loginTextPrimary = Color("LoginTextPrimary")
    static let loginBadgeBackground = Color("LoginBadgeBackground")
    static let loginBadgeBorder = Color("LoginBadgeBorder")
    static let loginIconMuted = Color("LoginIconMuted")
    static let loginFieldBackground = Color("LoginFieldBackground")
    static let loginFieldBorder = Color("LoginFieldBorder")
    static let loginButtonText = Color("LoginButtonText")
    static let loginButtonBackground = Color("LoginButtonBackground")
    static let loginDivider = Color("LoginDivider")
    static let loginCardBackground = Color("LoginCardBackground")
    static let loginCardBorder = Color("LoginCardBorder")
    static let loginMutedText = Color("LoginMutedText")
    static let loginLink = Color("LoginLink")
    static let chatPink = Color("ChatPink")
    static let triviaTurquoise = Color(hex: "36FFC4")
    static let triviaYellow = Color(hex: "FFD000")
    static let triviaSelectedText = Color(hex: "071413")
    static let triviaMutedText = Color(hex: "D8D8DC")
    static let triviaQuestionText = Color(hex: "F2F1F4")
    static let triviaAnswerText = Color(hex: "E4E1E7")
    static let triviaOptionBackground = Color(hex: "101719")
    static let triviaCardBackground = Color(hex: "1A2224")
    static let rankingPrimaryText = Color(hex: "F7F5FA")
    static let rankingSecondaryText = Color(hex: "C3BBD3")
    static let rankingTurquoise = Color(hex: "36FFC4")
    static let rankingYellow = Color(hex: "FFD000")
    static let rankingPurple = Color(hex: "BBA7E8")
    static let rankingHeaderBackground = Color(hex: "151A24")
    static let rankingBadgeBackground = Color(hex: "27354A")
    static let rankingRowBackground = Color(hex: "25204D")
    static let rankingAvatarBackground = Color(hex: "202331")
    static let rankingMutedText = Color(hex: "AAA6B4")
    static let rankingSelectedText = Color(hex: "071413")
    static let rankingLeaderStart = Color(hex: "5A3D57")
}
