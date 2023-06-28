//
//  MaskPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/28/23.
//

import SwiftUI

struct MaskPractice: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View{
        GeometryReader{ geometry in
            ZStack(alignment: .leading){
                Rectangle()
//                    .foregroundColor(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View{
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskPractice_Previews: PreviewProvider {
    static var previews: some View {
        MaskPractice()
    }
}
