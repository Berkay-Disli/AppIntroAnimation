//
//  OnboardingScreen.swift
//  IntroAnimation
//
//  Created by Berkay Disli on 20.01.2023.
//

import SwiftUI
import Lottie

struct OnboardingScreen: View {
    @State private var onboardingItems: [OnboardingItem] = [
        .init(title: "Request Pickup", subtitle: "Tell us who you're sending it to, what you're sending and when it's the best time to pickup the package and we will pick it up at the most convenient time.", lottieView: .init(name: "pickup")),
        .init(title: "Track Delivery", subtitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact location of the courier.", lottieView: .init(name: "transfer")),
        .init(title: "Receive Package", subtitle: "The journey ends when your package gets to it's location. Get notified immediately when your package is received at it's intended location.", lottieView: .init(name: "delivery"))
    ]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    VStack {
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    onboardingItems[currentIndex].lottieView.pause()
                                    currentIndex -= 1
                                    onboardingItems[currentIndex].lottieView.currentProgress = 0
                                    onboardingItems[currentIndex].lottieView.play(toProgress: 1, loopMode: .loop)
                                }
                            }
                            Spacer()
                            Button("Skip") {
                                onboardingItems[currentIndex].lottieView.pause()
                                currentIndex = onboardingItems.count - 1
                                onboardingItems[currentIndex].lottieView.currentProgress = 0
                                onboardingItems[currentIndex].lottieView.play(toProgress: 1, loopMode: .loop)
                            }
                        }
                        .tint(Color("Green"))
                        .fontWeight(.bold)
                        
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play(toProgress: 1, loopMode: .loop)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            Text(item.subtitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 15) {
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color("Green"))
                                }
                                .padding(.horizontal, 100)
                                .onTapGesture {
                                    if currentIndex < onboardingItems.count - 1 {
                                        onboardingItems[currentIndex].lottieView.pause()
                                        currentIndex += 1
                                        onboardingItems[currentIndex].lottieView.currentProgress = 0
                                        onboardingItems[currentIndex].lottieView.play(toProgress: 1, loopMode: .loop)
                                    }
                                }
                            
                            HStack {
                                Text("Terms of Service")
                                Text("Privacy Policy")
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                        }
                    }
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
        }
    }
    
    func indexOf(_ item: OnboardingItem) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        }
        return 0
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ResizableLottieView: UIViewRepresentable {
    @Binding var onboardingItem: OnboardingItem
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
