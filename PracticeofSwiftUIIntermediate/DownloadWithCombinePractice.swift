//
//  DownloadWithCombinePractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 7/13/23.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject{
    
    @Published var posts: [PostModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{
            return
        }
        
        // Combine discussion:
        /*
        // 1. sign uo for monthly suscription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. recieve the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item
        // 7. cancellable at any time
        
        // 1. create the publisher
        // 2. subscribe puslisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
//            .tryMap { (data, response) -> Data in
//                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink { completion in
                switch completion{
                case .finished:
                    print("Finished!")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
            } receiveValue: { [weak self] returnPosts in
                self?.posts = returnPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombinePractice: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombinePractice_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombinePractice()
    }
}
