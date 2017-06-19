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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFile = self.filenames[indexPath.row]
        sendSMS(attachment: selectedFile)
    }
    
    func sendSMS(attachment: String) {
        // Проверка на возможность отправки СМС
        guard MFMessageComposeViewController.canSendText() else {
            let alert = UIAlertController(title: "SMS Unavailable", message: "Your device is not capable sending SMS", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Взяли Url пути
        let fileparts = attachment.components(separatedBy: ".")
        let filename = fileparts[0]
        let fileExtention = fileparts[1]
        let filePath = Bundle.main.path(forResource: filename, ofType: fileExtention)
        let fileURL = NSURL(fileURLWithPath: filePath!)
        
        // Настроили       messageController
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = self
        messageController.recipients = ["656838393", "656838393", "656838393", "656838393"]
        messageController.body = "Jsu sent \(attachment) to your e-mail" // We can not sent files via SMS
        
        // Прикрепили файл
        messageController.addAttachmentURL(fileURL as URL, withAlternateFilename: nil)

        present(messageController, animated: true, completion: nil)
    }



}

















