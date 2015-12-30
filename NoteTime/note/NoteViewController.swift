//
//  NoteViewController.swift
//  NoteTime
//
//  Created by D_ttang on 15/12/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

protocol NoteViewControllerDelegate: class {
    func deleteNote(note: Note?, indexPath: NSIndexPath?)
}

class NoteViewController: UIViewController {

    var nowColorEntry: [String : AnyObject] = ["color": UIColor.MKColor.LightBlue, "name": "默认颜色", "colorKey": "Default"]
    var note: Note?
    var indexPath: NSIndexPath?
    var colorIndex = 0
    
    //e9e9
    
    var delegate: NoteViewControllerDelegate?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textLabel.font = UIFont(name: GoogleIconName, size: 22.0)
        textLabel.text = GoogleIcon.e6f9
        
        colorLabel.font = UIFont(name: GoogleIconName, size: 15.0)
        colorLabel.text = GoogleIcon.eacd
        
        colorView.layer.borderColor = UIColor.MKColor.BlueGrey.CGColor
        colorView.layer.borderWidth = 0.3
        
        backBtn.titleLabel?.font = UIFont(name: GoogleIconName, size: 22.0)
        backBtn.titleLabel?.textColor = UIColor.whiteColor()
        backBtn.setTitle( GoogleIcon.ebac , forState: UIControlState.Normal)
        
        if note == nil {
            deleteBtn.alpha = 0.0
        }else {
            textView.text = note?.text
            colorIndex = note?.colorIndex as! Int
            nowColorEntry = Colors.colorArr[colorIndex]
        }
    }

    override func viewWillAppear(animated: Bool) {
        textView.becomeFirstResponder()
        
        textLabel.textColor = nowColorEntry["color"] as! UIColor
        
        colorLabel.textColor = nowColorEntry["color"] as! UIColor
        colorNameLabel.text = nowColorEntry["name"] as? String
        
        topView.backgroundColor = nowColorEntry["color"] as? UIColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        dismissViewControllerAnimated(true) {
            _ in
        }
    }

    @IBAction func showColorSelectView(sender: AnyObject) {
        let colorSelectView = storyboard?.instantiateViewControllerWithIdentifier("selectColorView") as! SelectColorViewController
        colorSelectView.delegate = self
        colorSelectView.nowColorEntry = nowColorEntry
        presentViewController(colorSelectView, animated: true, completion: nil)
    }
    
    @IBAction func deleteNoteAction(sender: AnyObject) {
        delegate?.deleteNote(note, indexPath: indexPath)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectColorSegue" {
            let viewController = segue.destinationViewController as? SelectColorViewController
            viewController?.nowColorEntry = nowColorEntry
            viewController?.delegate = self
        }
    }
    */

}

extension NoteViewController: SelectColorViewControllerDelegate {
    func colorPicker(picker: SelectColorViewController, didPickColorEntry colorEntry: [String : AnyObject], colorIndex index: Int) {
        nowColorEntry = colorEntry
        colorIndex = index
        dismissViewControllerAnimated(true, completion: nil)
    }
}
