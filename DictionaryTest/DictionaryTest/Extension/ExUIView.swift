//
//  ExUIView.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 16.02.2023.
//

import UIKit.UIView

extension UIView {
    
    func insertSubviewForAutoLayout(_ subview: UIView, aboveSubview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(subview, aboveSubview: aboveSubview)
    }
    func addSubviewsForAutolayout(_ subviews: [UIView]) {
        subviews.forEach() { view in
            self.addSubviewForAutolayout(view)
        }
    }
    
    private func addSubviewForAutolayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
    }
}
