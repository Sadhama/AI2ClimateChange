//
//  LoadingView.swift
//  AI2ClimateChange
//
//  Created by kokila on 12/29/24.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress: CGFloat = 0.0
    @State private var waveOffset: CGFloat = 0.0
    @State private var navigateToHome = false

    var body: some View {
        if navigateToHome {
            ContentView() // Your main home screen
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        // Earth outline
                        Circle()
                            .strokeBorder(LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.green.opacity(0.6)]),
                                startPoint: .top,
                                endPoint: .bottom),
                                lineWidth: 10
                            )
                            .frame(width: 150, height: 150)
                            
                        // Liquid fill effect
                        LiquidWave(progress: progress, waveHeight: 10, waveOffset: waveOffset)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.green.opacity(0.5)]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                            .frame(width: 140, height: 140)
                            .clipShape(Circle())
                        
                        // Earth icon
                        Image("earthLoad")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                    }
                }
            }
            .onAppear {
                startLoading()
            }
        }
    }

    private func startLoading() {
        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: false)) {
            waveOffset = .pi * 2
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress >= 1.0 {
                timer.invalidate()
                navigateToHome = true
            } else {
                progress += 0.01
            }
        }
    }
}
