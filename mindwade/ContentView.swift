//
//  ContentView.swift
//  mindwade
//
//  Created by David D on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    let dataManager = DataManager.shared

    var body: some View {
        NavigationView {
            List(getRootFlashcards(), id: \.id) { flashcard in
                NavigationLink(destination: FlashcardDetail(flashcard: flashcard, dataManager: dataManager, allFlashcards: dataManager.anchorFlashcards)) {
                    Text(flashcard.title)
                        .font(.title)
                        .padding()
                        .background(Color.white)
                }
            }
            .navigationTitle("Mind Map Flashcards")
        }
    }

    // Helper function to get root flashcards (level 1)
    private func getRootFlashcards() -> [AnchorFlashcard] {
        return dataManager.anchorFlashcards.filter { $0.level == 1 }
    }
}

struct FlashcardDetail: View {
    let flashcard: AnchorFlashcard
    let dataManager: DataManager
    let allFlashcards: [AnchorFlashcard]

    var body: some View {
        VStack {
            Text(flashcard.title)
                .font(.title)
                .padding()

            Text(flashcard.details)
                .padding()

            if let children = getChildrenFlashcards() {
                List(children, id: \.id) { child in
                    NavigationLink(destination: FlashcardDetail(flashcard: child, dataManager: dataManager, allFlashcards: allFlashcards)) {
                        Text(child.title)
                            .font(.title)
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(flashcard.title)
    }

    // Helper function to get children flashcards based on parentID
    private func getChildrenFlashcards() -> [AnchorFlashcard]? {
        return allFlashcards.filter { $0.parentID == flashcard.id }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//// Flashcard data model
//struct Flashcard: Identifiable {
//    let id: Int
//    let question: String
//    let choices: [String]
//    let correctChoice: Int
//    let details: String
//}
//
//// Flashcard tree structure
//let flashcardTree: [Flashcard] = [
//    // Cerebrum
//    Flashcard(id: 1, question: "What is the outermost layer of the brain?", choices: ["Cerebrum", "Cerebellum", "Brainstem", "Meninges"], correctChoice: 0, details: "The cerebrum is the largest part of the brain, responsible for higher-order cognitive functions such as thinking, planning, and language."),
//
//    // Frontal Lobe
//    Flashcard(id: 2, question: "Which part of the cerebrum is responsible for producing movement?", choices: ["Frontal Lobe", "Parietal Lobe", "Occipital Lobe", "Temporal Lobe"], correctChoice: 0, details: "The frontal lobe is responsible for planning, controlling, and coordinating movement."),
//
//        // Broca's Area
//        Flashcard(id: 3, question: "What part of the frontal lobe is responsible for language production?", choices: ["Broca's Area", "Wernicke's Area", "Premotor Cortex", "Motor Cortex"], correctChoice: 0, details: "Broca's area is responsible for language production, including speech articulation and sentence formation."),
//
//        // Premotor Cortex
//        Flashcard(id: 4, question: "Which part of the frontal lobe is involved in planning and preparing movements?", choices: ["Broca's Area", "Wernicke's Area", "Premotor Cortex", "Motor Cortex"], correctChoice: 2, details: "The premotor cortex is involved in planning and preparing movements, coordinating muscle activity, and sequencing movements."),
//
//        // Motor Cortex
//        Flashcard(id: 5, question: "What part of the frontal lobe controls voluntary muscle contractions?", choices: ["Broca's Area", "Wernicke's Area", "Premotor Cortex", "Motor Cortex"], correctChoice: 3, details: "The motor cortex is responsible for controlling voluntary muscle contractions, sending neural signals to the spinal cord and muscles."),
//
//    // Parietal Lobe
//    Flashcard(id: 6, question: "Which part of the cerebrum is responsible for processing sensory information?", choices: ["Frontal Lobe", "Parietal Lobe", "Occipital Lobe", "Temporal Lobe"], correctChoice: 1, details: "The parietal lobe is responsible for processing sensory information, including touch, pressure, temperature, and pain."),
//
//        // Somatosensory Cortex
//        Flashcard(id: 7, question: "What part of the parietal lobe is responsible for processing touch, pressure, and temperature information?", choices: ["Homunculus", "Barrel Cortex", "Rolandic Area", "Somatosensory Association Cortex"], correctChoice: 2, details: "The Rolandic area is the primary somatosensory cortex, receiving sensory input from the entire body.")
//]
//
//
//
//class FlashcardViewModel: ObservableObject {
//    @Published var flashcard: Flashcard
//
//    init(flashcard: Flashcard) {
//        self.flashcard = flashcard
//    }
//    
//}
//
//struct FlashcardView: View {
//    @ObservedObject var viewModel: FlashcardViewModel
//
//    var body: some View {
//        ZStack{
//            mainColor.ignoresSafeArea()
//            VStack {
//                Text("\(viewModel.flashcard.id) / \(flashcardTree.count)")
//                    .font(.callout)
//                    .multilineTextAlignment(.leading)
//                    .padding()
//                Text(viewModel.flashcard.question)
//                    .font(.largeTitle)
//                    .bold()
//                    .multilineTextAlignment(.leading)
//                Spacer()
//                
////              This foreach loop generates the navigation links for
////                the current flashcard.
////                It makes sure not to proceed infinitely by halting
////                if you've reached the total number of
////                flashcards in the tree.
//                ForEach(0..<viewModel.flashcard.choices.count, id: \.self) { index in
//                    if index < flashcardTree.count - 1 {
//                        // Navigate to the next flashcard
//                        NavigationLink(
//                            destination: FlashcardView(viewModel: FlashcardViewModel(flashcard: flashcardTree[index + 1])),
//                            label: {
//                                FlashcardButton(text: viewModel.flashcard.choices[index])
//                            }
//                        )
//                    } else {
//                        // Display a "Finish" button for the last flashcard
//                        Button("Finish") {
//                            print("Reached the end of flashcards")
//                        }
//                        .font(.body)
//                        .bold()
//                        .multilineTextAlignment(.center)
//                        .padding()
//                        .border(Color.blue, width: 4)
//                    }
//                }
//                Spacer()
//            }
//            .foregroundColor(.white)
//            Spacer()
//        }
//       
//    }
//}
//
//struct FlashcardButton: View {
//    let text: String
//    
//    var body: some View {
//        Text(text)
//            .font(.body)
//            .bold()
//            .multilineTextAlignment(.center)
//            .padding()
//            .border(Color.blue, width: 4) // Customize the border color as needed
//    }
//}
//
//struct ContentView: View {
//    @ObservedObject private var viewModel: FlashcardViewModel
//
//    init() {
//        self._viewModel = ObservedObject(initialValue: FlashcardViewModel(flashcard: flashcardTree.first ?? Flashcard(id: 0, question: "Placeholder", choices: [], correctChoice: 0, details: "Placeholder Details")))
//    }
//
//    var body: some View {
//        NavigationView {
//            FlashcardView(viewModel: viewModel)
//                .navigationBarHidden(true)
//                
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
