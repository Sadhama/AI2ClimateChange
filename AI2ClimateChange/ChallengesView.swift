//
//  ChallengesView.swift
//  AI2ClimateChange
//
//  Created by kokila on 12/30/24.
//
import SwiftUI
struct ChallengesView: View {
    @State private var isDarkMode = false
    
    @Environment(\.dismiss) private var dismiss
    let challenges: [(title: String, fact: String, link: String, imageName: String)] = [
        ("AI Water Usage                  ", "\"AI consumes 1.8 – 12 litres of water for each kWh of energy\"", "https://oecd.ai/en/wonk/how-much-water-does-ai-consume", "Water"),
        ("Energy Consumption", "\"AI models require massive energy, leading to increased carbon footprints.\"", "https://news.climate.columbia.edu/2023/06/09/ais-growing-carbon-footprint/", "Energy"),
        ("E-Waste                                           ", "\"Decommissioned AI hardware contributes significantly to e-waste.\"", "https://www.technologyreview.com/2024/10/28/1106316/ai-e-waste/", "EWaste"),
        ("Data Centers                                      ", "\"Data centers for AI consume 2% of global electricity annually.\"", "https://news.mit.edu/2025/multifaceted-challenge-of-powering-ai-0121", "DataCenters"),
        ("Natural Resource Consumption                                             ", "\"Artificial Intelligence devices often require significant amounts of metals to make hardware\"", "https://environment.yale.edu/news/article/can-we-mitigate-ais-environmental-impacts#:~:text=Besides%20its%20energy%20usage%2C%20AI,gold%2C%20and%20many%20other%20metals.", "Metals")
    ]
    var body: some View {
            VStack(spacing: 15) {
                Text("Challenges")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(challenges, id: \.title) { challenge in
                            Link(destination: URL(string: challenge.link)!) {
                                HStack {
                                    Image(challenge.imageName)  // Displaying unique image for each challenge
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .cornerRadius(15)
                                        .padding()
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(challenge.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(challenge.fact)
                                            .font(.body)
                                            .foregroundColor(.white.opacity(0.9))
                                    }
                                    .padding()
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                                )
                                .hoverEffect(.highlight)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss() // Navigate back to the previous view
                        }) {
                                Image("earthLoad")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                HStack {
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    NavigationLink(destination: ChallengesView()) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    NavigationLink(destination: SolutionsView()) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(isDarkMode: $isDarkMode)) {
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.5).blur(radius: 10))
                .cornerRadius(20)
                .padding(.horizontal, 20)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
    }
}
#Preview {
    ChallengesView()
}

