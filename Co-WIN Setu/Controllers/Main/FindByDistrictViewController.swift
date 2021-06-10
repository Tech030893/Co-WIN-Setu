import UIKit

class FindByDistrictViewController: UIViewController
{
    @IBOutlet weak var districtTF: UITextField!
    @IBOutlet weak var districtDateTF: UITextField!
    
    var passId = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        districtDateTF.delegate = self
        districtTF.delegate = self
        
        if (districtTF != nil)
        {
            districtTF.text = "\(passId)"
        }
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
            let vc = storyboard?.instantiateViewController(identifier: "DistrictVaccinationCentresViewController") as! DistrictVaccinationCentresViewController
            vc.districtId = districtTF.text!
            vc.date = districtDateTF.text!
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

// MARK: - TextFields Validation

extension FindByDistrictViewController
{
    func validateFields() -> String?
    {
        // Check if textfields are empty or not
        if districtTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || districtDateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "TextFields cannot be empty"
        }
        return nil
    }
}

// MARK: - Date Picker & District Id Picker Code

extension FindByDistrictViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if textField.tag == 0
        {
            let vc = storyboard?.instantiateViewController(identifier: "SelectStateIDViewController") as! SelectStateIDViewController
            UIApplication.shared.windows[0].rootViewController = vc
        }
        if textField.tag == 1
        {
            self.openDatePicker()
        }
    }
}

extension FindByDistrictViewController
{
    func openDatePicker()
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerHandler(datePicker:)), for: .valueChanged)
        districtDateTF.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClick))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClick))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([cancelButton, flexibleButton, doneButton], animated: false)
        
        districtDateTF.inputAccessoryView = toolBar
    }
    
    @objc func cancelButtonClick()
    {
        districtDateTF.resignFirstResponder()
    }
    
    @objc func doneButtonClick()
    {
        if let datePicker = districtDateTF.inputView as? UIDatePicker
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "dd.MM.yy"
            districtDateTF.text = dateFormatter.string(from: datePicker.date)
        }
        districtDateTF.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker)
    {
        print(datePicker.date)
    }
}
