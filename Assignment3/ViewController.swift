//
//  ViewController.swift
//  Assignment3
//
//  Created by Brad Payne on 1/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet   var currentTimeLabel: UILabel!;
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        //  Get the current date and format it
        //  Format is Wed, 28 Dec 2022 14:59:00
        var currentTime:Date = Date();
        let dateFormatter:DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "E, d MMM Y HH:mm:ss"
        self.currentTimeLabel.text = dateFormatter.string(from: currentTime);
        
        
    }


}

