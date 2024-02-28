//
//  SignInView.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI

struct SignInView: View {
    @Binding var showSignIn: Bool
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            Spacer()
            VStack(spacing: 10) {
                Button(action: {
                    AuthManagers.shared.signInWithGoogle { result in
                        switch result {
                        case .success(let user):
                            print("\(user)")
                            showSignIn = false
                        case .failure(let failure):
                            print(failure.localizedDescription)
                        }
                    }
                }, label: {
                    Text("Log In With Google")
                        .padding()
                        .background(.tint)
                        .cornerRadius(20)
                        .foregroundColor(.primary)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundColor(.secondary)
                        }
                })
                .buttonStyle(.plain)
                
                Button(action: {
                    
                }, label: {
                    Text("Log In With Apple")
                        .padding()
                        .background(.bar)
                        .cornerRadius(20)
                        .foregroundColor(.primary)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundColor(.secondary)
                        }
                })
                .buttonStyle(.plain)
            }
            .padding()
            Spacer()
        }
        .frame(minWidth: 300, minHeight: 400)
    }
}

