import Foundation
import SwiftUI

struct InitialView: View {
    @State private var selection: Int = 0
    @State private var showSplash = true

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all)
            
            if showSplash {
                SplashScreen()
                    .transition(.opacity) // Apply a simple fade-in/out animation
                    .animation(.easeInOut(duration: 1.0), value: showSplash)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                TabView(selection: $selection) {
                    SortingContentView()
                        .tabItem {
                            Label("Sorting Algorithms", systemImage: "arrow.up.arrow.down")
                        }
                        .tag(0)
                    
                    DataStructureContentView()
                        .tabItem {
                            Label("Data Structures", systemImage: "cube.box")
                        }
                        .tag(1)
                }
                .background(VisualEffectView(effect: UIBlurEffect(style: .light)))
                .edgesIgnoringSafeArea(.all)
            }
        }
        .transition(.move(edge: .trailing))
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showSplash = false
            }
        }
    }
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            InitialView()
        }
    }
}

