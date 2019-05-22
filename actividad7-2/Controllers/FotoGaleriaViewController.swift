//
//  FotoGaleriaViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/11/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class FotoGaleriaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var albums = [Albums]()
    var userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        
        let reloadButton = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reloadAlbums))
        self.navigationItem.leftBarButtonItem = reloadButton
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let signOut = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutButton))
        self.navigationItem.rightBarButtonItem = signOut
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func setUpData(){
        db.collection("users").document(userID ?? "").collection("fotogalerias").getDocuments{ (snapshots, error) in
            if error != nil{
                print(error!)
            } else {
                for document in (snapshots?.documents)!{
                    if let name = document.data()["name"] as? String{
                        let titleName = name
                        if let fotos = document.data()["fotos"] as? [String]{
                            var imagenes = [String]()
                            for foto in fotos{
                                print("Foto: \(foto)")
                                imagenes.append(foto)
                            }
                            self.albums.append(Albums(title: titleName, images: imagenes))
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
            print(self.albums)
        }
    }
    
    @objc func reloadAlbums(){
        self.albums.removeAll()
        setUpData()
    }
    
    @objc func signOutButton(){
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard{
            let vc = storyboard.instantiateViewController(withIdentifier: "InitialViewControllerID") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    //MARK -- Collection View controllers
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums[section].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFotoGaleria", for: indexPath) as! ImagesCollectionViewCell
        
        let images = albums[indexPath.section]
        let imageStrings = images.images
        let imageString = imageStrings[indexPath.item]
        let url = URL(string: imageString)
        let data = NSData(contentsOf: url!)
        
        cell.imageView.image = UIImage(data: data! as Data)
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! ImageFullViewController
        let imagesAlbums = albums[indexPath.section]
        let imageSingle = imagesAlbums.images
        let imageString = imageSingle[indexPath.item]
        desVC.image = imageString
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
        let category = albums[indexPath.section]
        sectionHeaderView.categoryTitle = category.title
        return sectionHeaderView
    }

}
