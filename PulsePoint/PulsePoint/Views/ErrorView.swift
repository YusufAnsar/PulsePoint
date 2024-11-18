//
//  ErrorView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import SwiftUI

struct ErrorView: View {

    // MARK: - Properties
    let message: String
    let onRetry: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            Button(action: onRetry) {
                Text("Try Again")
                    .font(.body)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 4)
        )
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ErrorView(message: "Something went wrong.\nPlease try again.") {
        print("Retry tapped!")
    }
    .padding()
}
