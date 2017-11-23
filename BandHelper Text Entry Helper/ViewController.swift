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
        
        return self
    }
    
    func writeToPasteBoard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([self as NSString])
    }
}

