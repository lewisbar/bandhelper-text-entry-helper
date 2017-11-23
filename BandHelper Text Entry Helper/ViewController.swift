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
        
        // Gray
        let grayItems = ["Ch:", "Br:", "PC:", "In:",
                         "1.", "2.", "3.", "4.", "5.", "6.", "7.", "8.", "9.", "10.",
                         "(1x)", "(2x)", "(3x)", "(4x)", "(5x)", "(6x)", "(7x)", "(8x)", "(9x)", "(10x)",
                         "||1x", "||2x", "||3x", "||4x", "||5x", "||6x", "||7x", "||8x", "||9x", "||10x"]
        for item in grayItems {
            newText = newText.replacingOccurrences(of: item, with: "<span style=\"color: #999999;\">\(item)</span>")
        }
        
        // Line breaks
        newText = newText.replacingOccurrences(of: "\n", with: "<br />")
        
        // Paragraph
        newText = "<p>" + newText + "</p>"
        
        return newText
    }
    
    func writeToPasteBoard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([self as NSString])
    }
}

