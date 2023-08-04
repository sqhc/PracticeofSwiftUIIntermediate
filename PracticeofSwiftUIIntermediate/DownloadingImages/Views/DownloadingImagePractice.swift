//
//  DownloadingImagePractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/31/23.
//

import SwiftUI

// Codable
// background threads
// weak self
// Combine
// Publishers and Subscribers
// FileManger
// NSCache

struct DownloadingImagePractice: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagePractice_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagePractice()
    }
}
