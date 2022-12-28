//
//  Colors.swift
//  HegelGram
//
//  Created by Pavlo Theodoridis on 2022-12-19.
//

import SwiftUI

struct Colors: View {
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25.0)
            
                .fill(Color("HegelColor1"))
                .frame(width: 300, height: 200)
            
            Text("TEST")
                .font(.largeTitle)
                .foregroundColor(Color("HegelColor2"))
            
        }
            
        
        
    }
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        Colors()
    }
}
