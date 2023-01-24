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
    @IBOutlet   var countDownTimeLabel: UILabel!;
    @IBOutlet   var datePicker:UIDatePicker!;
    @IBOutlet   var startButton:UIButton!;
    @IBOutlet   var stopButton:UIButton!;
    
    
    var endTime: Date?;
    var countDownTimer: Timer?;
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //  Configure the stack items that hide based on what's running
        self.datePicker.isHidden = false;
        self.countDownTimeLabel.isHidden = true;
        self.stopButton.isHidden = true;
        self.startButton.isHidden = false;

        //  Initiate the updates for the clock.  It should trigger every second
        //  It actually has a little wiggle room and isn't exact but it's close enough
        //  for the GUI
        //  Would this be better to throw on a background thread?  Not really worth it at the moment, but would be worth looking into in the future
        self.UpdateCurrentTime()
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
         //   print("AM")
            //  Check if background picture is currently the AM picture
            //  If it is not than switch
        }
        else
        {
        //    print("PM")
            //  Check if background picture is currently the PM picture
            //  If it is not than switch
        }

    }
    
    
    func pressedTimerButton( _send: UIButton)
    {
        //  Check state of button
        
        
        
        //  If it's in the Start state, start timer and change to Stop
        //  Maybe I hide the picker?  Could be interesting
        
        
        
        //  If it's in the Stop state, stop timer and change to Start
        
    }
    
    
    
    @IBAction func startTimer( _sender: UIButton)
    {
        self.datePicker.isHidden=true;
        self.countDownTimeLabel.isHidden=false;
        self.startButton.isHidden=true;
        self.stopButton.isHidden=false;
        
        
        
        print( "Starting Timer ");
        let currentTime:Date = Date()
        
        var lengthOfTimer:TimeInterval = self.datePicker.countDownDuration;
        
        let timeAtTimerStop:Date = Date.init(timeInterval: lengthOfTimer, since: currentTime);
        
        
        let interval:DateInterval = DateInterval.init(start: currentTime, end: timeAtTimerStop);
     //   print(formatCountDownString(currentInterval: interval))
        self.endTime = timeAtTimerStop;
        self.countDownTimeLabel.text = formatCountDownString(currentInterval: interval)
        
        
        
        countDownTimer = Timer.scheduledTimer(timeInterval:1.0, target:self, selector: #selector(self.displayCountDownTime), userInfo:nil, repeats: true);
       // displayCountDownTime(endTime: timeAtTimerStop)
        
    }
    
    
    
    @objc func formatCountDownString( currentInterval: DateInterval) -> String
    {
        let dateCompontentsFormatter:DateComponentsFormatter = DateComponentsFormatter();
        dateCompontentsFormatter.unitsStyle = .positional
        dateCompontentsFormatter.zeroFormattingBehavior = .pad;
        dateCompontentsFormatter.allowedUnits = [.hour, .minute, .second];
        

        return dateCompontentsFormatter.string(from: currentInterval.duration)!
    }
    
    
    @objc func displayCountDownTime()
    {
        let currentTime:Date = Date()

        
        
        if  (currentTime > self.endTime!)
        {
            self.stopTimer();
        }
        
        else
        {
            var interval:DateInterval = DateInterval.init(start: currentTime, end: self.endTime!);
            self.countDownTimeLabel.text = formatCountDownString(currentInterval: interval)
            print(formatCountDownString(currentInterval: interval));
        }
        
        

    }
    
    
    func stopTimer()
    {
        countDownTimer?.invalidate();
        self.countDownTimeLabel.text = "TIMER STOP";
        self.datePicker.isHidden=false;
        self.countDownTimeLabel.isHidden=true;
        self.startButton.isHidden=false;
        self.stopButton.isHidden=true;
    }
    

}

