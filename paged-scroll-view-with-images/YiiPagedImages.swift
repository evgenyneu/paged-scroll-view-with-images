//
//  PagedStoryboardObject.swift
//  paged-scroll-view-with-images
//
//  Created by Evgenii Neumerzhitckii on 24/11/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class YiiPagedImages: NSObject, UIScrollViewDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  var placeholderImageName = "paged-scroll-view-with-images-placeholder.jpg"
  
  func setup() {
    scrollView.delegate = self
  }
  
  func load(image: UIImage) {
    TegPagedImages.loadImage(image, scrollView: scrollView, imageSize: imageSize)
    updatePageControl()
  }
  
  func addUrl(url: String) {
    TegPagedImages.addUrl(url, scrollView: scrollView, imageSize: imageSize,
      placeholderImage: placeholderImage)
    
    updatePageControl()
  }
  
  private func updatePageControl() {
    let numberOfPages = scrollView.subviews.count
    pageControl.backgroundColor = nil
    pageControl.numberOfPages = numberOfPages
  }
  
  private var imageSize: CGSize {
    scrollView.layoutIfNeeded()
    return scrollView.bounds.size
  }
  
  private var placeholderImage: UIImage? {
    return UIImage(named: placeholderImageName)
  }
}

// UIScrollViewDelegate
// --------------------------

typealias UIScrollViewDelegate_implementation = YiiPagedImages

extension UIScrollViewDelegate_implementation {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let xOffset = scrollView.contentOffset.x
    let currentPage = Int(xOffset / scrollView.frame.size.width)
    pageControl.currentPage = currentPage
    
    var i = 0
    for subview in scrollView.subviews {
      if let cell = subview as? TegPagedImagesCellView {
        if TegPagedImages.subviewVisible(scrollView, subview: cell) {
          cell.cellIsVisible()
        } else {
          cell.cellIsInvisible()
        }
      }
    }
  }
}
