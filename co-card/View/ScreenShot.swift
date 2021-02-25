//
//  ScreenShot.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/10.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation
import UIKit

class ScreenShot {
    
    private var screenShotImage = UIImage()
    
    func take(size: CGSize, width: CGFloat, height: CGFloat, view:UIView) {

    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

    screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        
    UIGraphicsEndImageContext()
    
    }
    
    func share(size: CGSize, width: CGFloat, height: CGFloat, view:UIView) -> UIActivityViewController{
        
        take(size: size, width: width, height: height, view: view)

        let items = [screenShotImage] as [Any]

        // アクティビティビューに載せて、シェア
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)

        return activityVC
        
    }
}
