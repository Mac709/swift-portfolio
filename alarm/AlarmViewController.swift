//
//  AlarmViewController.swift
//  alarm
//
//  Created by nori nori on 2021/03/21.
//

import UIKit
import UserNotifications
class AlarmViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let shared = AlarmViewController()
    var appDelegate = UIApplication.shared
    
    @IBOutlet weak var tableView: UITableView!
    var userDefaults = UserDefaults.standard
    var index : Int!
    
    var timeArray:[AlarmTimeArray] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsSelection = false
        tableView.register(UINib(nibName : "AlarmTimeCell", bundle : nil), forCellReuseIdentifier : "AlarmTimeCell")
        self.navigationItem.setLeftBarButton(self.editButtonItem, animated : true)
        timeLoad()
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector : #selector(self.methodOfReceivedNotification(notification:)), name : Notification.Name("NoticationIdentifier"), object : nil)
    }
    @objc func methodOfReceivedNotification(notification : Notification) {
        timeLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func timeLoad() {
        if let timeArrayData = UserDefaults.standard.object(forKey : "timeArray") as? Data {
            if let getTimeArray = try!
                NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(timeArrayData) as?
                [AlarmTimeArray] {
                timeArray = getTimeArray
                }
        }
    }
    
    override func setEditing(_ editing : Bool, animated : Bool) {
        super.setEditing(editing, animated : animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func setCellLabel(index : Int) -> String{
        if timeArray[index].repeatLabel == "Never" {
            return timeArray[index].label
            
        }else{
            return timeArray[index].label + "," + timeArray[index].repeatLabel
        }
    }
    
    func getAlarm(from uuid : String) {
        timeLoad()
        guard let alarm = timeArray.first(where : {$0.uuidString == uuid}) else {return}
        if alarm.week.isEmpty {
            alarm.onOff = false
    }
        saveDate()
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
    }
    
    func tableView(_ tableView : UITableView, numberOfRowsInSection sectioin : Int) -> Int {
        return timeArray.count
    }
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier : "AlarmTimeCell") as! AlarmTimeCell
        
        cell.timeLabel.text = getTime(date : timeArray[indexPath.row].date)
        cell.label.text = setCellLabel(index : indexPath.row)
        cell.sw.isOn = timeArray[indexPath.row].onOff
        cell.editingAccessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        //?????????????????????
        if tableView.isEditing {
            index = indexPath.row
            performSegue(withIdentifier : "showAlarmAdd", sender : nil)
        }
    }
    
    
    func tableView(_ tableView : UITableView, commit editingStyle : UITableViewCell.EditingStyle, forRowAt indexPath : IndexPath) {
        if editingStyle == .delete {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers : [timeArray[indexPath.row].uuidString])
            timeArray.remove(at : indexPath.row)
            tableView.deleteRows(at : [indexPath], with : .fade)
            saveDate()
        }
    }
    
    func tableView(_ tableView : UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat {
        return 72
    }
    
    @IBAction func addButton(_ sender : Any) {
        self.performSegue(withIdentifier : "showAlarmAdd", sender : nil)
    }
    
    func getTime(date : Date) -> String {
        let f = DateFormatter()
        f.timeStyle = .short
        f.locale = Locale(identifier : "ja_JP")
        return f.string(from : date)
    }
    
    func saveDate() {
        let timeArrayData = try! NSKeyedArchiver.archivedData(withRootObject : timeArray, requiringSecureCoding : false)
        userDefaults.set(timeArrayData, forKey : "timeArray")
        userDefaults.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlarmAdd"{
            guard let nvc = segue.destination as? UINavigationController else {return}
            guard let vc = nvc.topViewController as? AlarmAddViewController else {return}
            vc.delegate = self
            vc.isEdit = tableView.isEditing
            if tableView.isEditing {
                vc.alarmTime = timeArray[index]
            }
    }
}
}


extension AlarmViewController:AlarmAddDelegate{
    func AlarmAddViewController(alarmAdd:AlarmAddViewController, alarmTime: AlarmTimeArray){
        if tableView.isEditing {
            timeArray[index] = alarmTime
        }else{
            timeArray.append(alarmTime)
        }
        timeArray.sort() {$0.date < $1.date}
        saveDate()
        self.setEditing(false, animated : false)
        tableView.reloadData()
    }
    
    func AlarmAddViewController(alarmDelete : AlarmAddViewController, alarmTime : AlarmTimeArray) {
        self.setEditing(false, animated : false)
        timeArray.remove(at : index)
        saveDate()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers : [timeArray[index].uuidString])
    }
    
    func AlarmAddViewController(alarmCancel : AlarmAddViewController) {
        self.setEditing(false, animated : false)
    }
}
