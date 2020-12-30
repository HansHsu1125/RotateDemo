//
//  ViewController.swift
//  RotateDemoProject
//
//  Created by Hans Hsu on 2020/8/16.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

typealias ContentInfo = (title: String , content: String)
let RowTitle: String = "row %ld - item %ld "
let RowContent: String = "item %ld content :  **************************************************************"

class ViewController: UIViewController {
    let maxDataCount: Int = 30
    let reuseIdentify: String = "ContentCell"
    let tableView: UITableView = .init(frame: .zero, style: .plain)
    var shouldRefreshLayout: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    override func updateViewConstraints() {
        if shouldRefreshLayout {
            shouldRefreshLayout = false
            setupConstraints()
        }
        super.updateViewConstraints()
    }
}

//private api
private extension ViewController {
    func setupViews() {
        tableView.register(ConetentCell.self, forCellReuseIdentifier: reuseIdentify)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide:UILayoutGuide = view.safeAreaLayoutGuide
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor , constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor , constant: -10).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant:  10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor , constant: -10).isActive = true
    }
}

// UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxDataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contentCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentify) as? ConetentCell else {
            let cell = ConetentCell.init(style: .default, reuseIdentifier: reuseIdentify)
            return cell
        }

        return contentCell
    }
}

// UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < maxDataCount else { return }
        guard let contentCell = cell as? ConetentCell else { return }
        
        let itemIndex:Int = indexPath.row + 1
        let rowTitle:String = .init(format: RowTitle, indexPath.row , itemIndex)
        let rowContent:String = .init(format: RowContent, itemIndex)
        let contetnInfo:ContentInfo = (rowTitle , rowContent)
        contentCell.configure(info: contetnInfo)
    }
}
