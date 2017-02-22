//
//  IntroViewController.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBUtils

class IntroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    var activeCell: Int = 0
    var messages = [SpeechBubbleMessage]()
    var messageTexts = ["Hi", "My name's Matt, and this is my app.", "Mostly I use this for blogging and just generally showing off, take a look around.", "Type 'GO' to check it out."]
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        self.navigationItem.hidesBackButton = true
        
        populateMessages()
        configureNibs()
        configureTableView()
        configureMessageBox()
    }
    
    func addMessage(text: String, time: Int) -> MessageOperation {
        let indexPath = IndexPath(item: time, section: 0)
        
        let operation = MessageOperation()
        operation.text = text
        operation.time = time
        operation.completionHandler = { speechBubbleMessage in
            guard let speechBubbleMessage = speechBubbleMessage else {
                return
            }
            
            self.messages.append(speechBubbleMessage)
            self.tableView.beginUpdates()
            self.activeCell = indexPath.row
            self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
            
            if indexPath.row > 0 {
                let prevIndexPath = IndexPath(item: time - 1, section: 0)
                self.tableView.reloadRows(at: [prevIndexPath], with: UITableViewRowAnimation.none)
            }
            
            self.tableView.endUpdates()
        }
        
        return operation
    }
    
    func populateMessages() {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        
        for i in 0..<messageTexts.count {
            let operation = addMessage(text: messageTexts[i], time: i)
            operationQueue.addOperation(operation)
        }
        
        let endOperation = MessageOperation()
        endOperation.completionHandler = { speechBubbleMessage in
            MBOn.main {
                self.sendBtn.isEnabled = true
            }
        }
        
        operationQueue.addOperation(endOperation)
    }
    
    func configureMessageBox() {
        self.sendBtn.isEnabled = false
        self.sendBtn.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configureNibs() {
        let messageNib = UINib(nibName: "SpeechBubbleView", bundle: nil)
        tableView.register(messageNib, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: SpeechBubbleView = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpeechBubbleView {
            cell.message = self.messages[indexPath.row]
            self.activeCell = indexPath.row
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row != self.activeCell || indexPath.row == self.messageTexts.count - 1), let customCell: SpeechBubbleView = cell as? SpeechBubbleView {
            customCell.loadingLblHeight.constant = 0.0
        }
    }
    
    func hideLoadingLabelForCell(cell: SpeechBubbleView) {
        cell.loadingLblHeight.constant = 0.0
        cell.loadingLbl.alpha = 0.0
    }
}

class MessageOperation: Operation {
    var time: Int = 0
    var text: String = ""
    var completionHandler: ((SpeechBubbleMessage?) -> ())?
    
    override func main() {
        guard text != "" else {
            completionHandler!(nil)
            return
        }
        
        let sema = DispatchSemaphore(value: 0)
        MBOn.delay(1.5, task: {
            MBOn.main {
                let messageText = self.text
                let message = SpeechBubbleMessage(message: messageText, position: .left)
                self.completionHandler!(message)
                sema.signal()
            }
        })
        
        sema.wait()
    }
}
