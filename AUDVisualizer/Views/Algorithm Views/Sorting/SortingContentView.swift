import SwiftUI

struct SortingContentView: View {
    @ObservedObject var viewModel: SortViewModel = SortViewModel()
    @State private var buttonScale: CGFloat = 1.0
    @State private var buttonScale1: CGFloat = 1.0
    @State private var previousButtonScale: CGFloat = 1.0
    @State private var nextButtonScale: CGFloat = 1.0
    @State private var hasStartedAlgorithm: Bool = false
    @State private var isUIHidden: Bool = false
    @State private var showExplanation: Bool = false



    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer(minLength: (geometry.size.height - contentHeight) / 2) // Push content to the center

                        // Title
                        Text("Sorting Visualizer")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .padding()
                        

                        if isUIHidden {
                            HStack {
                                Button("Back") {
                                    resetToInitialState()
                                }
                                .padding(20)
                                .foregroundColor(.white)
                                .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
                                .scaleEffect(buttonScale1)
                                .onTapGesture {
                                    resetToInitialState()
                                    buttonScale1 = 1.0
                                }
                                .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                                    buttonScale1 = pressing ? 0.9 : 1.0
                                }, perform: {})
                            }
                        }
                        
                        if !isUIHidden {
                            // Algorithm Picker
                            Menu {
                                ForEach(AlgorithmType.allCases, id: \.self) { type in
                                    Button(action: {
                                        viewModel.selectedAlgorithm = type
                                    }) {
                                        Text(type.rawValue)
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(viewModel.selectedAlgorithm.rawValue)
                                        .foregroundColor(.primary)
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
                            }
                            .padding(.horizontal)

                            // Input Field and Random Number Generator
                            HStack {
                                TextField("Enter numbers", text: $viewModel.userInput)
                                    .padding()
                                    .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(8))
                                    .keyboardType(.numbersAndPunctuation)
                                
                                Button(action: {
                                    viewModel.generateRandomNumbers()
                                }) {
                                    Image(systemName: "arrow.triangle.branch")
                                        .padding(10)
                                        .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(15))
                                        .foregroundColor(.blue)
                                }
                                .scaleEffect(buttonScale)
                                    .onTapGesture {
                                        viewModel.generateRandomNumbers()
                                        buttonScale = 1.0
                                    }
                                    .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                                        buttonScale = pressing ? 0.9 : 1.0
                                    }, perform: {})
                            }
                            .padding(.horizontal)
                            
                            // Start Button
                            Button("Start algorithm") {
                                viewModel.parseUserInput()
                                viewModel.sort()
                                hasStartedAlgorithm = true
                                isUIHidden = true
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
                            .scaleEffect(buttonScale1)
                            .onTapGesture {
                                viewModel.parseUserInput()
                                viewModel.sort()
                                hasStartedAlgorithm = true
                                isUIHidden = true
                                buttonScale1 = 1.0
                            }
                            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                                buttonScale1 = pressing ? 0.9 : 1.0
                            }, perform: {})
                        }

                        

                        // Step-by-Step Mode Toggle
                        if hasStartedAlgorithm {
                            Toggle("Step-by-Step Mode", isOn: $viewModel.stepByStepMode)
                                .padding()
                                .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
                        }

                        // Conditional Step-by-Step UI
                        if viewModel.stepByStepMode && !viewModel.steps.isEmpty {
                            VStack(spacing: 15) {
                                Text(viewModel.steps[viewModel.currentStepIndex].explanation)
                                    .padding()
                                    .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(13))
                                    .transition(.slide)
                                    .onAppear { showExplanation = true }
                                    .onDisappear { showExplanation = false }
                                    .opacity(showExplanation ? 1 : 0)

                                HStack(spacing: 20) {
                                    Button("Previous Step") {
                                        viewModel.previousStep()
                                    }
                                    .disabled(viewModel.currentStepIndex == 0)
                                    .buttonStyle(CustomButtonStyle(isEnabled: viewModel.currentStepIndex != 0))
                                    
                                    .scaleEffect(previousButtonScale)
                                        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                                            previousButtonScale = pressing ? 0.9 : 1.0
                                        }, perform: {})

                                    Button("Next Step") {
                                        viewModel.nextStep()
                                    }
                                    .disabled(viewModel.currentStepIndex == viewModel.steps.count - 1)
                                    .buttonStyle(CustomButtonStyle(isEnabled: viewModel.currentStepIndex != viewModel.steps.count - 1))
                                    
                                    .scaleEffect(nextButtonScale)  // Ensure we're using the nextButtonScale for the Next Step button
                                        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                                            nextButtonScale = pressing ? 0.9 : 1.0
                                        }, perform: {})
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                        }

                        
                        // Visualization
                        SortVisualizerView(numbers: viewModel.stepByStepMode && !viewModel.steps.isEmpty ? viewModel.steps[viewModel.currentStepIndex].array : viewModel.sortedArray)
                        
                        Spacer(minLength: (geometry.size.height - contentHeight) / 2) // Push content to the center

                    }
                    .padding()
                }
            }
        }
    }
    
    var contentHeight: CGFloat {
         // Sum of estimated heights of your components
         return 500 // Adjust this value based on your content
    }
    
    func resetToInitialState() {
            isUIHidden = false
            viewModel.stepByStepMode = false
            hasStartedAlgorithm = false
            viewModel.currentStepIndex = 0  // Assuming you have this in your viewModel to reset the step index
        }
}
