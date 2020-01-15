//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Jacob LeCheminant on 1/13/20.
//  Copyright © 2020 Jacob LeCheminant. All rights reserved.
//

import UIKit

protocol AlarmCellDelegate: class {
    func alarmSwitchTapped(for cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
        
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var alarmSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
     var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
 
    
    func updateViews() {
        guard let alarm = alarm else {return}
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
} // End of class
