import UIKit
import SafariServices

class SettingsViewController: UIViewController
{
    @IBOutlet weak var settingsTableView: UITableView!
    
    private var data = [[SettingsCellModel]]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureModels()
    }
    
    @IBAction func backPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    private func configureModels()
    {
        data.append([
            SettingsCellModel(title: "View Profile", handler: {
                self.didTapProfile()
            }),
            SettingsCellModel(title: "Call Helpline", handler: {
                self.didTapCallHelpline()
            })
        ])
        
        data.append([
            SettingsCellModel(title: "Terms of Services", handler: {
                self.openURL(type: .terms)
            }),
            SettingsCellModel(title: "Privacy Policy", handler: {
                self.openURL(type: .privacy)
            }),
            SettingsCellModel(title: "F.A.Q.", handler: {
                self.openURL(type: .faq)
            })
        ])
        
        data.append([
            SettingsCellModel(title: "Logout", handler: {
                self.didTapLogout()
            })
        ])
    }
    
    private func openURL(type: SettingsURLType)
    {
        let urlString: String
        
        switch type
        {
        case .terms:
            urlString = "https://www.aarogyasetu.gov.in/terms-conditions/"
        case .privacy:
            urlString = "https://www.aarogyasetu.gov.in/privacy-policy/"
        case .faq:
            urlString = "https://www.aarogyasetu.gov.in/faq/"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapProfile()
    {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapCallHelpline()
    {
        let vc = storyboard?.instantiateViewController(identifier: "HelplineNumbersViewController") as! HelplineNumbersViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func didTapLogout()
    {
        
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        cell.settingsDataLabel.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}
