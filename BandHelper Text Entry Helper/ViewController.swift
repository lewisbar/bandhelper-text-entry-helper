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
        let orangeSpan = "<span style=\"color: #f29137;\">"
        let yellowSpan = "<span style=\"color: #fccb13;\">"
        let greenSpan = "<span style=\"color: #91c34e;\">"
        let graySpan = "<span style=\"color: #999999;\">"
        let redSpan = "<span style=\"color: #bb2833;\">"
        let spanEnd = "</span>"
        
        var newText = self
        
        // Paragraph
        newText = "<p>" + newText + "</p>"
        
        // Line breaks
        newText = newText.replacingOccurrences(of: "\n", with: "<br />")
        
        // Pre-Chorus orange
        newText = newText.replacingOccurrences(of: "PC: ", with: "PC: " + orangeSpan)
        newText = newText.replacingOccurrences(of: "PC1: ", with: "PC1: " + orangeSpan)
        newText = newText.replacingOccurrences(of: "PC2: ", with: "PC2: " + orangeSpan)
        
        // Chorus yellow
        newText = newText.replacingOccurrences(of: "Ch: ", with: "Ch: " + yellowSpan)
        newText = newText.replacingOccurrences(of: "Ch1: ", with: "Ch1: " + yellowSpan)
        newText = newText.replacingOccurrences(of: "Ch2: ", with: "Ch2: " + yellowSpan)
        newText = newText.replacingOccurrences(of: "Ch3: ", with: "Ch3: " + yellowSpan)
        
        // Bridge/Coda green
        newText = newText.replacingOccurrences(of: "Br: ", with: "Br: " + greenSpan)
        newText = newText.replacingOccurrences(of: "Br1: ", with: "Br1: " + greenSpan)
        newText = newText.replacingOccurrences(of: "Br2: ", with: "Br2: " + greenSpan)
        newText = newText.replacingOccurrences(of: "Co: ", with: "Co: " + greenSpan)

        // Explicit color signs
        newText = newText.replacingOccurrences(of: "€o", with: orangeSpan)
        newText = newText.replacingOccurrences(of: "€y", with: yellowSpan)
        newText = newText.replacingOccurrences(of: "€g", with: greenSpan)
        
        // Span ending
        newText = newText.replacingOccurrences(of: "::", with: spanEnd)
        
        // Capo red
        for fret in 1...12 {
            newText = newText.replacingOccurrences(of: "Capo \(fret)", with: redSpan + "Capo \(fret)" + spanEnd)
        }
        
        // Rehearsal marks
        newText = newText.replacingOccurrences(of: "(", with: graySpan + "(")
        newText = newText.replacingOccurrences(of: ")", with: ")" + spanEnd)
        
        // Same chords for multiple parts in the chord field
        newText = newText.replacingOccurrences(of: "/PC: ", with: "/" + orangeSpan + "PC" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/PC1: ", with: "/" + orangeSpan + "PC1" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/PC2: ", with: "/" + orangeSpan + "PC2" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Ch: ", with: "/" + yellowSpan + "Ch" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Ch1: ", with: "/" + yellowSpan + "Ch1" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Ch2: ", with: "/" + yellowSpan + "Ch2" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Ch3: ", with: "/" + yellowSpan + "Ch3" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Br: ", with: "/" + greenSpan + "Br" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Br1: ", with: "/" + greenSpan + "Br1" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Br2: ", with: "/" + greenSpan + "Br2" + spanEnd + ":")
        newText = newText.replacingOccurrences(of: "/Co: ", with: "/" + greenSpan + "Co" + spanEnd + ":")
        
        newText = newText.replacingOccurrences(of: "PC/", with: orangeSpan + "PC" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "PC1/", with: orangeSpan + "PC1" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "PC2/", with: orangeSpan + "PC2" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Ch/", with: yellowSpan + "Ch" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Ch1/", with: yellowSpan + "Ch1" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Ch2/", with: yellowSpan + "Ch2" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Ch3/", with: yellowSpan + "Ch3" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Br/", with: greenSpan + "Br" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Br1/", with: greenSpan + "Br1" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Br2/", with: greenSpan + "Br2" + spanEnd + "/")
        newText = newText.replacingOccurrences(of: "Co/", with: greenSpan + "Co" + spanEnd + "/")
            
        // Gray
        let grayItems = ["Ve:", "Ch:", "Ch1:", "Ch2:", "Ch3:", "Br:", "Br1:", "Br2:", "PC:", "PC1:", "PC2:", "In:", "Co:",
                         "1.", "2.", "3.", "4.", "5.", "6.", "7.", "8.", "9.", "10.",
                         "(1x)", "(2x)", "(3x)", "(4x)", "(5x)", "(6x)", "(7x)", "(8x)", "(9x)", "(10x)",
                         "||1x", "||2x", "||3x", "||4x", "||5x", "||6x", "||7x", "||8x", "||9x", "||10x"]
        for item in grayItems {
            newText = newText.replacingOccurrences(of: item, with: graySpan + item + spanEnd)
        }
        
        return newText
    }
    
    func writeToPasteBoard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([self as NSString])
    }
}

