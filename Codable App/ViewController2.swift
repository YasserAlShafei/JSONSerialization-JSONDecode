//
//  ViewController2.swift
//  JSONSerialization App
//
//  Created by Yasser Al-ShaFei on 19/06/2022.
//

import UIKit



struct Response: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makePOSTRequest()
    }
    
    
    
    // GET, POST, PUT, DELETE, etc.
    func makePOSTRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        print("Making api call..")
        var request = URLRequest(url: url)
        
        // method, body, headers
        request.httpMethod = "POST"
        //request.timeoutInterval = 20
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId": 1,
            "title": "Hello from Hi There",
            "body": "OOh Nooo Yess Faa ss s s s s ss.",
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONDecoder().decode(Response.self, from: data)
                print("SUCCESS \(response)")
            } catch { print(error) }
            
        }
        task.resume()
    }
    
}
