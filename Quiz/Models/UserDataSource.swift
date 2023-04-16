//
//  UserDataSource.swift
//  Quiz
//
//  Created by Ulas Uysal on 16.04.2023.
//

import Foundation
class UserDataSource {
    private var cityArray: [User] = []
    private let baseURL = "https://quiz-12349-default-rtdb.europe-west1.firebasedatabase.app/.json"
    var delegate: UserDataDelegate?
    
    init(){
        }
    /*func getListOfCities(){
        let session = URLSession.shared
        if let url = URL(string: "\(baseURL)"){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data{
                    let decoder = JSONDecoder()
                    //let jsondata = try! decoder.decode(User.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.userListLoaded()
                    }
                }
            }
            dataTask.resume()
        }
        }*/
    func getNumberOfCities() -> Int {
        return cityArray.count
    }
    
    func getCity(for index:Int) -> User? {
        guard index < cityArray.count else {
            return nil
        }
        
        return cityArray[index]
    }
}

