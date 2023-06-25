//
//  MagnificationGesturePractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/25/23.
//

import SwiftUI

struct MagnificationGesturePractice: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Circle().frame(width: 35, height: 35)
                Text("Swiftful thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring()){
                                currentAmount = 0
                            }
                        })
                )
            HStack{
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged({ value in
//                        currentAmount = value - 1
//                    })
//                    .onEnded({ value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    })
//            )
    }
}

struct MagnificationGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGesturePractice()
    }
}
