//
//  CurrencyViewController.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import UIKit

final class CurrencyViewController : UIViewController, SymbolDelegate {
    
    //MARK: Properties
    @IBOutlet var finalSymbolLabel: UILabel!
    @IBOutlet var currencyTextField: UITextField!
    @IBOutlet var oneDollarLabel: UILabel!
    @IBOutlet var resultTextField: UITextField!
    @IBOutlet var toggleActivityIndicator: UIActivityIndicatorView!
    
    private var symbols = SymbolsViewController()
    private let model = CurrencyLogic()
    
    private let currencyFrom = "USD"
    private let currencyInitTo = "EUR"
    private let amountInitTo = 1.0
    private var rates: Double = 1.0
    private var amount: Double = 1.0 {
        didSet {
            resultTextField.text = String(amount*rates)
            oneDollarLabel.text = "\(self.amountInitTo) \(currencyFrom) = \(self.rates) \(currencyTarget)"
        }
    }
    private var currencyTarget: String = "EUR" {
        didSet {
            oneDollarLabel.text = "\(self.amountInitTo) \(currencyFrom) = \(self.rates) \(currencyTarget)"
            finalSymbolLabel.text = currencyTarget
        }
    }
    
    //MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()
        symbols.delegate = self
        self.getRatesOnViewLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! SymbolsViewController).delegate = self
    }
    
    //MARK: Actions
    @IBAction func didTappedConvertButton(_ sender: Any) {
        guard let amountValue = currencyTextField.text else {
            presentAlert(message: TypeError.AmountIncorrect)
            return
        }
        guard let amountValue = Double(amountValue) else {
            presentAlert(message: TypeError.AmountConversion)
            return
        }
        amount = amountValue
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        currencyTextField.resignFirstResponder()
    }
    
    //MARK: Privates
    private func getRatesOnViewLoad() {
        getRates(to: currencyInitTo, amount: amountInitTo)
        loadActivityIndicator(state: false)
    }
    
    private func updateCurrency(to: String, amount: Double) {
        getRates(to: to, amount: amount)
        finalSymbolLabel.text = to
        oneDollarLabel.text = "\(amount) \(currencyFrom) = \(rates) \(to)"
        loadActivityIndicator(state: false)
        
    }
    
    private func loadActivityIndicator(state: Bool) {
        oneDollarLabel.isHidden = state
        toggleActivityIndicator.isHidden = !state
    }
    
    private func getRates (to: String, amount: Double) {
        loadActivityIndicator(state: true)
        
        model.getRates (to: to, amount: amount) { [weak self] result in
            switch result {
            case .success(let currencyREsult):
                DispatchQueue.main.async {
                    self?.rates = currencyREsult.info.rate
                    self?.currencyTarget = to
                    self?.amount = amount
                }
            case .failure(.BadUrl):
                self?.presentAlert(message: TypeError.badUrl)
            case .failure(.decoderJSON):
                self?.presentAlert(message: TypeError.decoderJSON)
            case .failure(.StatusCode200):
                self?.presentAlert(message: TypeError.StatusCode200)
            case .failure(.ErrorNil):
                self?.presentAlert(message: TypeError.ErrorNil)
            }
        }
    }
    
    //MARK: SymbolModelDelegate
    func didSelectSymbol(symbol: String) {
        finalSymbolLabel.text = symbol
        updateCurrency(to: symbol, amount: amount)
    }
}
