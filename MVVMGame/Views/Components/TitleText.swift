//
//  TitleText.swift
//  MVVMGame
//
//  Created by Русинов Евгений on 07.08.2023.
//

import SwiftUI

struct TitleText: View {
    
    @State var text = ""
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .frame(maxWidth: .infinity)
            .background(Color("FirstPlayer"))
            .foregroundColor(Color.white)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Магнитотерапия")
    }
}
