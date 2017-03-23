//
//  Grid.swift
//  GameOfLife
//
//  Created by Cappillen on 3/14/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    //grid array demensions
    let rows = 8
    let columns = 10
    
    //individual cell dimensions, calcuated in setup
    var cellWidth = 0
    var cellHeight = 0
    
    //Creature Array
    var gridArray = [[Creature]]()
    
    //Counters
    var generation = 0
    var population = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //called when a touch begins
        
        //there will only be one touch as multi touch is not enabled by default
        for touch in touches {
            
            //Grabs postion of touch relative to the grid
            let location = touch.location(in: self)
            let gridX = Int(location.x) / cellWidth
            let gridY = Int(location.y) / cellHeight
            
            let creature = gridArray[gridX][gridY]
            creature.isAlive = !creature.isAlive
        }
        
        
    }
    
    func addCreatureAtGrid(x: Int, y: Int) {
        //Add a new creature at grid position
        
        //new creature object
        let creature = Creature()
        
        //Calculate position o screen
        let gridPosition = CGPoint(x: x*cellWidth, y: y*cellWidth)
        creature.position = gridPosition
        
        //Set default isAlive
        creature.isAlive = false
        
        //Add creature to grid node
        addChild(creature)
        
        //Add creature to grid array
        gridArray[x].append(creature)
        
    }
    func populateGrid() {
        //Populate the grid with creatures
        
        //loop through columns
        for gridX in 0..<columns {
            
            //initialize emty column
            gridArray.append([])
            
            //loop through rows
            for gridY in 0..<rows {
                
                //Create a new creature at row / column position
                addCreatureAtGrid(x: gridX, y: gridY)
            }
        }
    }
    
    func countNeighbors() {
        //Process array and update creature neighbor count
        
        //loop through columns
        for gridX in 0..<columns {
            
            //loop through rows
            for gridY in 0..<rows {
                
                //grab creature at grid position
                let currentCreature = gridArray[gridX][gridY]
                
                //reset neighbor count
                currentCreature.neighborCount = 0
                
                //loop through all adjacent creatures to current creature
                for innerGridX in (gridX-1)...(gridX+1) {
                    
                    //Ensure inner grid column is inside array
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY-1)...(gridY+1) {
                        
                        //Ensure inner grid row is inside array
                        if innerGridY < 0 || innerGridY >= rows { continue }
                        
                        //Creature can't count itself as a neighbor
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        //grab adjacent creature reference
                        let adjacentCreature:Creature = gridArray[innerGridX][innerGridY]
                        
                        //Only interested in living creatures
                        if adjacentCreature.isAlive {
                            currentCreature.neighborCount += 1
                        }
                    }
                }
            }
        }
    }
    
    func updateCreatures() {
        //Process array and update creatures status
        
        //Reset population counter
        population = 0
        
        //loop through columns
        for gridX in 0..<columns {
            
            //Loop through rows
            for gridY in 0..<rows {
                
                //Grab creature at grid position
                let currentCreature = gridArray[gridX][gridY]
                
                //Check against game of life rules
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                    break
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break
                default:
                    break
                }
                
                if currentCreature.isAlive { population += 1 }
            }
        }
    }
    
    func evolve() {
        //Update the grid to the next state in the game of life
        
        //Update all creature neighbor counts
        countNeighbors()
        
        //Calculate all creatures alive of dead
        updateCreatures()
        
        //Increment generation counter
        generation += 1
        
    }
    //You are required to implement this for your subclass to work
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Enable own touch implements for this node
        isUserInteractionEnabled = true
        
        //Calculate individual cell dimensions
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        //populate grid with creatures
        populateGrid()
    }
}
