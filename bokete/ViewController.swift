//
//  ViewController.swift
//  bokete
//
//  Created by HechiZan on 2021/08/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var odaiImageView: UIImageView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var checkPermission = CheckPermisson()
    
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        checkPermission.checkCamera()
        commentTextView.layer.cornerRadius = 20.0
     
        getImages(keyword: "funny")
      
        
    }

    //検索キーワードの値を元に画像を引っ張ってくる

    func getImages(keyword:String){
        
        //API Key 23012967-e149bc81b6f2da735b4a54a98
        let url = "https://pixabay.com/api/?key=23012967-e149bc81b6f2da735b4a54a98&q=\(keyword)"
        
        //Alamofireを使ってリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
            
            //responseに値が入ってきた時
            case .success:
                let json:JSON = JSON(response.data as Any)//１データを取得
                var imageString = json["hits"][self.count]["webformatURL"].string//String型でJsonのhits配列に入っている０番目ブロックのwebformatURLを取得してください。の意味「count」は次のお題に行った時に１番目のブロックのwebformatURLを取りたいからcount変数をインクリメントしていく必要がある
                
                //もうこれ以上countないよ！
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }else{
                    
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                    
                }
              
            case .failure(let error):
                
                print(error)
            }
        }
  
        
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count = count + 1
        //空なら
        if searchTextField.text == ""{
            
            getImages(keyword: "funny")
            
        }else{
            
            getImages(keyword: searchTextField.text!)
        }
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0//hitsのカウントを０に戻す
        if searchTextField.text == ""{
            
            getImages(keyword: "funny")
            
        }else{
            
            getImages(keyword: searchTextField.text!)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        searchTextField.resignFirstResponder()
        searchTextField.resignFirstResponder()
        
    }
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as? NextViewController
        nextVC?.commentString = commentTextView.text
        nextVC?.resultImage = odaiImageView.image!
    }
    
}

