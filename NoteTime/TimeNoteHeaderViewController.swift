//
//  TimeNoteHeaderViewController.swift
//  NoteTime
//
//  Created by D_ttang on 15/12/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class TimeNoteHeaderViewController: UIViewController {

    var headerText: String?
    @IBOutlet weak var headerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        headerLabel.text = headerText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
