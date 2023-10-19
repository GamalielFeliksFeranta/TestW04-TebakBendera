//
//  ContentView.swift
//  TestW04
//
//  Created by Christian on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    
    @State private var correctAnswer = 0
    @State private var wrongAnswer = 0
    @State private var showingResult = false
    @State private var userScore = 0
    @State private var questionNumber = 1
    @State private var usedFlags = [String]()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Pilih Bendera ")
                    .foregroundColor(.white)
                Text(asean[correctAnswer])
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Benar : \(userScore)")
                    .foregroundColor(.white)
                Text("Salah : \(wrongAnswer)")
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        ForEach(0..<5) { number in
                            Button(action: {
                                flagTapped(number)
                            }) {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width: 80, height: 50)
                            }
                            .padding(.vertical)
                        }
                    }
                    Spacer()
                    
                    VStack {
                        ForEach(5..<10) { number in
                            Button(action: {
                                flagTapped(number)
                            }) {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width:  80, height: 50)
                                }
                            .padding(.vertical)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        
        .alert(isPresented: $showingResult) {
            Alert(
                title: Text(alertTitle()),
                message: Text("\nBenar: \(userScore) \n Salah: \(wrongAnswer)"),
                dismissButton: .default(Text("Tutup")) {
                    if questionNumber < 10 {
                        askQuestion()
                    } else {
                        resetGame()
                    }
                }
            )
        }
    }
    
    func resetGame() {
        correctAnswer = Int.random(in: 0..<asean.count)
        wrongAnswer = 0
        userScore = 0
        questionNumber = 1
        usedFlags.removeAll()
    }
    
    func flagTapped(_ number: Int) {
        let selectedFlag = asean[number]
        
        if number == correctAnswer {
            userScore += 1
        } else {
            wrongAnswer += 1
        }
        
        questionNumber += 1
        usedFlags.append(selectedFlag)
        
        if questionNumber <= 10 {
            askQuestion()
        } else {
            showingResult = true
        }
    }
    
    func alertTitle() -> String {
        return "Ini adalah hasil skor akhir"
    }
    
    func askQuestion() {
        var availableFlags = asean.filter { !usedFlags.contains($0) }
        
        if let newIndex = availableFlags.firstIndex(of: asean[correctAnswer]) {
            availableFlags.remove(at: newIndex)
        }
        
        if let newCorrectAnswer = availableFlags.randomElement() {
            correctAnswer = asean.firstIndex(of: newCorrectAnswer)!
        } else {
            resetGame()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






//VStack{
//    Button("Submit", role: .cancel ,action: printConsole)
//        .buttonStyle(.bordered)
//        
//    Button("Delete", role: .destructive){
//        alertShown = true
//    } .alert("BAHAYA", isPresented: $alertShown){
//        Button("Wah!", role: .cancel) {}
//        Button("Kabor!", role: .destructive) {}
//    } message: {
//        Text("Mangga dibaca")
//    }
//        .buttonStyle(.borderedProminent)
//        
//    
//    
//    Button{
//        print("Coba")
//    } label: {
//        Text("Compose")
//        Image(systemName: "mail")
//    }
//    .buttonStyle(.bordered)
//}
