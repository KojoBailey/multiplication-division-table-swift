//
//  ViewController.swift
//  Multiplier
//
//  Created by Bailey, Kojo on 16/10/2026.
//

import UIKit

extension Double {
    var trimmed: String {
        let rounded = (self * 10_000).rounded() / 10_000
        return rounded == rounded.rounded()
            ? String(Int(rounded))
            : "\(rounded)"
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var inputField: UITextField!
	@IBOutlet weak var goButton: UIButton!
	@IBOutlet weak var multiplicationTable: UITableView!
    
    let sectionTitles = ["Multiplications", "Divisions"]
	
	var userInput: Double = 0
	
	@IBAction func onGoPressed(_ sender: UIButton) {
		inputField.resignFirstResponder()
        guard let parsed = Double(inputField.text ?? "") else {
            let alert = UIAlertController(title: "Invalid input", message: "Enter an integer.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sure", style: .default))
            present(alert, animated: true)
            return
        }
        userInput = parsed
		multiplicationTable.reloadData()
        multiplicationTable.isHidden = false
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
		-> Int { 30 }
    
    func numberOfSections(in tableView: UITableView)
        -> Int { sectionTitles.count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)
        -> String? { sectionTitles[section] }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "multiplicationCell", for: indexPath)
		var content = UIListContentConfiguration.cell()
		
        let num = indexPath.row + 1
        switch indexPath.section {
        case 0:
            content.text = "\(num) × \(userInput.trimmed) = \((Double(num) * userInput).trimmed)"
        case 1:
            content.text = "\(num) ÷ \(userInput.trimmed) = \((Double(num) / userInput).trimmed)"
        default: break
        }
		
		cell.contentConfiguration = content
		return cell
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
        multiplicationTable.isHidden = true
	}
}
