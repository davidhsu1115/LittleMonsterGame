//
//  ViewController.swift
//  mylittlemonster
//
//  Created by fangwiehsu on 2016/6/7.
//  Copyright © 2016年 fangwiehsu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImage!  //using the custom class
    @IBOutlet weak var heartImg: DragImage!
    
    @IBOutlet weak var penalty1Img: UIImageView!  //骷魯頭
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2 //透明度
    let OPAQUE: CGFloat = 1.0    //不透明
    let MAX_PENALTY = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the target for dropping target
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        
        //get the notification from the DragImg sub class
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxSkull.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxBite.prepareToPlay()
            
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        
        startTimer()
        
    }
    
    
    
    func itemDroppedOnCharacter(notif: AnyObject){
        
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        }else{
            sfxBite.play()
        }
    }

    
    func startTimer(){
        if timer != nil{
            timer.invalidate() //if the timer is not nil, stop the existing one
        }
        
        //it will call the "changeGameState" function for every 3 second
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState(){
        
        
        if !monsterHappy {  //if monster = false
            
            penalties += 1
            sfxSkull.play()
            
            if penalties == 1{
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            }else if penalties == 2{
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            }else if penalties >= 3{
                penalty3Img.alpha = OPAQUE
            }else{
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTY{
                gameOver()
            }
            
        }
        
        let rand = arc4random_uniform(2) //0 or 1
        
        if rand == 0{
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
            
        }else{
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
        }
        
        currentItem = rand
        monsterHappy = false
        
        
    }
    
    func gameOver(){
        timer.invalidate() //計時stop
        monsterImg.playDeathAnimation()
        
        sfxDeath.play()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

