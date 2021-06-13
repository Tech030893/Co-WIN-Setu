import UIKit
import SafariServices

class HomeViewController: UIViewController
{
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    let sliderArray = ["Slider1","Slider2","Slider3","Slider4","Slider5","Slider6","Slider7"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        sliderCollectionView.reloadData()
    }
    
    // MARK: - Settings Button
    
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
    
    // MARK: - PM Cares Donation Website link
    
    @IBAction func pmCaresButtonPress(_ sender: UIButton)
    {
        let urlString: String
        urlString = "https://www.pmcares.gov.in/en/"
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
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
