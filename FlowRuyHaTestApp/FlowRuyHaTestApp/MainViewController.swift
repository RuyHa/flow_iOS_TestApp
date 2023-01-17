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
    
    let tableViewCellHeight: CGFloat = 85
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
            let currentTitle = myArray[index].localizedTitle ?? "무제 앨범"
            let currentAlubm = PHAsset.fetchAssets(in: myArray[index], options: allPhotosOptions)
            
            tableAlbums.append(MainTableViewCoustomCellModel.init(titleLabelText: currentTitle, alubm: currentAlubm))
        }
    }
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCustomCell.identifier, for: indexPath)
        as! MainTableViewCustomCell
        cell.settingCell(title: tableAlbums[indexPath.row].titleLabelText, album: tableAlbums[indexPath.row].alubm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCustomCell.identifier) as! MainTableViewCustomCell
        print(cell.thumbnailViewSize)
        tableView.deselectRow(at: indexPath, animated: true)
        print("Click Cell Number: " + String(indexPath.row))
        
        let nextVC = DetailViewController(myTitle:tableAlbums[indexPath.row].titleLabelText, alubm: tableAlbums[indexPath.row].alubm)
        self.navigationController?.pushViewController(nextVC, animated: true)
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
