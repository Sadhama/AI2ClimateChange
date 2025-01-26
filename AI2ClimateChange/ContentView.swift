import SwiftUI

struct ContentView: View {
    @State private var currentIndex = 0 // Track the current index for carousel
    @State private var isDarkMode = false // Track dark mode state

    @Environment(\.presentationMode) var presentationMode
    let carouselItems = [
        "Artificial Intelligence has taken over our world by a storm.",
        "With all of this information about AI's potential, one has to question, is it really all that great?",
        "The answer isn't that straightforward, not just a yes or no.",
        "But through this app, you will uncover both sides of the story, unlocking powerful information...",
        "However, if it's good or bad... That's for you to decide.\n [Scroll Down!]"
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
            
            ScrollView {
                VStack(spacing: 20) {
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
                                    .frame(width: 290, height: 150)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .overlay(
                                        Text(carouselItems[realIndex])
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .bold()
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    )
                            }
                        }
                        .frame(height: 230) // Ensure the carousel is fully visible
                        .offset(x: CGFloat(-currentIndex) * (280 + 15), y: 0)
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
                        .onAppear {
                            let centerIndex = carouselItems.count // Start from the center of the carousel
                            currentIndex = centerIndex
                        }
                    }
                    .frame(height: 230)
                    
                    Spacer()
                    Image(systemName: "arrow.down")
                        .frame(width: 100, height:100)
                    Spacer()
                    Spacer()
                    
                    // Free AI Courses Section
                    VStack(spacing: 15) {
                        Text("Free AI Courses You Can Take:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                        
                        ForEach(1...3, id: \.self) { courseIndex in
                            VStack(alignment: .leading, spacing: 8) {
                                if (courseIndex == 1){
                                    Link(destination: URL(string: "https://generative-ai-course.hks.harvard.edu/")!) {
                                        Text("The Science and Implications of Generative AI")
                                            .font(.headline)
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                            .foregroundColor(.white)
                                        Text("Learn the basics of AI and applications")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                } else if (courseIndex == 2){
                                    Link(destination: URL(string: "https://openlearning.mit.edu/news/explore-world-artificial-intelligence-online-courses-mit")!) {
                                        Text("MIT Open Learning AI Course(s)")
                                            .font(.headline)
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                            .foregroundColor(.white)
                                        Text("Learn the basics of AI and machine learning.")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                    }
                                } else {
                                    Link(destination: URL(string: "https://www.edx.org/courses?q=free+ai+courses")!) {
                                        Text("EDx Free Online AI Course(s)")
                                            .font(.headline)
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                        Text("Learn the basics of AI and machine learning through extensive courses.")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.green]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
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
                .padding(.horizontal, 20)
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
