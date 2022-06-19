//
//  ViewController.swift
//  Codable App
//
//  Created by Yasser Al-ShaFei on 21/02/2022.
//

import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }


    func getData(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postDictionary = ["userId": "55",
                              "title": "Hey there",
                              "body": "What are you doing this weekend"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: postDictionary, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                //let json = try decoder.decode(Response.self, from: data)
                print("SUCCESS \(json)")
            } catch { print(error)}
        }
        
        task.resume()
    }
}


