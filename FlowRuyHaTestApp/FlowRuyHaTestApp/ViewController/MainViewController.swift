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
    
    private lazy var notPermissionTitle: UILabel = {
        let label = UILabel()
        label.text = "사진을 가져올 수 없습니다."
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    private lazy var notPermissionMessage: UILabel = {
        let label = UILabel()
        label.text = "앱을 재실행해 권한을 변경해주세요."
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [notPermissionTitle, notPermissionMessage])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "앨범"
        setPhotoPermission()
    }
    
}

//MARK: 로직
extension MainViewController {
    
    func setPhotoPermission(){
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.setLayout()
                    self.setTableView()
                }
            case .limited:
                DispatchQueue.main.async {
                    self.setLayout()
                    self.setTableView()
                }
            default:
                DispatchQueue.main.async {
                    self.authSettingOpen()
                    
                    self.setNotPermissionLayout()
                }
            }
        }
    }
    
    func authSettingOpen() {
        let message = "해당앱은 사진 접근 접근 권한 없이 사용할 수 없습니다. 권한 허용을 위해 설정 화면으로 이동하시겠습니까?"
        let alert = UIAlertController(title: "설정", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive) { (UIAlertAction) in
        }
        let confirm = UIAlertAction(title: "확인", style: .default) { (UIAlertAction) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setTableView(){
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
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

//MARK: TableVie 관련 로직
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
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = DetailViewController(myTitle:tableAlbums[indexPath.row].titleLabelText, alubm: tableAlbums[indexPath.row].alubm)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

//MARK: 오토레이아웃
extension MainViewController {
    
    func setLayout(){
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func setNotPermissionLayout(){
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
