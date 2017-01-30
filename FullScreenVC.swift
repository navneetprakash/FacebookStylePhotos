//
//  FullScreenVC.swift
//  Facebook Style Photos
//
//  Created by Navneet Prakash on 25/01/17.
//  Copyright © 2017 Navneet Prakash. All rights reserved.
//

import UIKit

let bound = UIScreen.main.bounds
let boundW = bound.size.width
let boundH = bound.size.height

class FullScreenVC: UIViewController , UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    private var _images: [UIImage]!
    private var _currentIndex = 0
    
    var images : [UIImage] {
        get {
            return _images
        }
        set {
            _images = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTheViews()
    }
    
    func setupTheViews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.albumsScrollView()
        
        //close button and background
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 15, width: 40, height: 40))
        button.setImage(UIImage(named: "close.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.alpha = 0.5
        
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(button)
    }
    
    func buttonAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }

    func albumsScrollView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: boundW, height: boundW))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:0)
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        self.albumsData()
    }
    
    func albumsData() {
        
        //let pageImages = [UIImage(named:"img1")!, UIImage(named:"img2")!, UIImage(named:"img3")!, UIImage(named:"img4")!, UIImage(named:"img5")!, UIImage(named:"img6")!]
        
        let pageImages = images
        
        self.photoPage(pageImages)
    }
    
    func photoPage(_ pageImages: Array<UIImage>) {
        
        let dx:CGFloat = 20
        let itemWidth = boundW + dx * CGFloat(2.0)
        
        for  i in 0..<pageImages.count {
            
            var frame = scrollView.bounds
            frame.origin.x = itemWidth * CGFloat(i)
            frame.origin.y = 0.0
            frame.size.width = itemWidth
            
            let newPageView = UIImageView(image: pageImages[i])
            newPageView.contentMode = UIViewContentMode.scaleAspectFit
            newPageView.frame = frame.insetBy(dx: dx, dy: 0)
            scrollView.addSubview(newPageView)
        }
        scrollView.frame = CGRect(x: -dx, y: 64, width: itemWidth, height: itemWidth)
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: itemWidth * CGFloat(pageImages.count), height: pagesScrollViewSize.height)
        
        self.initAccountPageControl()
    }
    
    func initAccountPageControl() {
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: boundW + 64, width: boundW, height: 50)
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.gray
        self.view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let xOffset: CGFloat = scrollView.contentOffset.x
        //print(xOffset)
        
        if (xOffset < 1.0) {
            pageControl.currentPage = 0
        } else if (xOffset < self.view.bounds.width + 1) {
            pageControl.currentPage = 1
        } else if (xOffset < (self.view.bounds.width*2) + 1) {
            pageControl.currentPage = 2
        }else{
            pageControl.currentPage = 3
        }
    }
}
