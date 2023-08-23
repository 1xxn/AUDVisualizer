import Foundation
import SwiftUI

struct SplashScreen: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            // Gradient background for a more refined look
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {  // Adjusted spacing for better layout
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)

                    Image("icon2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .scaleEffect(animate ? 1.1 : 1.0)  // Subtle scaling animation
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
                }

                Text("AUD Visualizer")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)  // Adjusted color for better readability
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)  // Shadow for more depth
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
