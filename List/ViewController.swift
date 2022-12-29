//
//  ViewController.swift
//  List
//
//  Created by Daichi Koga on 2021/03/30.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let fruits = ["りんご","みかん","レモン"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    //セルの数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath)
        cell.textLabel!.text=fruits[indexPath.row]
        return cell
    }
//どんなセルを表示させるか
}

