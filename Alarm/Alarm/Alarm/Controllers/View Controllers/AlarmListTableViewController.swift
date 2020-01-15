//
//  AlarmListTableViewCell.swift
//  Alarm
//
//  Created by Jacob LeCheminant on 1/13/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func alarmSwitchTapped(for cell: AlarmListTableViewController)
}

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDetailVC", for: indexPath) as? SwitchTableViewCell else {return UITableViewCell()}
        
        cell.alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        
        
        
        cell.updateViews()
        
        return cell

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find what alarm the user is trying to delete
            let alarmToDelete = AlarmController.sharedInstance.alarms[indexPath.row]
            // Delete it
            AlarmController.sharedInstance.deleteAlarm(alarm: alarmToDelete)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //Identifier: What segue was fired?
        if segue.identifier == "toAddAlarmScreen" {
            // Index: What cell was tapped on?
            if let index = tableView.indexPathForSelectedRow {
                // Destination: Where is the data going?
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
                // Find Object: What object am I sending?
                let alarm = AlarmController.sharedInstance.alarms[index.row]
                // Send Object: Assign that object to my landing pad.
                destinationVC.alarm = alarm
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
