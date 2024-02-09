//
//  MainView.swift
//  SafeGuard
//
//  Created by Jakob Bauer on 08.02.24.
//

import SwiftUI

struct MainView: View {
    @State var oneTimePasswords: [OneTimePassword] = [
        OneTimePassword(name: "GitHub", secret: "JBSWY3DPEHPK3PXP"),
        OneTimePassword(name: "Amazon", secret: "JBSWY3DPEFPK3PXP"),
        OneTimePassword(name: "Facebook", secret: "JBSWY3DPEFPK3PXM"),
        OneTimePassword(name: "Twitter", secret: "JBSWY3DPEFPK3LXP"),
        OneTimePassword(name: "Ebay", secret: "KBSWY3DPEFPK3PXP"),
        OneTimePassword(name: "GitLab", secret: "JBSWY3DPEFPK3LXP"),
        
        OneTimePassword(name: "GitHub", secret: "JBSWY3DPEHPK3PXP"),
        OneTimePassword(name: "Amazon", secret: "JBSWY3DPEFPK3PXP"),
        OneTimePassword(name: "Facebook", secret: "JBSWY3DPEFPK3PXM"),
        OneTimePassword(name: "Twitter", secret: "JBSWY3DPEFPK3LXP"),
        OneTimePassword(name: "Ebay", secret: "KBSWY3DPEFPK3PXP"),
        OneTimePassword(name: "GitLab", secret: "JBSWY3DPEFPK3LXP"),
    ]
    
    @State var selection: OneTimePassword? = nil
    
    @State private var searchText = ""
        @State private var searchIsActive = false
    
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()

    
    var body: some View {
        NavigationStack {
            Form {
                List(selection: $selection) {
                    ForEach(searchResults) { otp in
                        Section {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(otp.name)
                                    .bold().font(.headline)
                                Text(otp.currentToken).font(.title2)
                            }.searchable(text: $searchText, isPresented: $searchIsActive)
                        }
                    }
                    .onDelete(perform: deleteOtp)
                }
                
            }
            .navigationTitle("SafeGuard")
            .toolbar {
                // EditButton()
            }
            .onReceive(timer) { _ in
                // This will cause the view to refresh, which in turn re-evaluates `currentToken`.
                // It's a simple way to force the view to update and show the new token.
            }
        }.searchable(text: $searchText)
    }
    
    var searchResults: [OneTimePassword] {
        if searchText.isEmpty {
            return oneTimePasswords
        } else {
            return oneTimePasswords.filter { $0.name.contains(searchText) }
        }
    }
    
    func deleteOtp(at offsets: IndexSet) {
        oneTimePasswords.remove(atOffsets: offsets)
    }
}

#Preview {
    MainView()
}
