//
//  FrameSheet.swift
//  HegelGram
//
//  Created by Pavlo Theodoridis on 2022-12-19.
//

import SwiftUI

struct FrameSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State var imageNames: [String]
    
    @Binding var selectFrame : String?
    
    var body: some View {
        VStack {
            Text("FRAME")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .onTapGesture {
                                selectFrame = imageName
                                dismiss()
                            }
                    }
                }
            }
        }
        
    }
}

struct FrameSheet_Previews: PreviewProvider {
    static var previews: some View {
        FrameSheet(imageNames: ["Frame1", "Frame2", "Frame3", "Dark Guillotine"], selectFrame: .constant(nil))
    }
}
