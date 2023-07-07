//
//  WeakSelfPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/7/23.
//

import SwiftUI

struct WeakSelfPractice: View {
    
    @AppStorage("count") var count: Int?
    
    init(){
        count = 0
    }
    
    var body: some View {
        NavigationView{
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
            .navigationTitle("Screen1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            ,alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View{
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View{
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data{
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject{
    
    @Published var data: String? = nil
    
    init(){
        print("Initialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit{
        print("Detinitialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData(){
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!!"
        }
        
    }
}

struct WeakSelfPractice_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfPractice()
    }
}
