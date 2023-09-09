//
//  TabBar.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

let backgroundColor = Color.init(white: 0.92)

struct TabBar: View {
    @Binding var showSignInView: Bool
    @State private var selectedTab: Tab = .main
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
                switch selectedTab {
                case .main:
                    MainView()
                case .beTrainerAdd:
                    BeTrainerAddView()
                case .settings:
                    SettingsView(showSignInView: $showSignInView)
                }
                
                TabBarView1(selectedTab: $selectedTab)
            }
            .padding(.horizontal)
        }
    }
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(showSignInView: .constant(false))
    }
}


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case main, beTrainerAdd, settings
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .main:
            return "house.fill"
        case .beTrainerAdd:
            return "person.badge.plus"
        case .settings:
            return "gear"
        }
    }
}
