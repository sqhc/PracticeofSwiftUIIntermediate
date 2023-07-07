//
//  BackgroundThreadPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/7/23.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData(){
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check 2: \(Thread.isMainThread)")
                print("Check2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String]{
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadPractice: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadPractice_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadPractice()
    }
}
