//
//  JsonExampleOnTVC.swift
//  JsonWithSwift4
//
//  Created by tben on 29.07.17|KW30.
//  Copyright © 2017 tben. All rights reserved.
//

import UIKit

class JsonExampleOnTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataWithURLSession()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Zeile \(indexPath.row)"

        return cell
    }
    
    private func getDataWithURLSession(){
        guard let url = URL(string: JSON_EXAMPLE_ONE_URL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //TODO: - check Error
            
            //TODO: - response Status 200 Ok
            
            self.convertDataToString(data: data)
        }.resume()
    }
    
    private func convertDataToString(data: Data?) {
        guard let data = data else {return}
        
        let dataAsString = String(data: data, encoding: .utf8)
        
        print(dataAsString)
    
    }
}
