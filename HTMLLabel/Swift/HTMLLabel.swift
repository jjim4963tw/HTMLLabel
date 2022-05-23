//
//  HTMLLabel.swift
//  HTMLLabel
//
//  Created by Jim Huang on 2022/5/23.
//

import Foundation
import UIKit

protocol HTMLLabelDelegate {
    func tappedLinkTextFunction(linkString: URL);
}

class HTMLLabel: UILabel {
    fileprivate var gestureRecognize: UITapGestureRecognizer? = nil
    
    var linkDelegate: HTMLLabelDelegate? = nil
    
    deinit {
        if self.gestureRecognize != nil {
            self.removeGestureRecognizer(self.gestureRecognize!)
        }
        
        if self.linkDelegate != nil {
            self.linkDelegate = nil
        }
    }
    
    func setHTMLText(htmlText: String) {
        guard let data = htmlText.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
        guard let attributedText = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return }
        
        self.attributedText = attributedText
        self.isUserInteractionEnabled = true
        
        self.gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(handleHTMLTextTapped))
        self.addGestureRecognizer(self.gestureRecognize!)
    }
    
    @objc func handleHTMLTextTapped(gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else { return }
        
        if let attributedText = self.attributedText {
            attributedText.enumerateAttribute(NSAttributedString.Key.link, in: NSMakeRange(0, attributedText.length), options: [.longestEffectiveRangeNotRequired]) { value, range, isStop in
                if let value = value as? URL {
                    if let linkDelegate = self.linkDelegate {
                        linkDelegate.tappedLinkTextFunction(linkString: value)
                    }
                }
            }
        }
    }
}
