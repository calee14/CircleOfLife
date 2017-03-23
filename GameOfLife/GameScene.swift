//
//  GameScene.swift
//  GameOfLife
//
//  Created by Cappillen on 3/14/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //UI Objects
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    
    //Game objects
    var gridNode: Grid!
    
    override func didMove(to view: SKView) {
        //Setup your scene here
        
        //Connect UI scene objects
        stepButton = childNode(withName: "stepButton") as! MSButtonNode
        populationLabel = childNode(withName: "populationLabel") as! SKLabelNode
        generationLabel = childNode(withName: "generationLabel") as! SKLabelNode
        playButton = childNode(withName: "playButton") as! MSButtonNode
        pauseButton = childNode(withName: "pauseButton") as! MSButtonNode
        
        gridNode = childNode(withName: "gridNode") as! Grid
        
        //Step testing button selected handler
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Called when a touch begins
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Called before each frame is rendered
    }
    
    func stepSimulation() {
        //Step Simulation
        
        //Run next step in simulation
        gridNode.evolve()
        
        //Update UI label objects
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
        
    }
}
