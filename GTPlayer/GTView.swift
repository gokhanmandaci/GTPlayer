//
//  GTView.swift
//  GTPlayer
//
//  Created by Gökhan Mandacı on 3.08.2018.
//  Copyright © 2018 Gökhan Mandacı. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation

@IBDesignable
class GTView: UIView {

    // MARK: Parameters
    let imageCache = AutoPurgingImageCache()
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    // MARK: Outlets
    @IBOutlet weak private var btnControl: UIButton!
    @IBOutlet weak var svContent: UIScrollView!
    @IBOutlet weak private var imgContent: UIImageView!
    
    // MARK: Actions
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - setup
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        svContent.delegate = self
        
        svContent.zoomScale = 1.0
        svContent.minimumZoomScale = 1.0
        svContent.maximumZoomScale = 10.0
        
        addSubview(view)
    }
    
    /// Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

// Public Methods
extension GTView {
    public func hibernate() {
        imgContent.image = UIImage()
    }
    public func setImageContent(mode: UIViewContentMode = .scaleAspectFill) {
        imgContent.contentMode = mode
    }
    public func loadImage(with imageString: String) {
        if imageString != "" {
            if let url = URL(string: imageString) {
                let urlRequest = URLRequest(url: url)
                ImageDownloader.default.download(urlRequest) { response in
                    if let responseValue = response.result.value {
                        self.imageCache.add(responseValue, withIdentifier: imageString)
                        self.imgContent.image = self.imageCache.image(withIdentifier: imageString)
                    }
                }
            }
        }
    }
    public func loadImage(with imageUrl: URL!) {
        let urlRequest = URLRequest(url: imageUrl)
        ImageDownloader.default.download(urlRequest) { response in
            if let responseValue = response.result.value {
                self.imageCache.add(responseValue, withIdentifier: imageUrl.absoluteString)
                self.imgContent.image = self.imageCache.image(withIdentifier: imageUrl.absoluteString)
            }
        }
    }
    public func loadImage(with image: UIImage) {
        imgContent.image = image
    }
    public func playVideo(with videoUrlString: String) {
        if videoUrlString != "" {
            if let videoUrl = URL(string: videoUrlString) {
                if player != nil {
                    player?.pause()
                    player = nil
                }
                if playerLayer != nil {
                    playerLayer?.removeFromSuperlayer()
                    playerLayer = nil
                }
                player = AVPlayer(url: videoUrl)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer?.frame = self.frame
                playerLayer?.backgroundColor = UIColor.clear.cgColor
                self.layer.addSublayer(playerLayer!)
                player?.play()
            }
        }
    }
    public func playVideo(with videoUrl: URL!) {
        player = AVPlayer(url: videoUrl)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.frame
        playerLayer?.backgroundColor = UIColor.clear.cgColor
        self.layer.addSublayer(playerLayer!)
        player?.play()
    }
}

extension GTView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgContent
    }
}
