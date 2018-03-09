//
//  GameScene.swift
//  PillApp WatchKit Extension
//
//  Created by Homero Oliveira on 07/03/18.
//  Copyright © 2018 Bruno Scheltzke. All rights reserved.
//

/**
 * Copyright (c) 2016 Ben Morrow
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

class RingScene: SKScene {
    
    // Configuration for both iOS and watchOS
    let duration: TimeInterval = 4
    let ringColor = #colorLiteral(red: 0.003921568627, green: 0.9960784314, blue: 0.968627451, alpha: 1)
    var ring: SKRingNode!
    var ringCountLabel: SKLabelNode!
    
    override func sceneDidLoad() {
        backgroundColor = .black
        showRing()
    }
    
    
    private func showRing() {
        let position = CGPoint(x: size.width / 2, y: size.height / 2)
        let diameter = size.width
        ring = SKRingNode(diameter: diameter, thickness: 0.25)
        ring.color = ringColor
        ring.position = position
        addChild(ring)
        
        let node = SKNode()
        let fontName = UIFont.systemFont(ofSize: 0, weight: .medium).fontName
        
        let label = SKLabelNode()
        label.text = "1/2"
        label.fontSize = 10
        label.fontName = fontName
        label.position = CGPoint(x: label.frame.size.width/2, y: label.frame.size.height)
        
        node.addChild(label)
        
        let label2 = SKLabelNode()
        label2.text = "Pills"
        label2.fontSize = 9
        label2.fontName = fontName
        label2.position.x = label.frame.width/2
        label2.position.y = label2.frame.height - label.frame.height/2 - 2
        node.addChild(label2)
        
        node.position = CGPoint(x: frame.midX - label.frame.width / 2, y: frame.midY - (label.frame.height + label2.frame.height) * 0.5)
        addChild(node)
        
        ringCountLabel = label
    }
    
    func fillRing(to: CGFloat) {
        DispatchQueue.main.async {
            let valueUpEffect = SKTRingValueEffect(for: self.ring, to: to, duration: 0.8)
            valueUpEffect.timingFunction = SKTTimingFunctionCircularEaseOut
            let valueUpAction = SKAction.actionWithEffect(valueUpEffect)
            self.ring.run(valueUpAction)
        }
    }
}
