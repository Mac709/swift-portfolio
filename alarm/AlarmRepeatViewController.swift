//
//  AlarmRepeatviewController.swift
//  alarm
//
//  Created by nori nori on 2021/03/23.
//

import UIKit
protocol AlarmRepeatViewControllerDelegate {
    func AlarmRepeatViewController(addRepeat:AlarmRepeatViewController,week:[String])
}
class AlarmRepeatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var delegate:AlarmRepeatViewControllerDelegate!
    var week:[String] = []
    var selectDay:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 複数選択可にする
        tableView.allowsMultipleSelection = true
         week = DateFormatter().weekdaySymbols!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.AlarmRepeatViewController(addRepeat: self, week:sortWeek(selectDays: selectDay))
    }
    
    func sortWeek(selectDays: [String]) ->  [String]{
        var week = DateFormatter().weekdaySymbols!
        var dayDictionary: [String: Int] = [:]
        for i in 0...6 {
            dayDictionary[week[i]] = i
        }
        var daysOfWeek: [String] = selectDays
         daysOfWeek.sort { (dayDictionary[$0] ?? 7) < (dayDictionary[$1] ?? 7)}
        return daysOfWeek
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return week.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "weekCell", for: indexPath)
        cell.textLabel!.text = "Every"+week[indexPath.row]
        cell.selectionStyle = .none
        for i in selectDay {
             if week[indexPath.row] == i {
                cell.accessoryType = .checkmark
                break
            }else{
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        selectDay.append(week[indexPath.row])
    }
    
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを外す
        cell?.accessoryType = .none
        selectDay = selectDay.filter { $0 != week[indexPath.row] }
    }
}

