//
//  SwiftyTextfields.swift
//  SwiftyTextfields
//
//  Created by Dimitrios Kalaitzidis on 18/12/2016.
//  Copyright © 2016 Dimitrios Kalaitzidis. All rights reserved.
//

import UIKit

@IBDesignable class SwiftyTextfields: UITextField{
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImageWidthHeight:CGRect = CGRect(x:0, y:0, width:14, height:14) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var enableShadow: Bool = false {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var optionalPlaceholder: String = "" {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var textfieldHeight: CGFloat = 30
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frameRect = self.frame
        frameRect.size.height = self.textfieldHeight
        self.frame = frameRect
        
        layer.backgroundColor = bgColor.cgColor
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        
        if(enableShadow == true){
            let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
            layer.masksToBounds =  false
            layer.shadowPath = shadowPath.cgPath
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: leftImageWidthHeight)
            imageView.image = image
            imageView.tintColor = UIColor.clear
            leftView = imageView
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        
        let placeholderText = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSForegroundColorAttributeName: placeholderColor])
        
        attributedPlaceholder = placeholderText
        
        if(optionalPlaceholder.characters.count > 0){
            let optionalPlaceholderText = NSAttributedString(string: optionalPlaceholder, attributes:[NSFontAttributeName:UIFont.italicSystemFont(ofSize: 10)])
            
            let combination = NSMutableAttributedString()
            combination.append(placeholderText)
            combination.append(optionalPlaceholderText)
            
            attributedPlaceholder = combination
            
        }
    }
    
    // Padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    // Padding for placeholder
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftImageWidthHeight.width + leftPadding * 2, dy: 0)
    }
    // Padding for text
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftImageWidthHeight.width + leftPadding * 2, dy: 0)
    }
}
