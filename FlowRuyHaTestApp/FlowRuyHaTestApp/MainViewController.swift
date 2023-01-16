//
//  ViewController.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/16.
//

import UIKit
import Photos

import SnapKit

class MainViewController: UIViewController {
    //TestValue
    var testArray = [1,2]
    var sampleImage = UIImage(systemName: "photo.on.rectangle")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
    
    let tableViewCellHeight: CGFloat = 85
    let imageManager = PHCachingImageManager()
    var tableAlbums: Array<MainTableViewCoustomCellModel> = []
    
    
    private lazy var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCustomCell.self, forCellReuseIdentifier: MainTableViewCustomCell.identifier)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "앨범"
        setLayout()
        setTableView()
        
    }
    
    
}

extension MainViewController {
    func setTableView(){
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: .none)
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: .none)
        
        var myArray: Array<PHAssetCollection> = []
        
        for index in 0..<smartAlbums.count {
            myArray.append(smartAlbums.object(at: index))
        }
        
        for index in 0..<userAlbums.count {
            myArray.append(userAlbums.object(at: index))
        }

        for index in 0..<myArray.count {
            let currentTitle = myArray[index].localizedTitle ?? "404"
            let currentAlubm = PHAsset.fetchAssets(in: myArray[index], options: allPhotosOptions)
            if currentAlubm.firstObject != nil {
                imageManager.requestImage(for: currentAlubm.firstObject!, targetSize: CGSize(width: 75, height: 75), contentMode: .aspectFill, options: .none) { [self]  (image, _) in
                    tableAlbums.append(MainTableViewCoustomCellModel.init(thumbnailImage: image!, titleLabel: currentTitle, imageCount: currentAlubm.count))
                }
            } else {
                tableAlbums.append(MainTableViewCoustomCellModel.init(thumbnailImage: sampleImage, titleLabel: currentTitle, imageCount: currentAlubm.count))
            }
        }
    }
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   return testArray.count
        return tableAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCustomCell.identifier, for: indexPath)
        as! MainTableViewCustomCell
        cell.settingCell(thumbnailImage: tableAlbums[indexPath.row].thumbnailImage, title: tableAlbums[indexPath.row].titleLabel, count: tableAlbums[indexPath.row].imageCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
}


//MARK: 오토레이아웃관련 코드
extension MainViewController {
    
    func setLayout(){
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
