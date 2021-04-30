//
//  GameScene.swift
//  SnakeV2
//
//  Created by Pettigrew, Alexander J on 4/27/21.
//

import SpriteKit
import GameplayKit
import UIKit

let displaySize: CGRect = UIScreen.main.bounds
let displayWidth = displaySize.width
let displayHeight = displaySize.height

class GameScene: SKScene
{
    let swipeRecognizer = UISwipeGestureRecognizer()
       
    
    
    var pointLabel : SKLabelNode!
    let playerNode = SKSpriteNode(imageNamed: "Player")
    var gestureRecognizerNode : SKSpriteNode?
    let pointNode = SKSpriteNode(imageNamed: "Player")
    var points = 0
    
    
    var directionLeft = false
    var directionRight = false
    var directionUp = false
    var directionDown = false
    
    var playerPositionX = 0
    var playerPositionY = 0
    var playerMovement = 0
    
    var randomXLocationArray = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var randomYLocationArray = [-1, -2, -3, -4, -5, -6, -7, -8, 1, 2, 3, 4, 5, 6, 7]
    var randomXLocation = 0
    var randomYLocation = 0
    
    let LabelPosition = CGPoint(x: 0, y: 230)
    
    let scale = SKAction.scale(to: 0.05, duration: 1)
    
    override func didMove(to view: SKView)
    {
        print(displaySize)
        print(displayWidth)
        print(displayHeight)
        
        pointLabel = SKLabelNode(fontNamed: "Chalkduster")
        pointLabel.text = "Score: \(points)"
        pointLabel.fontSize = 20
        pointLabel.fontColor = UIColor.black
        pointLabel.position = LabelPosition
        self.addChild(pointLabel)
        
        randomXLocation = randomXLocationArray.randomElement()! * 30
        randomYLocation = randomYLocationArray.randomElement()! * 30
        
        gestureRecognizerNode = childNode(withName: "Player") as? SKSpriteNode

        
        view.addGestureRecognizer(swipeRecognizer)
        
        backgroundColor = SKColor.white
        playerNode.position = CGPoint(x: playerPositionX, y: playerPositionY)
        addChild(playerNode)
        pointNode.position = CGPoint(x: randomXLocation, y: randomYLocation)
        addChild(pointNode)
        
        playerNode.size.width = playerNode.size.width/1.5
        playerNode.size.height = playerNode.size.height/1.5
        pointNode.size.width = pointNode.size.width/1.5
        pointNode.size.height = pointNode.size.height/1.5
        
        playerNode.run(scale)
        pointNode.run(scale)
        
        run(SKAction.repeatForever(
                SKAction.sequence([
                SKAction.run (playerMoved),
                    SKAction.wait(forDuration: 0.3)
                ])
        ))
        
        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight(sender:)))

            swipeRight.direction = .right

            view.addGestureRecognizer(swipeRight)
        
        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft(sender:)))
        
            swipeLeft.direction = .left
            
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp(sender:)))
        
            swipeUp.direction = .up
        
            view.addGestureRecognizer(swipeUp)
        
        let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown(sender:)))
        
            swipeDown.direction = .down
        
            view.addGestureRecognizer(swipeDown)
        
        
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer)
    {
        print("Swiped Right")
        directionRight = true
        directionLeft = false
        directionUp = false
        directionDown = false
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer)
    {
        print("Swiped Left")
        directionLeft = true
        directionRight = false
        directionUp = false
        directionDown = false
    }
    
    @objc func swipedUp(sender: UISwipeGestureRecognizer)
    {
        print("Swiped Up")
        directionRight = false
        directionLeft = false
        directionUp = true
        directionDown = false
    }
    
    @objc func swipedDown(sender: UISwipeGestureRecognizer)
    {
        print("Swiped Down")
        directionRight = false
        directionLeft = false
        directionUp = false
        directionDown = true
    }
    
    @objc func swipeDirection()
    {
        print("Swiped")
        if swipeRecognizer.direction == .right
            {
                print("Swiped Right")
            }
        if swipeRecognizer.direction == .left
            {
            print("Swiped Left")
            }
        if swipeRecognizer.direction == .up
            {
            print("Swiped Up")
            }
        if swipeRecognizer.direction == .down
            {
            print("Swiped Down")
            }
        
    }
   
    func playerMoved()
    {
        playerMovement = Int(playerNode.size.width)
        
        if directionLeft == true
        {
            playerPositionX -= playerMovement
            playerNode.position = CGPoint(x: playerPositionX, y: playerPositionY)
        }
        
        if directionRight == true
        {
            playerPositionX += playerMovement
            playerNode.position = CGPoint(x: playerPositionX, y: playerPositionY)
        }
        
        if directionUp == true
        {
            playerPositionY += playerMovement
            playerNode.position = CGPoint(x: playerPositionX, y: playerPositionY)
        }
        
        if directionDown == true
        {
            playerPositionY -= playerMovement
            playerNode.position = CGPoint(x: playerPositionX, y: playerPositionY)
        }
        
        print("Player X Position: \(playerPositionX)")
        print("Player Y Position: \(playerPositionY)")
        
        if playerNode.position == pointNode.position
        {
            
            
            points += 1
            print("Point + 1 = \(points)")
            
            pointLabel.text = "Score: \(points)"
            
            randomXLocation = randomXLocationArray.randomElement()! * 30
            randomYLocation = randomYLocationArray.randomElement()! * 30
            
            pointNode.position = CGPoint(x: randomXLocation, y: randomYLocation)

        }
    }
    
}
