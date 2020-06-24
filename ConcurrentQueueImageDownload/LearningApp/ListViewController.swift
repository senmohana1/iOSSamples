//
//  ViewController.swift
//  LearningApp
//
//  Created by Senthilnathan on 6/13/20.
//  Copyright © 2020 Senthilnathan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var presenter: ListPresenter! = nil
    var images = ["airplane.png","arctichare.png","baboon.png","barbara.bmp","barbara.png","boat.png","boy.bmp","cat.png","fruits.png","zelda.png","watch.png","tulips.png","serrano.png","sails.png","pool.png","peppers.png","mountain.png","monarch.png","lena.png","goldhill.png","girl.png","frymire.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        initilizePresenter()
    }
    
    private func initilizePresenter() {
        presenter = ListPresenter()
    }
    
    private func reloadTableView(isToReload:Bool, indexPath: IndexPath) {
        if isToReload {
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(named: "noimage")
        cell.tag = indexPath.row
        presenter.loadData(imageName: images[indexPath.row]) { info in
            DispatchQueue.main.async {
                if cell.tag == indexPath.row {
                    cell.imageView?.image = UIImage(data:info.image)
                    self.reloadTableView(isToReload: info.isToReload, indexPath: indexPath)
                }
            }
        }
        return cell
    }
}

