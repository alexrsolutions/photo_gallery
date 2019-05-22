//
//  UploadViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/13/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit
import YPImagePicker
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    let db = Firestore.firestore()
    var arrayOfImages = [String]()
    var userID = Auth.auth().currentUser?.uid
    var arrayData = [Any]()
    weak var delegateFoto: FotoGaleriaViewController?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var uploadImages: UIButton!
    @IBOutlet weak var labelSuccess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func uploadToDatabase(_ sender: Any) {
        for items in arrayData{
            let imageRef = Storage.storage().reference().child("images/" + self.randomIdentifier(20) + ".jpeg")
            imageRef.putData(items as! Data, metadata: nil){ (metadata, error) in
                if error != nil{
                    print("Error")
                }else{
                    imageRef.downloadURL{ url, error in
                        if let error = error {
                            print(error)
                            self.labelSuccess.text = "Upload Unsuccessful"
                            self.labelSuccess.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        } else {
                            self.arrayOfImages.append(url?.absoluteString ?? "")
                            self.labelSuccess.text = "Upload Successful, press again to confirm upload"
                            self.labelSuccess.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                        }
                    }
                }
            }
        }
        addPicture()
    }
    
    @IBAction func deleteImages(_ sender: Any) {
        arrayOfImages.removeAll();
        arrayData.removeAll();
        collectionView.reloadData();
        labelSuccess.text = "Images deleted"
        labelSuccess.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    func addPicture(){
        if let titleAlbum = nameLabel.text{
            if arrayOfImages.count > 0 {
                let dict: [String : Any] = ["name":titleAlbum, "fotos":arrayOfImages]
                
                db.collection("users").document(userID ?? "").collection("fotogalerias").addDocument(data: dict)
                labelSuccess.text = "Upload Complete"
                labelSuccess.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
        }else{
            labelSuccess.text = "Name of Album missing"
            labelSuccess.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
    
    //MARK: imports images to data
    @IBAction func importImage(_ sender: Any) {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 5
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo.originalImage)
                    let image = photo.originalImage
                    var data = Data()
                    data = image.jpegData(compressionQuality: 0.75)!
                    self.arrayData.append(data)
                case .video(let video):
                    print(video)
                }
            }
            self.collectionView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    

    /* MARK - Create random ID for images */
    func randomIdentifier(_ length: Int) -> String{
        let letters : NSString = "abcdefghijlmnopqrstvwxyz123456789ABCDEFGHIJKLMNOPQRSTVWXYZ"
        let len = UInt32(letters.length)
        var randomString = ""
        
        for _ in 0 ..< length{
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    // MARK: Show pictures to upload
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCell", for: indexPath) as! previewImagesCell
        
        let imageData = arrayData[indexPath.row]
        cell.imageCell.image = UIImage(data: imageData as! Data)
        
        return cell
    }

}
