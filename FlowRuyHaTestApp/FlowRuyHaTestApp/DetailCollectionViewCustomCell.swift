//
//  DetailCollectionViewCustomCell.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/17.
//

import UIKit
import Photos

import SnapKit

class DetailCollectionViewCustomCell: UICollectionViewCell {
    
    static let identifier = "DetailCollectionViewCustomCell"
    
    let imageManager = PHCachingImageManager()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailCollectionViewCustomCell{
    
    func setPhoto(photo: PHAsset){
        imageManager.requestImage(for: photo, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: .none) { [self]  (image, _) in
            thumbnailImageView.image = image
        }
    }
    
}

extension DetailCollectionViewCustomCell {
    private func setLayout(){
        self.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

