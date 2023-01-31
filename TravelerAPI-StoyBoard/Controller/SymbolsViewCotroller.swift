//
//  SymbolsViewCotroller.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-14.
//

import UIKit

protocol SymbolDelegate: AnyObject {
    func didSelectSymbol(symbol: String)
}

final class SymbolsViewController: UIViewController {
    
    // MARK: Properties
    
    weak var delegate: SymbolDelegate?
    
    // MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: SymbolsViewController Delegate and Datasource

extension SymbolsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencySymbol.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symbols", for: indexPath)
        cell.textLabel?.text = currencyName[indexPath.row] + "(" + currencySymbol[indexPath.row] + ")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSymbol(symbol: currencySymbol[indexPath.row])
        dismiss(animated: true)
    }
    
}
