//
//  RotationGesturePractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/25/23.
//

import SwiftUI

struct RotationGesturePractice: View {
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        angle = Angle(degrees: 0)
                    })
            )
    }
}

struct RotationGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        RotationGesturePractice()
    }
}
