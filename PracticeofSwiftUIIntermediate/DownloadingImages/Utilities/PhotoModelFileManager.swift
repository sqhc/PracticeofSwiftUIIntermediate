//
//  PhotoModelFileManager.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 8/4/23.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeed()
    }
    
    private func createFolderIfNeed() {
        guard let url = getFolderPath() else { return }
         
        if !FileManager.default.fileExists(atPath: url.path) {
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created Folder!")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    // .../download_photos/
    private func getFolderPath() -> URL? {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName)
    }
    
    // .../download_photos/image_name.png
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving to file manager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
     guard let url = getImagePath(key: key),
           FileManager.default.fileExists(atPath: url.path) else {
               return nil
           }
        
        return UIImage(contentsOfFile: url.path)
    }
}
