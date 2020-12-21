//
//  ImageScrollView.swift
//  AppCraftTest
//
//  Created by Дарья on 20.12.2020.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imageView: UIImageView!
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    func set(image: UIImage) {
//        imageView?.removeFromSuperview()
//        imageView = nil
        imageView = UIImageView(image: image)
        self.addSubview(imageView)
        print(image)
        
        configureFor(size: image.size)
    }
    
    func configureFor(size: CGSize) {
        setZoomScale()
        self.contentSize = size
        self.zoomScale = self.minimumZoomScale
        
        self.imageView.addGestureRecognizer(self.zoomingTap)
        self.imageView.isUserInteractionEnabled = true
    }
    
    // расчеты чтобы при зуме картинка при отпускании возвращ в изнач размер
    func setZoomScale(){
        let boundsSize = self.bounds.size //зафиксировали рамки
        let imageSize = imageView.bounds.size //зафиксировали рамер картинки
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height // похоже на аспект рейша
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        if minScale < 0.1 {
            maxScale = 0.3
        } else if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        } else {
            maxScale = max(1.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
    }
    
    func centerImage(){
//        let boundsSize = self.bounds.size
//        print(imageView as Any)
//        var frameToCenter = imageView.frame
//
//        if frameToCenter.size.width < boundsSize.width {
//            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
//        } else {
//            frameToCenter.origin.x = 0
//        }
//
//        if frameToCenter.size.height < boundsSize.height {
//            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
//        } else {
//            frameToCenter.origin.y = 0
//        }
//
//        imageView.frame = frameToCenter
    }
    
    //MARK: UITapGestureRecognizer
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer){
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    func zoom(point: CGPoint, animated: Bool) {
        let currectScale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currectScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UIScrollViewDelegate - for zoom
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
    
}
