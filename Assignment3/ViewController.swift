//
//  ViewController.swift
//  Assignment3
//
//  Created by Brad Payne on 1/18/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate
{
    
    @IBOutlet   var currentTimeLabel: UILabel!;
    @IBOutlet   var countDownTimeLabel: UILabel!;
    @IBOutlet   var datePicker:UIDatePicker!;
    @IBOutlet   var startButton:UIButton!;
    @IBOutlet   var stopButton:UIButton!;
    @IBOutlet   var backgroundImage:UIImageView!;
    
    
    var endTime: Date?;
    var countDownTimer: Timer?;
    var marioMusicPlayer: AVAudioPlayer!;
    

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
        
        
        //  Initiate the Audio Player
        let marioMusicPath = Bundle.main.path(forResource: "mario.mp3", ofType:nil)!;
        do
        {
            self.marioMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: marioMusicPath));
            self.marioMusicPlayer.delegate = self;
        }
        catch
        {
            // Throw a message for the file not loading for some reason
        }
        
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
            //  Check if background picture is currently the AM picture
            //  If it is not than switch
            //  Normally I would do a check if we already have this image or not
            //  But I didn't want to either create a boolean to handle AM PM state
            //  or subclass UIImage to let me pull out a name so lazy wins
            self.backgroundImage.image = UIImage(named: "AMBackgroundImage");
        }
        else
        {
            //  Check if background picture is currently the PM picture
            //  If it is not than switch
            //  Normally I would do a check if we already have this image or not
            //  But I didn't want to either create a boolean to handle AM PM state
            //  or subclass UIImage to let me pull out a name so lazy wins
            self.backgroundImage.image = UIImage(named: "PMBackgroundImage");

        }

    }
       
    
    @IBAction func startTimer()
    {
        //  Configure the stackview items for what's shown
        self.datePicker.isHidden=true;
        self.countDownTimeLabel.isHidden=false;
        self.startButton.isHidden=true;
        self.stopButton.isHidden=false;
        
        let currentTime:Date = Date()
        
        let lengthOfTimer:TimeInterval = self.datePicker.countDownDuration;
        
        let timeAtTimerStop:Date = Date.init(timeInterval: lengthOfTimer, since: currentTime);
        
        
        let interval:DateInterval = DateInterval.init(start: currentTime, end: timeAtTimerStop);
        self.endTime = timeAtTimerStop;
        self.countDownTimeLabel.text = formatCountDownString(currentInterval: interval)
        
        countDownTimer = Timer.scheduledTimer(timeInterval:1.0, target:self, selector: #selector(self.displayCountDownTime), userInfo:nil, repeats: true);
    }
    
    
    
    @objc func formatCountDownString( currentInterval: DateInterval) -> String
    {
        let dateCompontentsFormatter:DateComponentsFormatter = DateComponentsFormatter();
        dateCompontentsFormatter.unitsStyle = .positional
        dateCompontentsFormatter.zeroFormattingBehavior = .pad;
        dateCompontentsFormatter.allowedUnits = [.hour, .minute, .second];
        

        return dateCompontentsFormatter.string(from: currentInterval.duration)!
    }
    
    
    @objc func displayCountDownTime(_sender: UIButton?)
    {
        let currentTime:Date = Date()
        
        if  (currentTime > self.endTime!)
        {
            self.timerEnds();
        }
        
        else
        {
            let interval:DateInterval = DateInterval.init(start: currentTime, end: self.endTime!);
            self.countDownTimeLabel.text = formatCountDownString(currentInterval: interval)
        }
    }
    
    
    @IBAction func stopButton(_sender: UIButton?)
    {
        countDownTimer?.invalidate();
        
        //  Configure the GUI
        self.datePicker.isHidden=false;
        self.countDownTimeLabel.isHidden=true;
        self.startButton.isHidden=false;
        self.stopButton.isHidden=true;
     
        //  I guess I could always stop the player when this is called, but it takes a little extra processing to do that
        //  I mean save those worthless cycles where you can right?
        if(_sender != nil)
        {
            self.marioMusicPlayer.stop();
        }
    }
    

    func timerEnds()
    {
        //  Configure the GUI
        self.marioMusicPlayer.play();
        self.datePicker.isHidden=true;
        self.countDownTimeLabel.isHidden=true;
        self.startButton.isHidden=true;
        self.stopButton.isHidden=false;
    }
    
    //  Delete to reset everything once the music stops
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        self.stopButton(_sender: nil);
    }
    
    
}

