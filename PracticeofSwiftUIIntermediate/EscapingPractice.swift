//
//  EscapingPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/10/23.
//

import SwiftUI

class EscapingViewModel: ObservableObject{
    
    @Published var text: String = "Hello"
    
    func getData(){
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
        
        
    }
    
    func downloadData() -> String{
        return "New Data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void){
        completionHandler("New Data!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data : String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingPractice: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingPractice_Previews: PreviewProvider {
    static var previews: some View {
        EscapingPractice()
    }
}
