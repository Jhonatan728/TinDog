//
//  HomeViewController.swift
//  TinDog
//
//  Created by Jhonatan Miranda on 23/10/18.
//  Copyright © 2018 DatileraCO. All rights reserved.
//

import UIKit
import RevealingSplashView


class NavigationImageView : UIImageView {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
}
class HomeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    let revealingSplashScreen = RevealingSplashView(iconImage: <#T##UIImage#>(named:"splash"), iconInitialSize: <#T##CGSize#>(width:80, height:80), backgroundColor: <#T##UIColor#>.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SPLASH
        self.view.addSubview(self.revealingSplashScreen)
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()
        
        // Do any additional setup after loading the view.
        let tittleView = NavigationImageView()
        tittleView.image = UIImage(named:"bone")
        self.navigationItem.titleView = tittleView

        let homeGR = UIPanGestureRecognizer(target:self, action:#selector(cardDragged(gestureReconizer:)))
        self.cardView.addGestureRecognizer(homeGR)
        
        
    }
    
    @objc func cardDragged (gestureReconizer : UIPanGestureRecognizer){
        // print ("Drag")
        
        let cardPoint = gestureReconizer.translation(in: cardView)
        self.cardView.center = CGPoint(x:self.view.bounds.width/2 + cardPoint.x, y:self.view.bounds.height/2 + cardPoint.y)
        
        //Rotación y escala
        let xFromCenter = self.view.bounds.width / 2 - self.cardView.center.x
        var rotate = CGAffineTransform (rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        
        self.cardView.transform = finalTransform
        
        
        if gestureReconizer.state == .ended{
            if self.cardView.center.x < (self.view.bounds.width / 2 - 100){
                print ("Dislike")
                // Alfa del Like
                self.dislikeImage.alpha = min(abs(xFromCenter)/100, 1)
            }
            if self.cardView.center.x > (self.view.bounds.width / 2 + 100){
                print ("Like")
                // Alfa del Like
                self.likeImage.alpha = min(abs(xFromCenter)/100, 1)
            }
            
            //VALORES FINALES
            //Rotación final y escala
            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform = rotate.scaledBy(x: 1, y: 1)
            self.cardView.transform = finalTransform
         
            //Alfa del Like
            self.likeImage.alpha = 0
            //Alfa del Dislike
            self.dislikeImage.alpha = 0
            
            self.cardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2, y: (self.homeWrapper.bounds.height / 2) - 30)
        }

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
