//
//  MultipleSheetsPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/28/23.
//

import SwiftUI

struct RandomModel: Identifiable{
    let id = UUID().uuidString
    let title: String
}

// 1 - use a binding
// 2 - use multiple sheets
// 2 - use $item

struct MultipleSheetsPractice: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ForEach(0..<50) { index in
                    Button("Button \(index)"){
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
                
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: selectedModel)
//        }
    }
}

struct NextScreen: View{
    
    let selectedModel: RandomModel
    
    var body: some View{
        Text("\(selectedModel.title)")
            .font(.largeTitle)
    }
}

struct MultipleSheetsPractice_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsPractice()
    }
}
