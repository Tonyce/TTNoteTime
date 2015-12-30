//
//  TimeNoteCell.swift
//  NoteTime
//
//  Created by D_ttang on 15/12/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class TimeNoteCell: UITableViewCell {
    
    var note: Note? {
        didSet {
            setUpCell()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var circleLabel: UILabel!
    @IBOutlet weak var mainTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell() {
        
        let dates = note?.time
        
        if let dates = dates {
//            let date = dates.getTimeStrWithFormate("yyyy-MM-dd")
            let time = dates.getTimeStrWithFormate("HH:mm:ss")
            timeLabel.text = time
        }

        
//        timeLabel.text = "10:00 PM"
        circleLabel.font = UIFont(name: GoogleIconName , size: 13)
        circleLabel.text = GoogleIcon.ea2d
        
        if let colorIndex = note!.colorIndex as? Int {
            let color = Colors.colorArr[colorIndex]
            circleLabel.textColor = color["color"] as? UIColor
        }else {
            circleLabel.textColor = GMColor.blue500Color()
        }
        
        mainTextView.text = note!.text
    }

}

