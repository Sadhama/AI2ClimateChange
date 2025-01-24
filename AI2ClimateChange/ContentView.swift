import SwiftUI

struct ContentView: View {
    @State private var currentIndex = 0 // Track the current index for carousel
    @State private var isDarkMode = false // Track dark mode state

    @Environment(\.presentationMode) var presentationMode
    let carouselItems = [
        "But through this app, you will uncover both sides of the story, unlocking powerful information...",
        "However, if it's good or bad... That's for you to decide.\n [Scroll Down!]",
        "Artificial Intelligence has taken over our world by a storm.",
        "With all of this information about AI's potential, one has to question, is it really all that great?",
        "The answer isn't that straightforward, not just a yes or no."
    ] // Carousel items

    let lightBackgroundColor = Color(red: 240 / 255, green: 246 / 255, blue: 249 / 255)
    let darkBackgroundColor = Color.black

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Background image and heading
                ZStack {
                    Image("homebg")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(edges: .all) // Extend background to fill the entire screen
                        .frame(height: UIScreen.main.bounds.height / 3)

                    Text("What's the Hype?")
                        .font(.system(size: 55, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                }
                .frame(height: UIScreen.main.bounds.height / 3)

                // Carousel
                GeometryReader { geometry in
                    HStack(spacing: 15) {
                        ForEach(0..<carouselItems.count * 3, id: \.self) { index in
                            let realIndex = index % carouselItems.count
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green.opacity(0.6), Color.blue.opacity(0.4)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.5)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .overlay(
                                    VStack {
                                        Text(carouselItems[realIndex])
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                            .multilineTextAlignment(.center) // Center the text
                                            .frame(maxWidth: .infinity) // Ensure it takes up the full width for centering
                                    }
                                    .padding()
                                )
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                    .offset(x: CGFloat(-currentIndex) * (geometry.size.width * 0.7 + 15), y: 0)
                    .animation(.easeInOut(duration: 0.3), value: currentIndex)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let threshold: CGFloat = 50
                                if value.translation.width < -threshold {
                                    currentIndex = (currentIndex + 1) % carouselItems.count
                                } else if value.translation.width > threshold {
                                    currentIndex = (currentIndex - 1 + carouselItems.count) % carouselItems.count
                                }
                            }
                    )
                }

                // Bottom text
                Text("Scroll for more insights about AI and its impact!")
                    .font(.headline)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .center) // Center the text
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(0.7)

                // Toolbar
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
                .padding(.horizontal, 20) // Ensure the toolbar does not touch the edges
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Navigate back
                        }) {
                            Image("earthLoad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }
            .background((isDarkMode ? darkBackgroundColor : lightBackgroundColor).edgesIgnoringSafeArea(.all))
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
