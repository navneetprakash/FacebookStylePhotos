//
//  ViewController.swift
//  Facebook Style Photos
//
//  Created by Navneet Prakash on 19/01/17.
//  Copyright © 2017 Navneet Prakash. All rights reserved.
//

import UIKit
import TRMosaicLayout

extension ViewController: TRMosaicLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        // setting every (n) cell as .Big or small
        return indexPath.item % 4 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 100
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    //array of images
    var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        images.append(UIImage(named: "img1.jpeg")!)
        images.append(UIImage(named: "img2.jpeg")!)
        images.append(UIImage(named: "img3.jpeg")!)
        images.append(UIImage(named: "img4.jpeg")!)
        images.append(UIImage(named: "img5.jpeg")!)
        images.append(UIImage(named: "img6.jpeg")!)
        
        collection.dataSource = self
        collection.delegate = self
        
        let mosaicLayout = TRMosaicLayout()
        self.collection?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? ImagesCell {
            
            let imageView = UIImageView(image: images[indexPath.row])
            imageView.frame = cell.frame
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            
            
            //target the 3rd item in cell to have overlay and image count display
            
            if (indexPath.item == 3) {
                
                let imgCount = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
                imgCount.textAlignment = NSTextAlignment.center
                imgCount.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
                imgCount.backgroundColor = UIColor.black
                imgCount.alpha = 0.7
                imgCount.text = "+\(images.count)"
                imgCount.textColor = UIColor.white
                cell.contentView.addSubview(imgCount)
            }
            
            cell.backgroundView = imageView
            collectionView.backgroundColor = UIColor.white
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //max number of item to display on screen, we need only 3 on the right hand side screen blocks
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //perform seque to tranf images to next screen
        var img : [UIImage] = []
        img = images
        
        performSegue(withIdentifier: "fullscreen", sender: img)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? FullScreenVC {
            if let img = sender as? [UIImage] {
                destination.images = img
            }
        }
    }

}



