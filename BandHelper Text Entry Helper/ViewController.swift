//
//  ViewController.swift
//  BandHelper Text Entry Helper
//
//  Created by Lennart Wisbar on 23.11.17.
//  Copyright © 2017 Lennart Wisbar. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func copyAsHTML(_ sender: NSButton) {
        guard let text = textView.textStorage?.string else { return }
        let htmlText = text.bandHelperHTML
        htmlText.writeToPasteBoard()
    }
}

extension String {
    var bandHelperHTML: String {
        // TODO
        var newText = self
        
        // Make numbers gray
        for number in 1...9 {
            newText = newText.replacingOccurrences(of: "\(number).", with: "<span style=\"color: #999999;\">\(number).</span>")
            newText = newText.replacingOccurrences(of: "\(number)x", with: "<span style=\"color: #999999;\">\(number)x</span>")
            newText = newText.replacingOccurrences(of: "||\(number)", with: "<span style=\"color: #999999;\">||\(number)</span>")
        }
        
        return newText
    }
    
    func writeToPasteBoard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([self as NSString])
    }
}

