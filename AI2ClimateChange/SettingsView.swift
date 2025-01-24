import SwiftUI

struct SettingsView: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(spacing: 20) {
            // Dark Mode Toggle
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
                    .font(.headline)
            }
            .padding()

            Spacer()

            // Globe Image Placeholder
            VStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .cornerRadius(15)
                .overlay(
                    Image("earthLoad") // Replace with your globe image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                )
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
    }
}
#Preview {
    ContentView()
}
