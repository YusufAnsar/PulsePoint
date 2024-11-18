//
//  SafariView.swift
//  PulsePoint
//
//  Created by Yusuf Ansar  on 18/11/24.
//


import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}