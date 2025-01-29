//
//  ApiManager.swift
//  newyorktimes
//
//  Created by Hector Moreno on 28/01/25.
//

import Foundation

final class ApiManager {


	private let apiKey = "Fv4sT6Km56a1GG35S6GJROZeRXv9RTmp"
	private let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2/"
	private let parameters = [ "api-key" : "Fv4sT6Km56a1GG35S6GJROZeRXv9RTmp"]


	func getMostViewedBy(period: Int, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
		var urlComponents = URLComponents(string: "\(baseUrl)viewed/\(period).json")
		urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
		
		guard let url = urlComponents?.url else { return }
		let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}
			if let data = data {
				do {
					let convertedData = try JSONDecoder().decode(ResponseModel.self, from: data)
					completion(.success(convertedData))
				} catch let error {
					completion(.failure(error))
				}
			}
		}
		task.resume()
	}

		//	func getMostEmailedBy(period: Int) {
		//		let url = URL(string: "\(baseUrl)emailed/\(period).json")
		//	}
		//
		//	func getMostSharedOnFacebookBy(period: Int) {
		//		let url = URL(string: "\(baseUrl)shared/\(period)/facebook.json")
		//	}
		//
		//	func getMosShaedBy(period: Int) {
		//		let url = URL(string: "\(baseUrl)shared/\(period).json")
		//	}

}
