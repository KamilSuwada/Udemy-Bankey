//
//  SkeletonLoadable.swift
//  Bankey
//
//  Created by Kamil Suwada on 07/07/2022.
//

import UIKit




protocol SkeletonLoadable {}




// MARK: makeAnimationGroup()
extension SkeletonLoadable
{
    
    
    
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup
    {
        let animationDuration: CFTimeInterval = 1.0
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.gradientDarkGrey.cgColor
        anim1.toValue = UIColor.gradientLightGrey.cgColor
        anim1.duration = animationDuration
        anim1.beginTime = 0.0
        
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.gradientLightGrey.cgColor
        anim2.toValue = UIColor.gradientDarkGrey.cgColor
        anim2.duration = animationDuration
        anim2.beginTime = anim1.beginTime + anim1.duration
        
        
        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
        
        if let previusGroup = previousGroup
        {
            group.beginTime = previusGroup.beginTime + 0.33
        }
        
        return group
    }
    
    
    
}




extension UIColor {
    static var gradientDarkGrey: UIColor {
        return UIColor(red: 239 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 201 / 255.0, green: 201 / 255.0, blue: 201 / 255.0, alpha: 1)
    }
}
