//
//  LiquidWave.swift
//  AI2ClimateChange
//
//  Created by kokila on 12/29/24.
//

import SwiftUI

struct LiquidWave: Shape {
    var progress: CGFloat // Represents how full the liquid is
    var waveHeight: CGFloat
    var waveOffset: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(progress, waveOffset) }
        set {
            progress = newValue.first
            waveOffset = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let baseline = rect.height * (1 - progress) // Calculate water level

        path.move(to: CGPoint(x: 0, y: baseline))
        
        for x in stride(from: 0, to: rect.width, by: 1) {
            let relativeX = x / rect.width
            let sineWave = sin(relativeX * .pi * 2 + waveOffset) * waveHeight
            path.addLine(to: CGPoint(x: x, y: baseline + sineWave))
        }

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}
