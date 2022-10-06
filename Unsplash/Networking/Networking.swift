//
//  NetworkService.swift
//  Unsplash
//
//  Created by Шамиль Моллачиев on 06.10.2022.
//

import Foundation

protocol NetworkingProtocol {
    
}

class Networking: NetworkingProtocol {

    func fetchModels(completion: @escaping([PhotoModel]?) -> Void) {
        let urlString = "https://api.unsplash.com/photos/random/?count=10&client_id=9_x587DuHw9DllgT4tNfNTY3V8LrB6Ny92D5LiKAjmI#"
        fetchData(urlString: urlString, responce: completion)
    }
    
    func fetcImage(from pictureModel: PhotoModel, response: @escaping(Data?) -> Void) {
        guard let urlString = pictureModel.urls?.small else { return }
        requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                response(data)
            case .failure(let error):
                response(nil)
                print("No photos" + error.localizedDescription)
            }
        }
    }
    
    private func fetchData<T: Decodable> (urlString: String, responce: @escaping (T?) -> Void) {
        requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let decoded = self.decodeJSON(type: T.self, from: data)
                responce(decoded)
            case .failure(let error):
                print("Error received reuestiong data: \(error.localizedDescription)")
                responce(nil)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
    
    private func requestData(urlString: String, complition: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _ , error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                }
                guard let data = data else { return }
                complition(.success(data))
            }
        }
        .resume()
    }
}
