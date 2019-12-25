//
//  ContentView.swift
//  SwiftUI-Particles
//
//  Created by Arthur Guibert on 22/12/2019.
//  Copyright © 2019 Arthur Guibert. All rights reserved.
//

import UIKit
import SwiftUI

struct EmitterConfig: Identifiable {
    let emitter: ParticlesEmitter
    let size: CGSize
    let shape: CAEmitterLayerEmitterShape
    let position: CGPoint
    let name: String
    let backgroundColor: Color
    
    // To make the ForEach work
    let id = UUID()
}


struct ContentView: View {
    struct Constants {
        static let height: CGFloat = 230.0
        static let width: CGFloat = UIScreen.main.bounds.width
    }
    
    var items: [EmitterConfig] = [
        EmitterConfig(emitter: Emitters.rain,
                      size: CGSize(width: Constants.width, height: 1),
                      shape: .line,
                      position: CGPoint(x: Constants.width / 2, y: 0),
                      name: "Rain",
                      backgroundColor: Color(red: 0.1, green: 0.1, blue: 0.5)),
        
        EmitterConfig(emitter: Emitters.snow,
                      size: CGSize(width: Constants.width, height: 1),
                      shape: .line,
                      position: CGPoint(x: Constants.width / 2, y: 0),
                      name: "Snow",
                      backgroundColor: .black),
        
        EmitterConfig(emitter: Emitters.fire,
                      size: CGSize(width: Constants.width / 8, height: 1),
                      shape: .line,
                      position: CGPoint(x: Constants.width / 2, y: Constants.height),
                      name: "Fire",
                      backgroundColor: .black),
        
        EmitterConfig(emitter: Emitters.smoke,
                      size: CGSize(width: 32, height: 1),
                      shape: .line,
                      position: CGPoint(x: Constants.width / 2, y: Constants.height + 20),
                      name: "Smoke",
                      backgroundColor: .black),

        EmitterConfig(emitter: Emitters.stars,
                      size: CGSize(width: Constants.width, height: Constants.height),
                      shape: .rectangle,
                      position: CGPoint(x: Constants.width / 2, y: Constants.height / 2),
                      name: "Stars",
                      backgroundColor: .black),
        
        EmitterConfig(emitter: Emitters.explosion,
                      size: CGSize(width: 16, height: 16),
                      shape: .rectangle,
                      position: CGPoint(x: Constants.width / 2, y: Constants.height / 2),
                      name: "Explosion",
                      backgroundColor: .black),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    EmitterItem(config: item)
                        .listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))
                }
            }
            .navigationBarTitle(Text("Examples"))
        }
    }
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct EmitterItem: View {
    var config: EmitterConfig
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color(red: 0.15, green: 0.15, blue: 0.15)
                .cornerRadius(12)
                .padding(.top, 16)
                .padding(.leading, 0)
            
            VStack(alignment: .leading) {
                config.emitter
                    .emitterSize(config.size)
                    .emitterShape(config.shape)
                    .emitterPosition(config.position)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: ContentView.Constants.height,
                           maxHeight: .infinity,
                           alignment: Alignment.topLeading)
                    .background(config.backgroundColor)
                    .cornerRadius(12)
                
                Text(config.name)
                    .font(.caption)
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    .padding(.leading, 16)
            }
            .padding(.trailing, 0)
            .padding(.bottom, 8)
        }
        .padding(.bottom, 16)
        .padding(.top, 16)
    }
}


struct Emitters {
    static let snow = ParticlesEmitter {
        EmitterCell()
            .content(.image(UIImage(named: "spark")!))
            .color(.white)
            .lifetime(10)
            .birthRate(5)
            .scale(0.1)
            .scaleRange(0.06)
            .scaleSpeed(-0.02)
            .velocity(100)
            .velocityRange(50)
            .emissionLongitude(.pi)
            .emissionRange(.pi / 8)
            .spin(2)
            .spinRange(3)
    }
    
    static let rain = ParticlesEmitter {
        EmitterCell()
            .content(.circle(8.0))
            .color(UIColor.white.withAlphaComponent(0.5))
            .lifetime(10)
            .birthRate(30)
            .scale(0.1)
            .scaleRange(0.06)
            .velocity(200)
            .velocityRange(50)
            .yAcceleration(200.0)
            .emissionLongitude(.pi)
    }
    
    static var fire: ParticlesEmitter  {
        get {
            let base = EmitterCell()
            .content(.circle(16.0))
            .color(.white)
            .lifetime(2)
            .birthRate(50)
            .scale(0.1)
            .scaleRange(0.06)
            .scaleSpeed(-0.05)
            .velocity(-50)
            .velocityRange(20)
            .yAcceleration(20)
            .emissionLongitude(.pi)
            .emissionRange(.pi / 16)
            .alphaRange(0.5)
            .alphaSpeed(-0.4)
            
            return ParticlesEmitter {
                base.copyEmitter().color(.yellow)
                base.copyEmitter().color(.white)
                base.copyEmitter().color(.orange)
                base.copyEmitter().color(.red)
            }
        }
    }
    
    static var smoke: ParticlesEmitter  {
        get {
            let base = EmitterCell()
            .content(.circle(16.0))
            .color(.white)
            .lifetime(5)
            .birthRate(10)
            .scale(0.1)
            .scaleRange(0.06)
            .scaleSpeed(0.025)
            .velocity(-60)
            .velocityRange(20)
            .emissionLongitude(.pi)
            .emissionRange(.pi / 16)
            .alphaRange(1.0)
            .alphaSpeed(-0.5)
            
            return ParticlesEmitter {
                base.copyEmitter().color(.white)
                base.copyEmitter().color(.gray)
                base.copyEmitter().color(.darkGray)
                base.copyEmitter().color(.lightGray)
            }
        }
    }
    
    static let stars = ParticlesEmitter {
        EmitterCell()
            .content(.image(UIImage(named: "spark")!))
            .color(UIColor.white.withAlphaComponent(0.0))
            .lifetime(20)
            .birthRate(2)
            .scale(0.1)
            .scaleRange(0.01)
            .scaleSpeed(-0.005)
            .alphaSpeed(0.3)
    }
    
    static var explosion: ParticlesEmitter {
        get {
            let base = EmitterCell()
                .content(.circle(16.0))
                .color(.white)
                .lifetime(0.5)
                .birthRate(2)
                .scale(0.15)
                .scaleRange(0.01)
                .scaleSpeed(-0.3)
                .velocity(50)
                .velocityRange(30)
                .emissionRange(-.pi)
            
            let center = EmitterCell()
                .content(.circle(16.0))
                .color(.white)
                .lifetime(0.08)
                .birthRate(2)
                .scale(0.1)
                .scaleRange(-0.05)
                .scaleSpeed(0.05)
        
            return ParticlesEmitter {
                base.copyEmitter().color(.white)
                base.copyEmitter().color(.gray)
                base.copyEmitter().color(.darkGray)
                base.copyEmitter().color(.lightGray)
                base.copyEmitter().color(.white)
                base.copyEmitter().color(.gray)
                base.copyEmitter().color(.darkGray)
                base.copyEmitter().color(.lightGray)
                center.copyEmitter().color(.white)
                center.copyEmitter().color(.white)
                center.copyEmitter().color(.white)
            }
        }
    }
}
