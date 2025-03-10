//
//  LoginView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 09/03/25.
//

import SwiftUI

// MARK: - Login View
struct LoginView: View {
    
    var body: some View {
        ZStack {
            Color.iETLightBackground
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 30) {
                // Top Gradient Header
                VStack(spacing: 20) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Manage your expenses effortlessly")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 80)
                .padding(.bottom, 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.iETPrimaryGreen.opacity(0.9),
                            Color.iETPrimaryGreen.opacity(0.7)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(CustomHeaderShape())
                
                Spacer()
                
                LottieView(animationName: "welcome-lottie-animation", loopMode: .loop)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 10)
                
                // Button - Sign in with Google
                Button(action: {
                    signInWithGoogle()
                }) {
                    HStack {
                        Image("google_icon") 
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Sign in with Google")
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
    
    /// Calls AuthService's Google sign-in flow by presenting from the root view controller.
    private func signInWithGoogle() {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
        AuthService.shared.signInWithGoogle(presentingVC: rootVC) { result in
            switch result {
            case .success(let authResult):
                print("User signed in: \(authResult.user.uid)")
                // Navigate to Home or handle user session here
            case .failure(let error):
                print("Google sign-in failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Custom Header Shape
/// A custom shape for the top header curve.
struct CustomHeaderShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - 50))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.height - 50),
            control: CGPoint(x: rect.midX, y: rect.height)
        )
        path.closeSubpath()
        return path
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
