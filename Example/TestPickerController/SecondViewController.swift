//
//  SecondViewController.swift
//  TestPickerController
//
//  Created by Paul Aguilar on 10/24/18.
//  Copyright © 2018 Paul Aguilar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - Outlets -
    
    @IBOutlet weak var labelYearSelection: UILabel!
    @IBOutlet weak var labelQuarterSelection: UILabel!
    
    // MARK: - Properties -
    
    private var source = SecondPickerSource(currentIndexesSelected: nil)
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // MARK: - IBActions -
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionChoose(_ sender: Any) {
        
        let controller = PGCPickerViewController.with(pickerOptions: source) { [weak self] (selections) in
            
            self?.select(indexes: selections)
        }
        
        self.present(controller, animated: false, completion: nil)
    }
    
    // MARK: - Methods -
    
    private func select(indexes: [Int]) {
        
        source.currentIndexesSelected = indexes
        
        update()
    }
    
    private func update() {
        
        guard let currentYearIndex = source.currentIndexesSelected?[0],
            let currentQuarterIndex = source.currentIndexesSelected?[1]  else {
                
                return
        }
        
        labelYearSelection.text    = source.title(forRow: currentYearIndex, atComponent: 0)
        labelQuarterSelection.text = source.title(forRow: currentQuarterIndex, atComponent: 1)
    }
}

struct SecondPickerSource: PickerMultipleOption {
    
    // MARK: - Protocol PickerOptions
    
    var currentIndexesSelected: [Int]?
    
    var numberOfComponents: Int {
        
        return 2
    }
    
    func numberOfRows(atComponent component: Int) -> Int {
        
        switch component {
            
        case 0:
            return 9
        case 1:
            return 4
        default:
            return 0
            
        }
    }
    
    func title(forRow row: Int, atComponent component: Int) -> String {
        
        switch component {
            
        case 0:
            return "\(2018 - row)"
        case 1:
            return "Q\(row + 1)"
        default:
            return ""
            
        }
    }
}
