import SwiftUI

struct SortVisualizerView: View {
    var numbers: [Int]
    let maxNumbers: Int
    
    init(numbers: [Int]) {
        self.numbers = numbers
        self.maxNumbers = numbers.max() ?? 1
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(numbers.indices, id: \.self) { index in
                    let barHeight = CGFloat(numbers[index]) / CGFloat(maxNumbers) * (geometry.size.height - 10) // adjust bar height based on parent view height
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(height: barHeight)
                            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 1, y: 1)
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: barHeight)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)))

                        Text("\(numbers[index])")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 0)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
        .frame(height: 120) // adjust height of entire SortVisualizerView
    }
}
