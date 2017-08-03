//
//  MovieVC.swift
//  JsonWithSwift4
//
//  Created by tben on 01.08.17.
//  Copyright © 2017 tben. All rights reserved.
//

import AVFoundation
import UIKit
import AVKit

class MovieVC: UIViewController {
    
    var movieLabel:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movieLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
