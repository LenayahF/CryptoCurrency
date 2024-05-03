//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by 11k on 5/3/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var crpCcy: [String] = []
    var ccy:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         crpCcy = ["BTC", "ETH", "XRP", "BCH"]
         ccy = ["USD", "EUR", "JPY", "CHF"]
        
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getPrice(crpCcy:crpCcy[picker.selectedRow(inComponent: 0)], ccy:ccy[picker.selectedRow(inComponent: (1))])

    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return crpCcy.count;
        }
        else{
            return ccy.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return crpCcy[row]
        }
        else{
            return ccy[row]
        }
    }
    
    func getPrice(crpCcy: String, ccy: String) {
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=" + crpCcy + "&tsyms=" + ccy) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                               if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Double] {
                                DispatchQueue.main.async {
                                if let price = json[ccy] {
                                 self.price.text = "\(price)"
                                let formatter = NumberFormatter()
                                formatter.currencyCode = ccy
                                formatter.numberStyle = .currency
                               let formattedPrice = formatter.string(from: NSNumber(value: price))
                        self.price.text = formattedPrice
                            }
                        }
                    }
                } else {
                    print("wrong =(")
                }
            }.resume()
        }
    }

    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var price: UILabel!
}

