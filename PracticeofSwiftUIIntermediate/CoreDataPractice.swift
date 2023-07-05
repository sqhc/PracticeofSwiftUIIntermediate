//
//  CoreDataPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/5/23.
//

import SwiftUI
import CoreData

// View = UI
// Model - data point
// ViewModel - manages the data for a view

class CoreDataViewModel: ObservableObject{
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error Loading Core Data: \(error)")
            } else{
                print("Successfully loaded Core Data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do{
            savedEntities = try container.viewContext.fetch(request)
        } catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text: String){
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet){
        guard let index = indexSet.first else{ return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity){
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do{
            try container.viewContext.save()
            fetchFruits()
        } catch let error{
            print("Error saving: \(error)")
        }
    }
}

struct CoreDataPractice: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                List{
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "No fruit name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(.plain)
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataPractice_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataPractice()
    }
}
