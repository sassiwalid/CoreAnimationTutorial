//
//  ViewController.swift
//  CoreAnimationTutorial
//
//  Created by walid sassi on 2/21/20.
//  Copyright © 2020 walid sassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewAnimation: UIView!
    var layer = CAShapeLayer()
    var gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMainLayer()
    }
    func setupGradientLayer(){
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor,UIColor.green.cgColor]
        gradientLayer.locations = [0.0, 0.33, 0.66]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.frame = self.view.frame
        gradientLayer.mask = layer
        viewAnimation.layer.addSublayer(gradientLayer)
    }
    func setupMainLayer(){
        layer.frame = CGRect(x: self.view.frame.width / 2 - 50 , y: 50.0, width: 150.0, height: viewAnimation.frame.size.height * 0.75)
        layer.fillColor = UIColor.brown.cgColor
        drawShapePath()
    }
    func drawShapePath() {
        let combinedPath = CGMutablePath()
        // First draw the First Circle Path
        let arcCenter = CGPoint(x: viewAnimation.frame.size.width / 2 - 150 , y: viewAnimation.frame.size.height  * 0.1)
        let radius = CGFloat(60.0)
        let startAngle = CGFloat(0.0)
        let endAngle = -CGFloat.pi
        let clockwise = false

        let openCirclePath = UIBezierPath(arcCenter: arcCenter,
                                             radius: radius,
                                         startAngle: startAngle,
                                           endAngle: endAngle,
                                          clockwise: clockwise)
        combinedPath.addPath(openCirclePath.cgPath)
        let openSquarePath = UIBezierPath()
        openSquarePath.move(to: CGPoint(x: self.view.frame.width / 2 - 210, y: viewAnimation.frame.size.height  * 0.1))
        openSquarePath.addLine(to: CGPoint(x: self.view.frame.width / 2 - 210, y: viewAnimation.frame.size.height * 0.75))
        openSquarePath.addLine(to: CGPoint(x: self.view.frame.width / 2 - 90, y: viewAnimation.frame.size.height * 0.75))
        openSquarePath.addLine(to: CGPoint(x: self.view.frame.width / 2 - 90, y: viewAnimation.frame.size.height  * 0.1))
        combinedPath.addPath(openSquarePath.cgPath)
        let arcCenter2 = CGPoint(x: self.view.frame.width / 2 - 150, y: viewAnimation.frame.size.height  * 0.75 )

        let openCirclePath2 = UIBezierPath(arcCenter: arcCenter2,
                                             radius: radius,
                                         startAngle: startAngle,
                                           endAngle: endAngle,
                                          clockwise: !clockwise)
        combinedPath.addPath(openCirclePath2.cgPath)
        layer.path = combinedPath
        setupGradientLayer()
    }

    @IBAction func startAnimationClicked(_ sender: Any) {
        // set up the animation
        let animation = CABasicAnimation(keyPath: "locations")
        let toColors = [0.33,0.66,1.0]
        let fromColors = [0.0,0.0,0.0]
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 2.0
        animation.repeatCount = Float.infinity
        // add the animation to the gradient
        gradientLayer.add(animation, forKey: nil)
    }
    
}

