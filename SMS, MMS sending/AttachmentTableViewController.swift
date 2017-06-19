//
//  AttachmentTableViewController.swift
//  SMS, MMS sending
//
//  Created by Kanat A on 19/06/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import MessageUI


class AttachmentTableViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    let filenames = ["camera-photo-tips.html", "foggy.jpg", "Hello World.ppt", "no more complaint.png", "Just Dev.doc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filenames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filenames[indexPath.row]
        cell.imageView?.image = UIImage(named: "icon\(indexPath.row).png");
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = self.filenames[indexPath.row]
        
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue: print("Cancel")
        case MessageComposeResult.failed.rawValue:
            let alert = UIAlertController(title: "Failure", message: "Failed to Send Message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue: print("Sent")
        default: break
        }
        dismiss(animated: true, completion: nil)
    }
    




}















