//
//  ScrollViewReaderPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/27/23.
//

import SwiftUI

struct ScrollViewReaderPractice: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFiedText : String = ""
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFiedText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                withAnimation(.spring()){
                    if let index = Int(textFiedText){
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView{
                ScrollViewReader { proxy in
                    
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()){
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderPractice_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderPractice()
    }
}
