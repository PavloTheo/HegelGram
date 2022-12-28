//
//  StartView.swift
//  InstaFilter2
//
//  Created by Pavlo Theodoridis on 2022-12-08.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct StartView: View {
    
    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color("HegelColor1")
                
                VStack {
                    
                    /* Image("Hegel")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: 300, height: 300)
                     .cornerRadius(30)*/
                        
                    NavigationLink("Start", destination: ContentView())
                        .font(.headline)
                        .foregroundColor(Color("HegelColor1"))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("HegelColor2"))
                        .cornerRadius(10)
                        .shadow(color: Color("HegelColor2").opacity(0.8), radius: 10, x: 0.0, y: 10)
                        .buttonStyle(PressableButtonStyle())
                        .padding(40)
                    
                  }
                  .navigationTitle("Start")
                
                  //.navigationBarTitleDisplayMode(.automatic) (this will display as large but diminish to inline when scrolled.
                  //.navigationBarTitleDisplayMode(.inline)
                  //.navigationBarHidden(true)
            }
            //.ignoresSafeArea()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
