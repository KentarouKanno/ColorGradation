//
//  ViewController.swift
//  ColorGradetion
//
//  Created by KentarOu on 2016/09/06.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var colorBarView: UIView!
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let colors: [UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.orangeColor(), UIColor.cyanColor()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorBarView.backgroundColor = colors[0]
        for i in 0...4 {
            let vi = UIView(frame: CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: 100))
            vi.backgroundColor = colors[i]
            scrollView.contentSize = CGSize(width: screenWidth * CGFloat(colors.count), height: 100)
            scrollView.addSubview(vi)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset
        let page = (offset.x ) / screenWidth
        let pageInt = Int(page)
        
        if colors.count > Int(page + 1) {
            let currentColor = colors[Int(page)]
            let targetColor =  colors[Int(page + 1)]
            colorBarView.backgroundColor = UIColor.colorForOffsetPercentage(page - CGFloat(pageInt), beforeColor: currentColor, afterColor: targetColor)
        }
    }
}

// 参考URL : http://qiita.com/ryokosuge/items/d6b6ce3c76a268b60a11

extension UIColor {
    class func colorForOffsetPercentage(percentage: CGFloat, beforeColor: UIColor, afterColor: UIColor) -> UIColor {
        let beforeRGB = beforeColor.RGBForColor()
        let afterRGB = afterColor.RGBForColor()
        
        let actualRed = (afterRGB.red - beforeRGB.red) * percentage + beforeRGB.red
        let actualBlue = (afterRGB.blue - beforeRGB.blue) * percentage + beforeRGB.blue
        let actualGreen = (afterRGB.green - beforeRGB.green) * percentage + beforeRGB.green
        let actualAlpha = (afterRGB.alpha - beforeRGB.alpha) * percentage + beforeRGB.alpha
        
        return UIColor(red: actualRed, green: actualGreen, blue: actualBlue, alpha: actualAlpha)
    }
    
    func RGBForColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red  : CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue : CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
