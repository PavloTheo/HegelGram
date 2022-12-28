//
//  SplashScreen.swift
//  InstaFilter2
//
//  Created by Pavlo Theodoridis on 2022-12-08.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            StartView()
        } else {
            VStack {
                VStack {
                    Image(systemName: "hare.fill")
                    //Image("Hegel1")
                        .font(.system(size: 80))
                        .foregroundColor(Color("HegelColor2"))
                    Text("HegelGram")
                        .font(Font.custom("PT Serif Caption", size: 26))
                        .foregroundColor(Color("HegelColor2").opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
