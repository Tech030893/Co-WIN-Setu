import UIKit

class HelplineNumbersViewController: UIViewController
{
    fileprivate let application = UIApplication.shared
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func backPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    // MARK: - Emergency Helpline Buttons
    
    @IBAction func healthMinisterButton(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://1075")
        {
            if application.canOpenURL(phoneURL)
            {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
            else
            {
                showAlert()
            }
        }
    }
    
    @IBAction func childHelpButton(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://1098")
        {
            if application.canOpenURL(phoneURL)
            {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
            else
            {
                showAlert()
            }
        }
    }
    
    @IBAction func mentalHealthButton(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://8046110007")
        {
            if application.canOpenURL(phoneURL)
            {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
            else
            {
                showAlert()
            }
        }
    }
    
    @IBAction func seniorCitizensButton(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://14567")
        {
            if application.canOpenURL(phoneURL)
            {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
            else
            {
                showAlert()
            }
        }
    }
    
    @IBAction func myGovtButton(_ sender: UIButton)
    {
        if let phoneURL = URL(string: "tel://9013151515")
        {
            if application.canOpenURL(phoneURL)
            {
                application.open(phoneURL, options: [:], completionHandler: nil)
            }
            else
            {
                showAlert()
            }
        }
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Alert", message: "Call feature not available in simulator", preferredStyle: .alert)
        let okPress = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okPress)
        present(alert, animated: true)
    }
}
