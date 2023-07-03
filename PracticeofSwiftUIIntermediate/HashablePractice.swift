//
//  HashablePractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/3/23.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashablePractice: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four"),
        MyCustomModel(title: "Five")
    ]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashablePractice_Previews: PreviewProvider {
    static var previews: some View {
        HashablePractice()
    }
}
