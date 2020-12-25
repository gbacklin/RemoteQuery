//
//  RESTManager.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import Foundation

let PERSON_QUERY = "http://www.ehmz.org/ajax/ajax_query.php"

public class PersonQueryManager: ObservableObject {
    @Published var objects = [Person]()
    
    init() {
        fetchPersons()
    }
    
    func fetchPersons() {
        if let url = URL(string: PERSON_QUERY) {
            URLSession.shared.dataTask(with: url) {(data,response,error) in
                do {
                    if let d = data {
                        let decodedLists = try JSONDecoder().decode([Person].self, from: d)
                        DispatchQueue.main.async {
                            self.objects = decodedLists
                        }
                    } else {
                        print("No Data")
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            print("Error")
        }
    }
}
