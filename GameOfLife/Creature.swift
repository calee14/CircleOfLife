//
//  Creature.swift
//  GameOfLife
//
//  Created by Cappillen on 3/14/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import SpriteKit

class Creature: SKSpriteNode {
    
    //Character side
    var isAlive: Bool = false {
        didSet {
            //visibility
            isHidden = !isAlive
        }
    }
    
    //Living neighbor counter
    var neighborCount = 0
    
    init() {
        //initialize with 'bubble' asset
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        //set z-position, ensure it's on top of the grid
        zPosition = 1
        
        //set anchor point to bottom-left
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    //You are required to implement this for your subclass to work
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
