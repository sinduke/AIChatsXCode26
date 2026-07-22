//
//  AppView.swift
//  AIChatsXCode26
//
//  Created by sinduke on 7/20/26.
//

import SwiftUI

struct AppView: View {
  @AppStorage("showTabBar") var showTabBar: Bool = false
  var body: some View {
    AppViewBuilder(
      showTabBar: showTabBar,
      tabBarView: {
        ZStack {
          Color.red.ignoresSafeArea()
          Text("Tab Bar View")
            .font(.largeTitle)
            .foregroundColor(.white)
        }
      },
      onboardingView: {
        ZStack {
          Color.blue.ignoresSafeArea()
          Text("Onboarding View")
            .font(.largeTitle)
            .foregroundColor(.white)
        }
      }
    )
  }
}

#Preview("Show Tab Bar") {
  AppView(showTabBar: true)
}

#Preview("Show Onboarding") {
  AppView(showTabBar: false)
}
