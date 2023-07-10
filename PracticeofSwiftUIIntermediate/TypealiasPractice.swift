//
//  TypealiasPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/10/23.
//

import SwiftUI

struct MovieModel{
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasPractice: View {
    
//    @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    @State var item: TVModel = TVModel(title: "TV title", director: "Emily", count: 10)
    
    var body: some View {
        VStack{
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypealiasPractice_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasPractice()
    }
}
