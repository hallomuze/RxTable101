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
    @IBOutlet weak var searchBar: UISearchBar!
    
    let allCities = ["Seoul","Pusan","New York", "London", "Oslo", "Moscow", "Berlin", "Praga"]
    
    var favCities :[String] = [];
    
    let disposeBag = DisposeBag()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        
        rxSetup()
    }
    
    func rxSetup(){
        
        searchBar.rx.text.orEmpty
            .subscribe(onNext: { (query) in
                
                self.favCities = self.allCities.filter{ $0.hasPrefix(query) }
                
                //도시명의 앞부분 철자가 일치하면 favCities 로 넣는다.
                
                self.tableView.reloadData()
            }
        )
        .addDisposableTo(disposeBag)
    }
}



// MARK: - UITableView 데이터소스만 확장해주면 됩니다.

// delegate 설정은 불필요합니다.

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = favCities[indexPath.row]
        
        return cell
    }
}
