//
//  ViewController.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/16.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    var testArray = [1,2]
    
    private lazy var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "앨범"
        setLayout()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell()
        myCell.textLabel?.text = "\(testArray[indexPath.row])"
        return myCell
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
