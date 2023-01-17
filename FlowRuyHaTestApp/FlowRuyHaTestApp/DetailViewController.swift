//
//  DetailViewController.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/17.
//

import UIKit
import Photos

import SnapKit

class DetailViewController: UIViewController{
    
    var alubm: PHFetchResult<PHAsset>
    var myTitle: String
    
    
    private lazy var myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width - 10
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailCollectionViewCustomCell.self, forCellWithReuseIdentifier: "DetailCollectionViewCustomCell")
        return collectionView
    }()
    
    init(myTitle:String, alubm: PHFetchResult<PHAsset>) {
        self.myTitle = myTitle
        self.alubm = alubm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = myTitle
        view.backgroundColor = .red
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    
}

//MARK: 오토레이아웃
extension DetailViewController {
    
    func setLayout(){
        view.addSubview(myCollectionView)
        myCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alubm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCustomCell", for: indexPath) as! DetailCollectionViewCustomCell
        cell.setPhoto(photo: alubm[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlert(photo: alubm[indexPath.row])
    }
    
    func showAlert(photo:PHAsset){
        var message = ""
        let resource = PHAssetResource.assetResources(for: photo)
        let filename = resource.first?.originalFilename ?? "unknown"
        
        var sizeOnDisk: Int64? = 0
        let unsignedInt64 = resource.first?.value(forKey: "fileSize") as? CLong
        sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
        let fileSize = String(format: "%.2f", Double(sizeOnDisk!) / (1024.0*1024.0))+" MB"
        message = "파일명 : \(filename)\n파일크기: \(fileSize)"
        
        let optionMenu = UIAlertController(title: "사진정보", message: message, preferredStyle: .alert)
        let checkAction = UIAlertAction(title: "확인", style: .cancel) {_ in
        }
        
        optionMenu.addAction(checkAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

