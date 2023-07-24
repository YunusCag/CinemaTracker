//
//  UIViewExtension.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 24.07.2023.
//

import UIKit

enum RoundType {
    case top
    case left
    case bottom
    case right
}

extension UIView {

    func round(with type: RoundType, radius: CGFloat = 3.0) {
        var corners: UIRectCorner

        switch type {
        case .top:
            corners = [.topLeft, .topRight]
        case .left:
            corners = [.topLeft,.bottomLeft]
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .right:
            corners = [.topRight,.bottomRight]
        }

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

}
