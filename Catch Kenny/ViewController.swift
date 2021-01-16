//
//  ViewController.swift
//  Catch Kenny
//
//  Created by Ali ERGEÇER on 16.01.2021.
//

import UIKit

class ViewController: UIViewController {

    var score=0
    var timer=Timer()
    var hideImagesTimer=Timer()
    var highScore=0
    var counter=15
    var imageArray=[UIImageView]()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text=String(counter)
        scoreLabel.text="Score : \(score)"
        
        let storedHighScore=UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore==nil{
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore=newScore
            highScoreLabel.text="High Score: \(highScore)"
        }
        // Do any additional setup after loading the view.
        kenny1.isUserInteractionEnabled=true
        kenny2.isUserInteractionEnabled=true
        kenny3.isUserInteractionEnabled=true
        kenny4.isUserInteractionEnabled=true
        kenny5.isUserInteractionEnabled=true
        kenny6.isUserInteractionEnabled=true
        kenny7.isUserInteractionEnabled=true
        kenny8.isUserInteractionEnabled=true
        kenny9.isUserInteractionEnabled=true
        
        let recognizer1=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8=UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9=UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        imageArray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        timer=Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideImagesTimer=Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hideImages), userInfo: nil, repeats: true)
        hideImages()
        
    }
    
    @objc func hideImages(){
        for kenny in imageArray{
            kenny.isHidden=true
        }
        let random = Int(arc4random_uniform(UInt32(imageArray.count-1)))
        imageArray[random].isHidden=false
    }
    
    @objc func increaseScore(){
        score+=1
        scoreLabel.text="Score: \(score)"
    }

    @objc func countDown(){
        counter-=1
        timeLabel.text="\(counter)"
        if counter==0{
            timer.invalidate()
            hideImagesTimer.invalidate()
            if highScore<=self.score{
                highScore=score
                highScoreLabel.text="High Score:\(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
            let alertMessage=UIAlertController(title: "Game finished!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.counter=15
                self.timeLabel.text = String(self.counter)
                self.score=0
                self.scoreLabel.text="Score : \(self.score)"
                self.timer=Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideImagesTimer=Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideImages), userInfo: nil, repeats: true)
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            alertMessage.addAction(okButton)
            alertMessage.addAction(cancelButton)
            self.present(alertMessage, animated: true, completion: nil)
        }
        
    }
}
