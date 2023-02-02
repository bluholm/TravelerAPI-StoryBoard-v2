//
//  TranslateViewController.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet var labelTextField: UITextView!
    @IBOutlet var buttonTranslate: UIButton!
    @IBOutlet var copyToclipBoardButton: UIButton!
    @IBOutlet var labelCopied: UILabel!
    @IBOutlet var labelTextTranslated: UITextView!
    
    let model = TranslateLogic()
    
    // MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelCopied.text = ""
        loadMyView()
        
        labelTextField.delegate = self

    }
    
    // MARK: User Actions
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        labelTextField.resignFirstResponder()
    }
    
    @IBAction func didButtonTranslateTapped(_ sender: Any) {
        guard let text = labelTextField.text else {
            presentAlert(message: TypeError.ErrorNil)
            return
        }
        model.translateText = text
        translateText(text: text)
    }
    
    @IBAction func didButtonCopyToCliBoardTapped(_ sender: Any) {
        if labelTextTranslated.hasText {
            labelCopied.text = "copy!"
            UIPasteboard.general.string = labelTextTranslated.text
        } else {
            labelCopied.text = "nothing to copy!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.labelCopied.text = ""
        }
    }
    
    // MARK: Privates
    
    func translateText(text: String) {
        model.getTextTranslated { [weak self] result in
            switch result {
            case .success(let value):
                let traduc = value.translations[0].text
                self?.labelTextTranslated.text = String(traduc)
                self?.labelTextTranslated.textColor = .black
            case .failure(.badURL):
                self?.presentAlert(message: TypeError.badUrl)
            case .failure(.decoderJSON):
                self?.presentAlert(message: TypeError.decoderJSON)
            case .failure(.statusCode):
                self?.presentAlert(message: TypeError.StatusCode200)
            case .failure(.errorNil):
                self?.presentAlert(message: TypeError.ErrorNil)
            }
        }
    }
}

extension TranslateViewController: UITextViewDelegate {
    
        public func textViewShouldReturn(_ textView: UITextView) -> Bool {
            textView.resignFirstResponder()
            return true
        }
    
}
