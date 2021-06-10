import UIKit

class FindByPinViewController: UIViewController
{
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var pincodeDateTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pincodeDateTF.delegate = self
    }
    
    @IBAction func backPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    @IBAction func searchPress(_ sender: UIButton)
    {
        let alert = validateFields()
        if alert != nil
        {
            showAlert(title: alert!)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(identifier: "PinVaccinationCentresViewController") as! PinVaccinationCentresViewController
            vc.pincode = pincodeTF.text!
            vc.date = pincodeDateTF.text!
            UIApplication.shared.windows[0].rootViewController = vc
        }
    }
    
    func showAlert(title: String)
    {
        let alert = UIAlertController(title: "\(title)", message: nil, preferredStyle: .alert)
        let okPress = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okPress)
        present(alert, animated: true)
    }
}

// MARK: - Text Fields Validation

extension FindByPinViewController
{
    func validateFields() -> String?
    {
        // Check if textfields are empty or not
        if pincodeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pincodeDateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "TextFields cannot be empty"
        }
        
        // Check if pincode is correct or not
        let pincodeCheck = pincodeTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if pincodeValidation(pinCode: pincodeCheck) == false
        {
            return "Please make sure you've entered a correct pincode"
        }
        return nil
    }
    
    func pincodeValidation(pinCode: String) -> Bool
    {
        let pincodeRegex = "^[0-9]{6}$"
        let pincodePredicate = NSPredicate(format: "SELF MATCHES %@", pincodeRegex)
        let validPincode = pincodePredicate.evaluate(with: pinCode) as Bool
        return validPincode
    }
}

// MARK: - Date Picker Code

extension FindByPinViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.openDatePicker()
    }
}

extension FindByPinViewController
{
    func openDatePicker()
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerHandler(datePicker:)), for: .valueChanged)
        pincodeDateTF.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClick))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, flexibleButton, doneButton], animated: false)
        
        pincodeDateTF.inputAccessoryView = toolBar
    }
    
    @objc func cancelButtonClick()
    {
        pincodeDateTF.resignFirstResponder()
    }
    
    @objc func doneButtonClick()
    {
        if let datePicker = pincodeDateTF.inputView as? UIDatePicker
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "dd.MM.yy"
            pincodeDateTF.text = dateFormatter.string(from: datePicker.date)
        }
        pincodeDateTF.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker)
    {
        print(datePicker.date)
    }
}
