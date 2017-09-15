//
//  ViewController.swift
//  RxTable101
//
//  Created by artist on 15/09/2017.
//  Copyright © 2017 Eddie Kwon. All rights reserved.
//

//  STEP 1 : UITableView 기본 골격만 구성함.

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let allCities = ["Seoul","Pusan","New York", "London", "Oslo", "Moscow", "Berlin", "Praga"]
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
    }
}



// MARK: - UITableView 데이터소스만 확장해주면 됩니다.

// delegate 설정은 불필요합니다.

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allCities[indexPath.row]
        
        return cell
    }
}
