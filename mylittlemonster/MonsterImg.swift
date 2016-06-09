//
//  MonsterImg.swift
//  mylittlemonster
//
//  Created by fangwiehsu on 2016/6/7.
//  Copyright © 2016年 fangwiehsu. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView{
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //when the app first load start the idle animation
        playIdleAnimation()
    }
    
    
    //function for the monster animation
    func playIdleAnimation(){
        
        //default image
        self.image = UIImage(named: "idle1.png")
        
        //when the monster alive need to delete the dead animation image
        self.animationImages = nil
        
        var imgArr = [UIImage]()
        for x in 1...4{  //for x = 1; x <= 4; x++
            let img = UIImage(named: "idle\(x).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 0  //it will never stop animating
        self.startAnimating()
    }

    func playDeathAnimation(){
        
        //the default image
        self.image = UIImage(named: "dead5.png")
        
        //when the monster die we need to empty the imageArray first then load the dead animation image.
        self.animationImages = nil
        
        var imgArr = [UIImage]()
        for x in 1...5{  //for x = 1; x <= 5; x++
            let img = UIImage(named: "dead\(x).png")
            imgArr.append(img!)
        }
        
        self.animationImages = imgArr
        self.animationDuration = 0.8
        self.animationRepeatCount = 1  //it will never stop animating
        self.startAnimating()
        
        
    }
    
    
}