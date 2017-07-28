//
//  extension.swift
//  LEGYDrawerLayout
//
//  Created by Madrit Kacabumi on 25/07/2017.
//  Copyright © 2017 Madrit Kacabumi. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    static func instanceFromNib(name:String) -> UIView {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    class func instanceFromNib(name:String, fromBundle bundle : Bundle? = nil) -> UIView {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    public func attachTo(view : UIView, animated : Bool = true){
        
        if(animated){
            self.alpha = 0
        }
        else{
            self.alpha = 1
        }
        
        view.addSubview(self)
        // self.frame = view.bounds
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: 0).isActive = true
        
        if(animated){
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            })
        }
    }
    
    
    func clearAllSuBViews(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
    }
    
    
    static public func createView<T : UIView>(attachTo view : UIView? = nil, fromBundle bundle : Bundle? = Bundle.main) -> T{
        
        let popup = UIView.instanceFromNib(name: String(describing: T.self), fromBundle: bundle) as? T
        
        if(view != nil){
            popup!.attachTo(view : view!)
        }
        
        return popup!
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
