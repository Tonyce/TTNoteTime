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

    let dateFormatter = NSDateFormatter()
    var viewController: ViewController?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
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
            let date = dates.getTimeStrWithFormate("MM-dd")
//            let time = dates.getTimeStrWithFormate("HH:mm:ss")

            dateLabel.text = date
            dateFormatter.timeStyle = .ShortStyle
            timeLabel.text = dateFormatter.stringFromDate(dates)
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

    
    
    @IBAction func shouqiAction(sender: AnyObject) {
        
//        textViewHeight.relation = NSLayoutRelation.Equal
//        print(textViewHeight)
                print(self.frame.height)
        
        textViewHeight = NSLayoutConstraint(item: mainTextView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal,
            toItem: mainTextView, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 45)
        
        print(textViewHeight)
        
        self.layoutIfNeeded()
        print(self.frame.height)
        
        viewController?.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.None)
//        viewController.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
}

