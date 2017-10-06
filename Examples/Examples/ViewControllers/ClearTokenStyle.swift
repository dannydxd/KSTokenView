//
//  ClearTokenStyle.swift

import UIKit

class ClearTokenStyle: UIViewController {
    let names = List.names()
    var tokenView: KSTokenView = KSTokenView(frame: .zero)
    @IBOutlet weak var shouldChangeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenView = KSTokenView(frame: CGRect(x: 10, y: 220, width: 300, height: 30))
        tokenView.delegate = self
        tokenView.promptText = " "
        tokenView.placeholder = "Type to search"
        tokenView.descriptionText = NSLocalizedString("%d Languages", comment: "description displayed representing all the keywords listed")
        tokenView.shouldHideSearchResultsOnSelect = true
        tokenView.shouldSortResultsAlphabatically = false
        tokenView.tokenizingCharacters = [","]
        tokenView.style = .clear
        tokenView.maxTokenLimit = -1
        tokenView.disableResultsHandler = true
        tokenView.removesTokensOnEndEditing = false
        tokenView.maximumHeight = -1
        tokenView.paddingX = 5
        tokenView.marginY = 0
        tokenView.placeholderFont = UIFont.systemFont(ofSize: 14)
        
        view.addSubview(tokenView)
        tokenView.setNeedsDisplay()
        tokenView.setNeedsLayout()
        
        //        for i in 0...10 {
        //            let token: KSToken = KSToken(title: names[i], object: nil)
        //            tokenView.addToken(token)
        //        }
        
        let textField = UITextField(frame: CGRect(x: 0, y: view.frame.height - 30, width: 200, height: 30))
        textField.borderStyle = UITextBorderStyle.line
        textField.text = "myString"
        textField.backgroundColor = UIColor.red
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(textField)
    }
    
    @IBAction func addToken(sender: AnyObject) {
        let title = names[Int(arc4random_uniform(UInt32(names.count)))] as String
        let token = KSToken(title: title, object: title as AnyObject?)
        
        // Token background color
        var red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        var green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        var blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        token.tokenBackgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        // Token text color
        red = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        green = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        blue = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        token.tokenTextColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        tokenView.addToken(token)
    }
    
    @IBAction func deleteLastToken(sender: AnyObject) {
        tokenView.deleteLastToken()
    }
    
    @IBAction func deleteAllTokens(sender: AnyObject) {
        tokenView.deleteAllTokens()
    }
    
    @IBAction func printTokens(_ sender: Any) {
        if let tokens = tokenView.tokens() {
            print(tokens.map { $0.title })
        }
    }
    
}

extension ClearTokenStyle: KSTokenViewDelegate {
    func tokenView(_ tokenView: KSTokenView, performSearchWithString string: String, completion: ((_ results: Array<AnyObject>) -> Void)?) {
        var data: Array<String> = []
        for value: String in names {
            if value.lowercased().range(of: string.lowercased()) != nil {
                data.append(value)
            }
        }
        completion!(data as Array<AnyObject>)
    }
    
    func tokenView(_ tokenView: KSTokenView, displayTitleForObject object: AnyObject) -> String {
        return object as! String
    }
    
    func tokenView(_ tokenView: KSTokenView, shouldChangeAppearanceForToken token: KSToken) -> KSToken? {
        if !shouldChangeSwitch.isOn {
            token.tokenBackgroundColor = UIColor.red
            token.tokenTextColor = UIColor.black
        }
        
        //        token.darkRatio = 1
        token.tokenTextColor = UIColor(red: 60.0/255.0, green: 110.0/255.0, blue: 211.0/255.0, alpha: 1)
        
        return token
    }
    
    func tokenView(_ tokenView: KSTokenView, shouldAddToken token: KSToken) -> Bool {
        var shouldAddToken = true
        if (token.title == "f") {
            shouldAddToken = false
        }
        return shouldAddToken
    }
    
    func tokenView(_ tokenView: KSTokenView, willAddToken token: KSToken) {
        token.darkRatio = 1
        
        token.tokenTextColor = UIColor(red: 60.0/255.0, green: 110.0/255.0, blue: 211.0/255.0, alpha: 1)
        token.tokenBackgroundColor = UIColor.white
        
        token.tokenBackgroundHighlightedColor = UIColor.green
        token.tokenTextHighlightedColor = UIColor.black
        
        token.backgroundStyle = .clear
    }
    
}
