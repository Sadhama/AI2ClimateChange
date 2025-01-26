import SwiftUI

struct SolutionsView: View {
    @State private var userInput: String = ""
    @State private var messages: [String] = ["Welcome to the AI chat! Ask me anything about AI and the environment."]
    @State private var isLoading: Bool = false
    @State private var isDarkMode = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    // Informational Section (Course Modules)
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Potential: AI's Benefits")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading)

                        ForEach(benefits.indices, id: \.self) { index in
                            CourseModule(
                                title: benefits[index].title,
                                description: benefits[index].description,
                                imageName: benefits[index].imageName
                            )
                        }
                    }
                    .padding()

                    // AI Chat Section
                    VStack {
                        Text("Ask AI About Solutions")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)

                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(messages, id: \.self) { message in
                                    if message.contains("You:") {
                                        Text(message)
                                            .padding()
                                            .background(Color.blue.opacity(0.2))
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    } else {
                                        HStack(alignment: .top, spacing: 10) {
                                            Image("EarthAIIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 35.0, height: 35.0)
                                                .clipShape(Circle())
                                            Text(message)
                                                .padding()
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(10)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.4), radius: 8, x: 0, y: 5)

                        if isLoading {
                            ProgressView()
                                .padding()
                        }

                        HStack {
                            TextField("Type your message...", text: $userInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Button(action: {
                                sendMessage()
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .disabled(userInput.isEmpty || isLoading)
                        }
                        .padding()
                    }
                    .padding()
                }
                .padding()
            }

            // Floating Toolbar
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
        .toolbarBackground(Color.clear, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)

        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.blue.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }

    func sendMessage() {
        guard !userInput.isEmpty else { return }
        let userMessage = "You: \(userInput)"
        messages.append(userMessage)

        let prompt = messages
            .filter { !$0.contains("You:") }
            .joined(separator: "\n") + "\nHuman: \(userInput)\nAI:"

        userInput = ""
        isLoading = true

        fetchGPT2Response(prompt: prompt) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.messages.append("AI: \(response)")
            }
        }
    }

    func fetchGPT2Response(prompt: String, completion: @escaping (String) -> Void) {
        let apiKey = "xxxxxxxxxxxxxplaceholder"
        let endpoint = "https://api-inference.huggingface.co/models/bert-large-uncased-whole-word-masking-finetuned-squad"

        guard let url = URL(string: endpoint) else {
            completion("Failed to create URL.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["inputs": prompt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion("No data received.")
                return
            }

            do {
                if let response = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let generatedText = response["generated_text"] as? String {
                    completion(generatedText)
                } else {
                    completion("Failed to parse response.")
                }
            }
        }.resume()
    }
}

struct CourseModule: View {
    let title: String
    let description: String
    let imageName: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipped()
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(.leading)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
    }
}

struct Benefit {
    let title: String
    let description: String
    let imageName: String
}

let benefits = [
    Benefit(title: "Predictive Analysis        ", description: "AI models predict climate patterns and disasters.", imageName: "PredictiveAnalysis"),
    Benefit(title: "Energy Efficiency                    ", description: "Smart algorithms optimize energy usage.", imageName: "Energy Efficiency"),
    Benefit(title: "Reforestation                          ", description: "AI-powered drones plant trees.", imageName: "Reforestation"),
    Benefit(title: "Carbon Capture                         ", description: "Machine learning enhances carbon capture.", imageName: "CarbonCapture"),
    Benefit(title: "Sustainable Agriculture                       ", description: "AI systems reduce waste and improve yield.", imageName: "SustainableAgriculture")
]

struct SolutionsView_Previews: PreviewProvider {
    static var previews: some View {
        SolutionsView()
    }
}
