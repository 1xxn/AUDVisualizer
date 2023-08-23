import Foundation
import SwiftUI

struct DataStructureVisualizerView: View {
    var elements: [Int]
    var head: Int?
    var dataStructureType: DataStructureType

    var body: some View {
        if dataStructureType == .stack {
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(elements.indices, id: \.self) { index in
                    let value = elements[index]
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(value > 0 ? Color.blue.opacity(0.6) : Color.gray.opacity(0.6))  // Reduced opacity for translucence
                            .frame(height: 30)
                            .cornerRadius(5)  // Added corner radius for a refined look
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 1, y: 1)  // Added shadow for depth
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0), value: value)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(5))  // Added corner radius to the background as well

                        Text(value > 0 ? "\(value)" : "")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))  // Reduced opacity for the text
                            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 0)  // Added shadow to the text for better readability
                            .padding(.bottom, 5)
                    }
                    .frame(height: 30)
                }
            }
        } else if dataStructureType == .linkedList {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Head: \(elements.first ?? 0)")
                                .font(.footnote)
                                .foregroundColor(.white)
                            ForEach(elements.indices, id: \.self) { index in
                                let value = elements[index]
                                VStack(alignment: .leading) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.blue)
                                            .frame(width: 60, height: 25) // Adjusted width
                                        Text("\(value)")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                    HStack {
                                        Text("Next: \(index < elements.count - 1 ? "\(elements[index + 1])" : "nil")")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Prev: \(index == 0 ? "nil" : "\(elements[index - 1])")")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 5) // Adjusted padding
                            }
                        }
                        .padding(.horizontal, 5)
                    }
                }
            }
        }
