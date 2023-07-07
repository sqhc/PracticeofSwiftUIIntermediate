//
//  CoreDataRelationshipsPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/6/23.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context : NSManagedObjectContext
    
    private init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save(){
        do{
            try context.save()
            print("Saved Successfully")
        } catch let error{
            print("Error saving Core Data: \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject{
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init(){
        getBusiness()
        getDepartment()
        getEmployees()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
//        newBusiness.departments = [departments[0], departments[1]]
        
        // add existing employees to the new busineess
//        newBusiness.employees = [employees.last!]
        
        // add new business to existing department
        //newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
        //newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        //newDepartment.employees = [employees.last!]
        newDepartment.addToEmployees(employees.last!)
        save()
    }
    
    func addEmployee(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.date_joned = Date()
        newEmployee.name = "John"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    func getBusiness(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        
//        let predicate = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = predicate
        
        do{
         businesses = try manager.context.fetch(request)
        } catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func getDepartment(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do{
         departments = try manager.context.fetch(request)
        } catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do{
         employees = try manager.context.fetch(request)
        } catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do{
         employees = try manager.context.fetch(request)
        } catch let error{
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    func updateBusiness(){
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    func deleteDepartment(){
        let department = departments[2]
        manager.context.delete(department)
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusiness()
            self.getDepartment()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationshipsPractice: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20){
                    Button {
                        vm.deleteDepartment()
//                        vm.getEmployees(forBusiness: vm.businesses[0])
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }

                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.businesses){ business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.departments){ department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top){
                            ForEach(vm.employees){ employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipsPractice_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsPractice()
    }
}

struct BusinessView: View{
    
    let entity: BusinessEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let departments = entity.departments?.allObjects as? [DepartmentEntity]{
                Text("Departments:")
                    .bold()
                ForEach(departments){ department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees")
                    .bold()
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View{
    
    let entity: DepartmentEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Businesses:")
                    .bold()
                ForEach(businesses){ business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees")
                    .bold()
                ForEach(employees){ employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View{
    
    let entity: EmployeeEntity
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.date_joned ?? Date())")
            
            Text("Business:")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
