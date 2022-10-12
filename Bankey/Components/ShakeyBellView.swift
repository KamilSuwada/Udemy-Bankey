//
//  ShakeyBellView.swift
//  Bankey
//
//  Created by Kamil Suwada on 03/07/2022.
//

import UIKit




class ShakeyBellView: UIView
{
    
    let imageView: UIImageView =
    {
        let imageView = UIImageView()
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let buttonView: UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.cornerRadius = 16 / 2
        button.setTitle("9", for: .normal)
        button.setTitleColor(.white , for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize { return CGSize(width: 48, height: 48) }
}




// MARK: Style and layout:
extension ShakeyBellView
{
    
    
    
    private func style()
    {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func layout()
    {
        addSubview(imageView)
        addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            
            buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
            buttonView.widthAnchor.constraint(equalToConstant: 16),
            buttonView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    
    
    private func setup()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    
    
    @objc private func imageViewTapped(_ recogniser: UITapGestureRecognizer)
    {
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }
    
    
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat)
    {
        let frameDuration = Double(1.0/6.0)
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration*2, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration*3, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration*4, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            
            UIView.addKeyframe(withRelativeStartTime: frameDuration*5, relativeDuration: frameDuration) {
                self.imageView.transform = CGAffineTransform.identity
            }
        } completion: { completion in
            return
        }

    }
    
    
    
}
