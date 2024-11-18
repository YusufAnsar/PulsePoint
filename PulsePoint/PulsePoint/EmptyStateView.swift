//
//  EmptyStateView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar on 18/11/24.
//

import SwiftUI

struct EmptyStateView: View {
    let text: String
    let imageName: String?
    let imageSize: CGSize

    init(
        text: String,
        imageName: String? = nil,
        imageSize: CGSize = CGSize(width: 100, height: 100)
    ) {
        self.text = text
        self.imageName = imageName
        self.imageSize = imageSize
    }

    var body: some View {
        VStack(spacing: 16) {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .foregroundColor(.secondary) // Using a semantic color
            }
            Text(text)
                .font(.headline)
                .multilineTextAlignment(.center) // For better UI if the text wraps
                .foregroundColor(.secondary) // Consistent with the image color
        }
        .padding()
        .accessibilityElement(children: .combine) // Improves accessibility grouping
    }
}

// Preview
#Preview(traits: .sizeThatFitsLayout) {
    Group {
        EmptyStateView(text: "No articles", imageName: "newspaper")
        EmptyStateView(text: "No notifications", imageName: "bell.slash")
        EmptyStateView(text: "No items found", imageName: nil)
    }
}
