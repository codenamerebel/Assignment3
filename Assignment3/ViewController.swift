//
//  ViewController.swift
//  Assignment3
//
//  Created by Brad Payne on 1/18/23.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet   var currentTimeLabel: UILabel!;
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        //  Initiate the updates for the clock.  It should trigger every second
        //  It actually has a little wiggle room and isn't exact but it's close enough
        //  for the GUI
        Timer.scheduledTimer(timeInterval:1.0, target:self, selector: #selector(self.UpdateCurrentTime), userInfo:nil, repeats: true);
        
    }

    @objc   func UpdateCurrentTime()
    {
        //  Get the current date and format it
        //  Format is Wed, 28 Dec 2022 14:59:00
            
        let currentDate = Date();
        let dateFormatter:DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "E, d MMM Y HH:mm:ss";
        self.currentTimeLabel.text = dateFormatter.string(from: currentDate);

        
        //  Honestly I know there are ways to do this with the actual Date
        //  but I hate dealing with dates or NSdate (Obj C) so I went the cheap way!
        let dateHourFormatter:DateFormatter = DateFormatter();
        dateHourFormatter.dateFormat = "HH";

        let hour:String = dateHourFormatter.string(from: currentDate)
      
        //  Need to update to change background picture
        if(Int(hour)! < 12)
        {
            print("AM")
            //  Check if background picture is currently the AM picture
            //  If it is not than switch
        }
        else
        {
            print("PM")
            //  Check if background picture is currently the PM picture
            //  If it is not than switch
        }

    }
    
    
    

}

