import UIKit

class DistrictDetailsViewController: UIViewController
{
    @IBOutlet weak var centreNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var districtNameLabel: UILabel!
    @IBOutlet weak var timeFromLabel: UILabel!
    @IBOutlet weak var timeToLabel: UILabel!
    @IBOutlet weak var feeTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var vaccineLabel: UILabel!
    @IBOutlet weak var slotsLabel: UILabel!
    
    var centreName = ""
    var address = ""
    var districtName = ""
    var timeFrom = ""
    var timeTo = ""
    var fee = ""
    var date = ""
    var age = ""
    var vaccine = ""
    var slot = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        centreNameLabel.text = centreName
        addressLabel.text = address
        districtNameLabel.text = districtName
        timeFromLabel.text = timeFrom
        timeToLabel.text = timeTo
        feeTypeLabel.text = fee
        dateLabel.text = date
        ageLabel.text = age
        vaccineLabel.text = vaccine
        slotsLabel.text = slot
    }
    
    @IBAction func okayPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
}
