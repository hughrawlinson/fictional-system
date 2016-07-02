//
//  GameScene.swift
//  smorane
//
//  Created by Hugh Rawlinson on 02/07/16.
//  Copyright (c) 2016 Hugh Rawlinson. All rights reserved.
//

import SpriteKit
import Darwin

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Avenir-Light")
        myLabel.text = "Joe Nash"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            event?.timestamp
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            sprite.userData = NSMutableDictionary()
            if(event != nil){
                sprite.userData?.setObject(event?.timestamp ?? 0.0, forKey: "test")
            }
            self.addChild(sprite)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        for child in self.children {
            var createdTime = NSTimeInterval.init()
            if child.userData != nil {
                createdTime = child.userData!.objectForKey("test")?.doubleValue ?? 0.0
            }
            let vector = delta(currentTime-createdTime)
            child.runAction(SKAction.moveBy(vector, duration: 1))
        }
    }
    
    func delta(time: CFTimeInterval) -> CGVector {
        return CGVector.init(dx: cos(CGFloat(time)), dy: sin(CGFloat(time)))
    }
}
