//
//  Image+.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/17.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
