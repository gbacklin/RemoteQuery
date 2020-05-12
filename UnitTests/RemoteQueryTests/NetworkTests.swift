//
//  NetworkTests.swift
//  RemoteQueryTests
//
//  Created by Gene Backlin on 5/12/20.
//  Copyright © 2020 Gene Backlin. All rights reserved.
//

import UIKit

class NetworkTests: NSObject {
    func fetchData(url: String, completion: @escaping (_ data: [Person]?, _ error: Error?) -> Void) {

        // Fetch data...
        Network.sharedInstance.getJSON(url: url) {(responseData, error) in
            if error != nil {
                completion(nil, error)
            } else {
                let decoder = JSONDecoder()
                do {
                    let persons = try decoder.decode([Person].self, from: responseData!)
                    DispatchQueue.main.async {
                        completion(persons, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }
    }

}
