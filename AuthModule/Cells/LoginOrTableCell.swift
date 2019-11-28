//
//  LoginOrTableCell.swift
//  AuthSampleApp
//
//  Created by Nitin Chadha on 26/11/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit

class LoginOrTableCell: UITableViewCell {
    
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    static let height:CGFloat = 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInitialConfigurations()
    }
    
    func doInitialConfigurations() {
        leftView.backgroundColor = .customBackgroundColor
        rightView.backgroundColor = .customBackgroundColor
        self.drawDottedLine(start: CGPoint(x: leftView.bounds.minX, y: leftView.bounds.minY), end: CGPoint(x: leftView.bounds.maxX, y: leftView.bounds.minY), view: leftView)
        self.drawDottedLine(start: CGPoint(x: rightView.bounds.minX, y: rightView.bounds.minY), end: CGPoint(x: rightView.bounds.maxX, y: rightView.bounds.minY), view: rightView)
    }
    
    fileprivate func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [5, 2]
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
}
