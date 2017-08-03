//
//  JsonMovieTVC.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import UIKit

class JsonMovieTVC: UITableViewController {
    
    var newMovies:[Movie] = []
    var newAssets:[Asset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataWithURLSession()
        
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newAssets.count //newMovies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonMovieCell", for: indexPath)
        
        // Configure the cell...
//        cell.textLabel?.text = "Movie id: \(newMovies[indexPath.row].id)" +
//        "Assets: \(newMovies[indexPath.row].assets)"
        
        cell.textLabel?.text = "\(newAssets[indexPath.row].accessibilityLabel)  \(newAssets[indexPath.row].timeOfDay)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toMovie" {
            let movieController = segue.destination as? MovieVC
            if let indexPath = tableView.indexPathForSelectedRow {
                if let asset = newAssets[indexPath.row] as? Asset {
                    movieController?.movieURL = asset.url
                    movieController?.movieLabel = asset.accessibilityLabel
                }
            }
        }
    }
    
    
    
    private func getDataWithURLSession(){
        guard let url = URL(string: JSON_MOVIES) else {return}
        
        let urlSession = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //TODO: - check Error
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
            //TODO: - response Status 200 Ok
            
            //Swift 4
            self.decodeJson(data: data)
        }
        urlSession.resume()
    }
    
    private func decodeJson(data:Data?) {
        guard let data = data else {return}

        do {
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            
            for movie in movies {
                newMovies.append(movie)
                
                for asset in movie.assets {
                    newAssets.append(asset)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } catch let jsonError {
            //TODO: - ErrorHandling
            print(jsonError.localizedDescription as Any)
        }
    }
}
