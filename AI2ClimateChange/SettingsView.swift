import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Dark Mode Toggle
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
                    .font(.headline)
            }
            .padding()

            Spacer()

            // Logo
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .cornerRadius(15)
                .overlay(
                    Image("earthLoad")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                )
            }
            .padding()

            Spacer()
            
            Text("Made with ❤️ by Sadhana Gangadharan for KWK x Deloitte Sustainability Challenge")
                .font(.footnote)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .background(isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
    }
}
#Preview {
    ContentView()
}
