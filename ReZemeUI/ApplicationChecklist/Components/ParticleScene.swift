//
//  ParticleScene.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 17.04.2023.
//

import SwiftUI
import SpriteKit

class ParticleScene: SKScene {

    override init(size: CGSize) {
        super.init(size: size)

        backgroundColor = .clear

        if let emitter1 = SKEmitterNode(fileNamed: "MyParticle") {
            emitter1.position.y = size.height
            emitter1.particleColorSequence = nil
            emitter1.particleColorBlendFactor = 1
            emitter1.particleColorBlueRange = 1
            emitter1.particleColorGreenRange = 0.6
            emitter1.particleColorRedRange = 0.5
            emitter1.position.x = size.width
            addChild(emitter1)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
