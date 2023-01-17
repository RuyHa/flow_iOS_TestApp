//
//  DetailViewController.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/17.
//

import UIKit
import Photos

import SnapKit

class DetailViewController: UIViewController {

    var alubm: PHFetchResult<PHAsset>
    var myTitle: String
    
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
        // Do any additional setup after loading the view.
    }
    

}

//MARK: 오토레이아웃
extension DetailViewController {
    
    func setLayout(){
        
    }
    
}
