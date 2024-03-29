//
//  NetworkManager.swift
//  Intervk
//
//  Created by Andrei Kovryzhenko on 28.03.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlServices = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func getServices(completion: @escaping ([Service]) -> Void) {
        guard let url = URL(string: urlServices) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            
            if let servicesData = try? JSONDecoder().decode(ServiceModel.self, from: data) {
                DispatchQueue.main.async {
                    completion(servicesData.body.services)
                }
            }
        }
            task.resume()
    }
}

