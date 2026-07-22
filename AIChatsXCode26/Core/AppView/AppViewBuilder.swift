import SwiftUI

struct AppViewBuilder<TabBarView: View, OnboardingView: View>: View {
  let showTabBar: Bool
  @ViewBuilder var tabBarView: TabBarView
  @ViewBuilder var onboardingView: OnboardingView

  var body: some View {
    ZStack {
      if showTabBar {
        tabBarView
          .transition(.move(edge: .trailing))
      } else {
        onboardingView
          .transition(.move(edge: .leading))
      }
    }
    .animation(.easeInOut, value: showTabBar)
  }
}

private struct PreviewView: View {
  @State var showTabBar: Bool = false

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
    .onTapGesture {
      showTabBar.toggle()
    }
  }
}

// tabBarView
#Preview {
  PreviewView(showTabBar: true)
}

// onboardingView
#Preview {
  PreviewView(showTabBar: false)
}
