//
//  MainTableViewCustomCell.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/16.
//

import UIKit
import Photos

import SnapKit

class MainTableViewCustomCell: UITableViewCell {
    
    static let identifier = "MainTableViewCustomCell"
    
    let thumbnailViewSize = 70
    let imageManager = PHCachingImageManager()
    let sampleImage = UIImage(systemName: "photo.on.rectangle")!.withTintColor(.gray, renderingMode: .alwaysOriginal).resized(to: CGSize(width: 70, height: 70))
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleText"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    private lazy var imageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "count"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageCountLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: 로직
extension MainTableViewCustomCell {
    
    func settingCell(title: String, album: PHFetchResult<PHAsset>){
        titleLabel.text = title
        imageCountLabel.text = String(album.count)
        
        guard let albumFirst = album.firstObject else {
            thumbnailImageView.image = sampleImage
            return
        }
        
        imageManager.requestImage(for: albumFirst, targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFill, options: .none) { [self]  (image, _) in
            thumbnailImageView.image = image ?? sampleImage
        }
    }
    
}

//MARK: 오토레이아웃
extension MainTableViewCustomCell {
    
    private func setLayout(){
        self.addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(thumbnailViewSize)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.top.equalTo(thumbnailImageView).offset(8)
            $0.bottom.equalTo(thumbnailImageView).offset(-8)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(16)
        }
    }
    
}
