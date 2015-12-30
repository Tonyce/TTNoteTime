//
//  ViewController.swift
//  NoteTime
//
//  Created by D_ttang on 15/12/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let openTransition = OpenAnimation()
    var managedContext: NSManagedObjectContext!
    var notes = [Note]()
    
    var selectedNote: Note?
    var selectedIndexPath: NSIndexPath?
    
    let datas = [
        [
            "key":"one",
            "datas":[
                ["time":"21", "text":"是减肥打手机发电视剧发的是开放的是的空间按附件的垃圾费看得见啊jkdjfka的境况放假大放假打卡机飞就看得见反馈的减肥jkdjajfldajklf 贷记卡家乐福大家快乐防静电阿里的积分大姐夫放假啊考虑放假了案件反馈的安家费看大家分开打反馈到敬爱放的骄傲看反馈卡就飞快的放假jkdja将开发大姐夫就打开附件安定放假开打放假的卡风较大飞交罚款的姐夫"],
                ["time":"21", "text":"fasdfasfasfsdkfjasdkl;fjakdlgjalkds;jgaksd;jfaks;djgask;djfasdkl;jgas;kdjaksld;fjas;d"],
                ["time":"21", "text":"fasdfasfasfsdkfjasdkl"]
            ]
//        ],
//        [
//            "key":"two",
//            "datas":[
//                ["time":"two21", "text":"fasdfasfasfsdkfjasdkl;fjakdlgjalkds;jgaksd;jfaks;djgask;djfasdkl;jgas;kdjaksld;fjas;d"],
//                ["time":"two21", "text":"fasdfasfasfsdkfjasdkl;fjakdlgjalkds;jgaksd;jfaks;djgask;djfasdkl;jgas;kdjaksld;fjas;d"],
//                ["time":"two21", "text":"fasdfasfasfsdkfjasdkl"]
//            ]
//        ],
//        
//        [
//            "key":"three",
//            "datas":[
//                ["time":"three21", "text":"fasdfasfasfsdkfjasdkl;fjakdlgjalkds;jgaksd;jfaks;djgask;djfasdkl;jgas;kdjaksld;fjas;d"],
//                ["time":"three21", "text":"fasdfasfasfsdkfjasdkl;fjakdlgjalkds;jgaksd;jfaks;djgask;djfasdkl;jgas;kdjaksld;fjas;d"],
//                ["time":"three21", "text":"fasdfasfasfsdkfjasdkl"]
//            ]
        ]
    ]
    
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var topView: UIView!
//    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpViews()
        loadDataFromSQL()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromSQL() {
        let request = NSFetchRequest(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
        
        do {
            notes = try managedContext.executeFetchRequest(request) as! [Note]
        }catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
//        print(notes)
    }
    
    func setUpViews() {
//        headerView.backgroundColor = UIColor.MKColor.LightBlue
        view.backgroundColor = UIColor.MKColor.LightBlue
        topView.backgroundColor = UIColor.MKColor.LightBlue
        topBackView.backgroundColor = UIColor.MKColor.LightBlue
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = topView
        
        addButton.layer.zPosition = 100
        addButton.setCircleRadius()
        addButton.setShadow()
        addButton.titleLabel?.font = UIFont(name: "googleicon", size: 30)
        addButton.setTitle(GoogleIcon.e803, forState: UIControlState.Normal)
        addButton.backgroundColor = GMColor.red500Color()
//        addButton.backgroundColor = UIColor.MKColor.LightBlue
        addButton.tintColor = UIColor.whiteColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNoteSegue" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //                 let diaryView = segue.destinationViewController as! DiaryViewController
                let noteView = segue.destinationViewController as! NoteViewController
                //
                let note = self.notes[indexPath.row]
                selectedNote = note
                selectedIndexPath = indexPath
                
                let rectOfCellInTableView = self.tableView.rectForRowAtIndexPath(indexPath)
                let tmpOriginFrame = self.tableView.convertRect(rectOfCellInTableView, toView: tableView.superview)
                openTransition.tmpOriginFrame = tmpOriginFrame
                //
                noteView.note = note
                noteView.indexPath = indexPath
                noteView.delegate = self
                
                segue.destinationViewController.transitioningDelegate = openTransition
                //                diaryView.diaryEntry = diaryEntry as Diary
                //                diaryView.transitioningDelegate = openDiaryTransition
                
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return datas.count
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionData = datas[section] as? [String: AnyObject]
//        let sectionDatas = sectionData!["datas"] as? [[String: AnyObject]]
//        return sectionDatas!.count
        return notes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timeNoteCell") as! TimeNoteCell
//        let sectionData = datas[indexPath.section] as? [String: AnyObject]
//        let sectionDatas = sectionData!["datas"] as! [[String: AnyObject]]
//        let cellData = sectionDatas[indexPath.row]
        let cellData = notes[indexPath.row]
        cell.note = cellData
        
        let cellBackView = UIView(frame: cell.frame)
        cell.selectedBackgroundView = cellBackView
        cell.selectedBackgroundView?.backgroundColor = UIColor.clearColor()

        return cell
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerViewController = TimeNoteHeaderViewController()
//        headerViewController.headerText = "\(section)"
//        let view = headerViewController.view
//        view.frame.size.width = self.view.frame.width
//        return view
//    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 35
//    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//
//        if editingStyle == .Delete {
//            
//            let diaryToRemove = notes[indexPath.row]
//            // print(diaryToRemove.objectID)
//            
//            managedContext.deleteObject(diaryToRemove)
//            
//            do {
//                try managedContext.save()
//            } catch let error as NSError {
//                print("Could not save \(error), \(error.userInfo)")
//            }
//            
//            notes.removeAtIndex(indexPath.row)
//            //  Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }
}

// MARK: - unwindToList
extension ViewController {
    @IBAction func unwindToList(sender: UIStoryboardSegue)  {
        
        if let noteViewController = sender.sourceViewController as? NoteViewController {
            let text = noteViewController.textView.text
            let entity =  NSEntityDescription.entityForName("Note", inManagedObjectContext: managedContext)

            if selectedNote != nil {
                selectedNote?.text = text
                selectedNote?.colorIndex = noteViewController.colorIndex
                
//                let cell = self.tableView.cellForRowAtIndexPath(selectedIndexPath!) as! TimeNoteCell
//                cell.note = selectedNote
//                
                self.tableView.reloadRowsAtIndexPaths([selectedIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }else {
                let note = Note(entity: entity!, insertIntoManagedObjectContext: managedContext)
                note.time = NSDate()
                note.text = text
                note.colorIndex = noteViewController.colorIndex

                notes.insert(note, atIndex: 0)
                
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
    }
}

// MARK: - delete note delegate
extension ViewController: NoteViewControllerDelegate {
    func deleteNote(note: Note?, indexPath: NSIndexPath?) {
        dismissViewControllerAnimated(true) { _ in
            guard let indexPath = indexPath else {
                return
            }
            
            let note = self.notes[indexPath.row]
            self.managedContext.deleteObject(note)
            
            do {
                try self.managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            self.notes.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

