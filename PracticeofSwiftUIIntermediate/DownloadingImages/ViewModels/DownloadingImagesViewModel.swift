//
//  DownloadingImagesViewModel.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/31/23.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject{
    
    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink {[weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
