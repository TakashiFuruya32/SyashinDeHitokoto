//
//  NextViewController.swift
//  bokete
//
//  Created by HechiZan on 2021/08/20.
//

import UIKit

class NextViewController: UIViewController {

    
    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
     
    }
    

    @IBAction func share(_ sender: Any) {
        
        //スクリーンショットを撮る
        screenShot()
        //アクティビティビューに乗せてシェアする
        let items = [screenShotImage] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
        
    }
    
    
    //スクリーンショットを撮る
    func screenShot(){
        
        
        let width = CGFloat(UIScreen.main.bounds.width)
        let height = CGFloat(UIScreen.main.bounds.height/1.3)
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        //viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
