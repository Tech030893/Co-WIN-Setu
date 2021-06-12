import UIKit

class HomeViewController: UIViewController
{
    fileprivate let application = UIApplication.shared
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    let sliderArray = ["Slider1","Slider2","Slider3","Slider4","Slider5","Slider6","Slider7"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sliderCollectionView.reloadData()
    }
    
    // MARK: - Profile & Settings Button
    
    @IBAction func settingsButtonPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    // MARK: - Search Vaccination Centres Buttons
    
    @IBAction func searchByPinPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "FindByPinViewController") as! FindByPinViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    @IBAction func searchByDistrictPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "FindByDistrictViewController") as! FindByDistrictViewController
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

// MARK: - Slider Collection View

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sliderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSliderCollectionViewCell", for: indexPath) as! HomeSliderCollectionViewCell
        cell.sliderImageView.contentMode = .scaleAspectFill
        cell.sliderImageView.layer.cornerRadius = 12
        cell.sliderImageView.image = UIImage(named: sliderArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
