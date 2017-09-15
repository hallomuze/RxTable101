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
    
    let allCities = ["Seoul","Seo","Pakan","Pusan","New Hampshire","New York", "London", "Oslo","OMG","Madrid", "Moscow", "Berlin", "Praga"]
    
    var favCities :[String] = [];
    
    let disposeBag = DisposeBag()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        
        rxSetup()
    }
    
    func rxSetup(){
        
        searchBar.rx.text
            .orEmpty    //옵셔널 벗기기
            .debounce(0.6, scheduler: MainScheduler.instance) //3초 동안 여유를 준다!!
            .distinctUntilChanged() //동일한 값인 경우 이전 request 를 cancel 해줌.
            .subscribe(onNext: {[unowned self] (query) in
                
                self.favCities = self.allCities.filter{ $0.hasPrefix(query) }
               
                self.tableView.reloadData()
            }
        )
        .addDisposableTo(disposeBag)
    }
}

/*설명
 
 * orEmpty     
 
 옵셔널 벗기기

 
 * debounce
 
 찰나의 순간에도 마음이 변할 수 있다.
 방금 타이핑했던 값을 재빠르게 변경할때, 최초 입력값은 무시해준다.!!
 

 * distinctUntilChanged
 
 동일한 값이 나오면 매번 refresh 하는데
 이를 사용하면 중복값일 때 refresh 하지 않는다. 
 즉 중복 request 하지 않는다고 생각하면 됨.
 
*/

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
