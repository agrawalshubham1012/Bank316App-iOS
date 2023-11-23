//
//  ProgressView.swift
//  Docubay
//
//  Created by Dhairya on 02/09/22.
//

import Foundation
import NVActivityIndicatorView
import UIKit

let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotate, color: .white, padding: 0)

public func startAnimation(view: UIView) {
    loading.translatesAutoresizingMaskIntoConstraints = false
    view.isUserInteractionEnabled = false
    view.addSubview(loading)
//    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    NSLayoutConstraint.activate([
        loading.widthAnchor.constraint(equalToConstant: 40),
        loading.heightAnchor.constraint(equalToConstant: 40),
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    loading.color = .white
    loading.startAnimating()
    
}

public func startloadingAnimation(view: UIView) {
    loading.translatesAutoresizingMaskIntoConstraints = false
    view.isUserInteractionEnabled = false
    view.addSubview(loading)
//    view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    NSLayoutConstraint.activate([
        loading.widthAnchor.constraint(equalToConstant: 40),
        loading.heightAnchor.constraint(equalToConstant: 40),
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    loading.color = .darkGray.withAlphaComponent(1)
    loading.startAnimating()
    
}

public func stopAnimation(view: UIView) {
    loading.translatesAutoresizingMaskIntoConstraints = false
    view.isUserInteractionEnabled = true
    view.addSubview(loading)
    NSLayoutConstraint.activate([
        loading.widthAnchor.constraint(equalToConstant: 40),
        loading.heightAnchor.constraint(equalToConstant: 40),
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    loading.stopAnimating()
}
