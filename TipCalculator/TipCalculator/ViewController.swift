

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    let scrollView = UIScrollView()

    let label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemOrange
        label.text = "$00.00"
        label.textAlignment = .center
        label.font = label.font.withSize(60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    let label2:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Total Amount"
        label.textAlignment = .center
        label.font = label.font.withSize(40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let field:UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.placeholder = "Bill Amount($)"
        field.textAlignment = .center
        field.font = field.font?.withSize(30)
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1.0
        field.keyboardType = UIKeyboardType.numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    let label3:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Tip Percentage"
        label.textAlignment = .center
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let slider:UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.tintColor = .green
        slider.translatesAutoresizingMaskIntoConstraints = false

        return slider
    }()
    
    let label4:UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "0"
        label.font = label.font.withSize(10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        label.topAnchor.constraint(equalTo:view.topAnchor, constant: 100).isActive = true

        view.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(field)
        field.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true
        field.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 50).isActive = true
        
        view.addSubview(label3)
        label3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label3.topAnchor.constraint(equalTo: field.bottomAnchor, constant: 50).isActive = true
        
        
        view.addSubview(slider)
        slider.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: 50).isActive = true
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 20).isActive = true
        slider.addTarget(self, action: #selector(change), for: .valueChanged)
        
        
        
        view.addSubview(label4)
        label4.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label4.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label4.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label4.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 30).isActive = true
        label4.text = "0%"
        
        field.delegate = self
        registerForKeyboardNotification()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
    }
    
    fileprivate func registerForKeyboardNotification() {
     
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
      guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
      let keyboardFrame = keyboardFrameValue.cgRectValue
      let keyboardHeight = keyboardFrame.size.height
      
      let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {

      let insets = UIEdgeInsets.zero
      scrollView.contentInset = insets
      scrollView.scrollIndicatorInsets = insets
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
   @objc func change(sender: UISlider!){
    if field.text == "" {

        label.text = "$0"
        label4.text =  "0%"
    } else {
    let billAmount = Float(field.text!)
    let tipRate = Int(slider.value)
        label4.text =  "\(tipRate)%"
        label.text = "$\(Float(tipRate) * billAmount! * 0.01 + billAmount!)"
    }
    }
}
