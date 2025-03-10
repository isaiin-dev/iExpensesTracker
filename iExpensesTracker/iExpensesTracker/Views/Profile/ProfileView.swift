//
//  ProfileView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @AppStorage("enableNotifications") private var enableNotifications = false
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var showDemoAlert = false
    
    var body: some View {
        ZStack {
            Color.iETLightBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                profileHeader
                storagePreferenceSelector
                notificationToggle
                signOutButton
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
    
    /// Header with user photo and data
    private var profileHeader: some View {
        VStack(spacing: 12) {
            AsyncImage(url: viewModel.photoURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    Image(systemName: "person.circle.fill")
                        .resizable()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.iETPrimaryGreen, lineWidth: 2))

            Text(viewModel.displayName)
                .font(.headline)
                .foregroundColor(.iETPrimaryGreen)
            
            Text(viewModel.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    /// User-friendly selector to choose Local or Cloud
    private var storagePreferenceSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Expense Storage")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Picker("Storage", selection: Binding(
                get: { viewModel.currentStorageOption },
                set: { viewModel.setStorageOption($0) }
            )) {
                Text("On this iPhone").tag(StorageOption.local)
                Text("In the Cloud").tag(StorageOption.cloud)
            }
            .pickerStyle(.segmented)
        }
        .padding(.top, 10)
    }
    
    private var notificationToggle: some View {
        Toggle("Notifications", isOn: $enableNotifications)
            .toggleStyle(SwitchToggleStyle(tint: .iETPrimaryGreen))
            .padding(.top, 20)
            .onChange(of: enableNotifications) { newValue in
                if newValue {
                    showDemoAlert = true
                }
            }
            .alert(isPresented: $showDemoAlert) {
                Alert(
                    title: Text("Demo Feature"),
                    message: Text("This is just a demonstration, no real notifications will be triggered."),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
    private var signOutButton: some View {
        Button(role: .destructive) {
            authViewModel.signOut()
        } label: {
            Text("Sign Out")
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
        }
        .padding(.top, 20)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

