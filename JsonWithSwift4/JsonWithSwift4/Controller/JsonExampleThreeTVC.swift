//
//  JsonExampleThreeTVC.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import UIKit

class JsonExampleThreeTVC: UITableViewController {
    var newCourse:[CourseThree] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataWithURLSession()
        
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newCourse.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCellThree", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Course id: \(newCourse[indexPath.row].id)" +
        "Cours Name: \(newCourse[indexPath.row].name)"
        
        return cell
    }
    
    private func getDataWithURLSession(){
        guard let url = URL(string: JSON_EXAMPLE_THREE_URL) else {return}
        
        let urlSession = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //TODO: - check Error
            
            //TODO: - response Status 200 Ok
            
            //Swift 4
            self.decodeJson(data: data)
        }
        urlSession.resume()
    }
    
    private func decodeJson(data:Data?) {
        guard let data = data else {return}
        dump(data)
        do {
            let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
            for course in websiteDescription.courses {
                newCourse.append(course)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch let jsonError {
            //TODO: - ErrorHandling
        }
    }

}
