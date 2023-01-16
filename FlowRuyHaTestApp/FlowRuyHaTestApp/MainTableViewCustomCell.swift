//
//  MainTableViewCustomCell.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/16.
//

import UIKit
import SnapKit

class MainTableViewCustomCell: UITableViewCell {
    
    static let identifier = "MainTableViewCustomCell"
    
    let thumbnailViewSize = 70
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test_image")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "titleText"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(hex: "#000000")
        return label
    }()
    
    private lazy var imageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "count"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hex: "#000000")
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

//MARK: 오토레이아웃
extension MainTableViewCustomCell {
    
    func setLayout(){
        
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
