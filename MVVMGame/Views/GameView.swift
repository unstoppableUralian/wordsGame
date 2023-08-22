//
//  GameView.swift
//  MVVMGame
//
//  Created by Русинов Евгений on 09.08.2023.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    
    var viewModel: GameViewModel
    
    @State private var confirmPresented = false
    @State private var isAlertPresented = false
    @State private var alertText = ""
    @State private var opacityOfList = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                HStack {
                    Button {
                        confirmPresented.toggle()
                        opacityOfList = 0
                    } label: {
                        Text("Выход")
                            .padding(6)
                            .padding(.horizontal)
                            .background(Color("Orange"))
                            .cornerRadius(12)
                            .padding(6)
                            .foregroundColor(.white)
                            .font(.custom("AvenirNext-Bold", size: 18))
                    }
                    Spacer()
                }
            }
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 36))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player1.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ?.red : .clear, radius: 4, x: 0, y: 0)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewModel.player2.name)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .clear : .purple, radius: 4, x: 0, y: 0)
            }
            
            WordsTextField(word: $word, placeholder: "Ваше слово...")
                .padding(.horizontal)
            
            Button {
                
                var score = 0
                
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                   alertText = "Это слово уже было!"
                   isAlertPresented.toggle()
                } catch WordError.littleWord {
                    alertText = "Слишком короткое слово!"
                    isAlertPresented.toggle()
                } catch WordError.theSameWord {
                    alertText = "Нельзя использовать исходное слово"
                    isAlertPresented.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составлено"
                    isAlertPresented.toggle()
                } catch {
                    alertText = "Неизвестная ошибка!"
                    isAlertPresented.toggle()
                }
                if score > 1 {
                    word = ""
                    opacityOfList = 1
                }
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 26))
                    .padding(.horizontal)
            }
            
            List {
                ForEach(0..<self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer") : Color("SecondPlayer"))
                        .listRowInsets(EdgeInsets())
                }
                
                
            }
            .listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(opacityOfList)
            
        }
            .background(Image("background"))
            .confirmationDialog("Вы уверены что хотите завершить игру?", isPresented: $confirmPresented, titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
        
                } label: {
                    Text("Да")
                }
                Button(role: .cancel) {
                    
                } label: {
                    Text("Нет")
                }
                

            }
            .alert(alertText, isPresented: $isAlertPresented) {
                Text("OK")
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Вася"), player2: Player(name: "Федя"), word: "Рекогносцировка"))
    }
}
