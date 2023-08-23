import Foundation
import SwiftUI

struct DataStructureContentView: View {
    @ObservedObject var viewModel: DataStructureViewModel = DataStructureViewModel()
    @State private var isNewStackCreated: Bool = false
    @State private var showExplanation: Bool = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var buttonScale1: CGFloat = 1.0
    @State private var buttonScale2: CGFloat = 1.0
    @State private var buttonScale3: CGFloat = 1.0
    @State private var buttonScale4: CGFloat = 1.0
    @State private var buttonScale5: CGFloat = 1.0
    @State private var buttonScale6: CGFloat = 1.0
    @State private var buttonScale7: CGFloat = 1.0


    var body: some View {
        ZStack {
            // Applied the background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    Text("DataStructure Visualizer")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .padding()

                    Menu {
                        ForEach(DataStructureType.allCases, id: \.self) { type in
                            Button(action: {
                                viewModel.selectedDataStructure = type
                            }) {
                                Text(type.rawValue)
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedDataStructure.rawValue)
                                .foregroundColor(.primary)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
                    }
                    .padding(.horizontal)

                    if viewModel.selectedDataStructure == .stack {
                        TextField("Enter number", text: $viewModel.userInput)
                            .padding()
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(8))
                            .keyboardType(.numbersAndPunctuation)
                            .padding(.horizontal)

                        operationButtonsStack()
                            .padding()
                    }

                    if viewModel.selectedDataStructure == .linkedList {
                        TextField("Enter number", text: $viewModel.userInput)
                            .padding()
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(8))
                            .keyboardType(.numbersAndPunctuation)
                            .padding(.horizontal)

                        linkedListButtonsStack()
                            .padding()
                    }

                    if !viewModel.steps.isEmpty {
                        Text(viewModel.steps[viewModel.currentStepIndex].explanation)
                            .padding()
                            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(13))
                            .transition(.slide)
                            .onAppear { showExplanation = true }
                            .onDisappear { showExplanation = false }
                            .opacity(showExplanation ? 1 : 0)
                    }

                    DataStructureVisualizerView(elements: !viewModel.steps.isEmpty ? viewModel.steps[viewModel.currentStepIndex].elements : viewModel.elements, dataStructureType: viewModel.selectedDataStructure)
                        .padding()
                }
                .padding()
            }
            
        }
    }
    
    @ViewBuilder
    func operationButtonsStack() -> some View {
        HStack(spacing: 20) {
            Button("New") {
                withAnimation {
                    viewModel.performOperation(operation: .new)
                    isNewStackCreated = true
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: true))
            .scaleEffect(buttonScale)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("Push") {
                withAnimation {
                    viewModel.performOperation(operation: .push)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: !viewModel.userInput.isEmpty))
            .scaleEffect(buttonScale1)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale1 = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("Pop") {
                withAnimation {
                    viewModel.performOperation(operation: .pop)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: viewModel.selectedDataStructure == .stack ? !(viewModel.dataStructure as! Stack).isEmpty() : false))
            .scaleEffect(buttonScale2)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale2 = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("IsEmpty") {
                withAnimation {
                    viewModel.performOperation(operation: .isEmpty)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: isNewStackCreated))
            .scaleEffect(buttonScale3)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale3 = pressing ? 0.9 : 1.0
            }, perform: {})
        }
    }

    @ViewBuilder
    func linkedListButtonsStack() -> some View {
        HStack(spacing: 20) {
            Button("Search") {
                if let value = Int(viewModel.userInput) {
                    viewModel.performLinkedListOperation(operation: .search, value: value)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: !viewModel.userInput.isEmpty))
            .scaleEffect(buttonScale4)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale4 = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("Insert") {
                if let value = Int(viewModel.userInput) {
                    viewModel.performLinkedListOperation(operation: .insert, value: value)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: !viewModel.userInput.isEmpty))
            .scaleEffect(buttonScale5)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale5 = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("Delete") {
                if let value = Int(viewModel.userInput) {
                    viewModel.performLinkedListOperation(operation: .delete, value: value)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: !viewModel.userInput.isEmpty))
            .scaleEffect(buttonScale6)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale6 = pressing ? 0.9 : 1.0
            }, perform: {})

            Button("DeleteSent") {
                if let value = Int(viewModel.userInput) {
                    viewModel.performLinkedListOperation(operation: .deleteSent, value: value)
                }
            }
            .buttonStyle(CustomButtonStyle(isEnabled: !viewModel.userInput.isEmpty))
            .scaleEffect(buttonScale7)
            .onLongPressGesture(minimumDuration: 0, pressing: { pressing in
                buttonScale7 = pressing ? 0.9 : 1.0
            }, perform: {})
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(VisualEffectView(effect: UIBlurEffect(style: .light)).cornerRadius(10))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(isEnabled ? 1.0 : 0.3)
            .scaleEffect(isEnabled ? 0.95 : 1)
    }
}
