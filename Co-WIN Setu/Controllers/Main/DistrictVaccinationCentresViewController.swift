import UIKit

class DistrictVaccinationCentresViewController: UIViewController
{
    @IBOutlet weak var districtTableView: UITableView!
    
    var districtArray = [NSDictionary]()
    
    var districtId = String()
    var date = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        APICaller()
    }
    
    @IBAction func backPress(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "FindByDistrictViewController") as! FindByDistrictViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
}

// MARK: - Calling API

extension DistrictVaccinationCentresViewController
{
    func APICaller()
    {
        URLSession.shared.dataTask(with: URL(string: "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=\(districtId)&date=\(date)")!) { data, response, error in
            print("Response Here")
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                    print("\(json)")
                    let response = json.value(forKey: "sessions") as! [NSDictionary]
                    self.districtArray = response
                    print("Response: \(self.districtArray)")
                    DispatchQueue.main.async
                    {
                        self.districtTableView.reloadData()
                        if self.districtArray.isEmpty
                        {
                            self.districtTableView.isHidden = true
                            let alert = UIAlertController(title: "No Data Found", message: "No vaccination centres available for this district!", preferredStyle: .alert)
                            let okPress = UIAlertAction(title: "Okay", style: .cancel) { alert in
                                
                            }
                            alert.addAction(okPress)
                            self.present(alert, animated: true)
                        }
                    }
                }
                catch
                {
                    print("Exception Here")
                }
            }
        }.resume()
    }
}

// MARK: - TableView

extension DistrictVaccinationCentresViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return districtArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistrictCentreTableViewCell") as! DistrictCentreTableViewCell
        let centreName = districtArray[indexPath.row].value(forKey: "name") as? String ?? ""
        cell.centreNameLabel.text = "\(centreName)"
        let centreId = districtArray[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.centreIdLabel.text = "\(centreId)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "DistrictDetailsViewController") as! DistrictDetailsViewController
        
        let centreName = districtArray[indexPath.row].value(forKey: "name") as? String ?? "Unavailable"
        if centreName == ""
        {
            vc.centreName = "Unavailable"
        }
        else
        {
            vc.centreName = "\(centreName)"
        }
        
        let address = districtArray[indexPath.row].value(forKey: "address") as? String ?? "Unavailable"
        if address == ""
        {
            vc.address = "Unavailable"
        }
        else
        {
            vc.address = "\(address)"
        }
        
        let districtName = districtArray[indexPath.row].value(forKey: "pincode") as? String ?? "Unavailable"
        if districtName == ""
        {
            vc.districtName = "Unavailable"
        }
        else
        {
            vc.districtName = "\(districtName)"
        }
        
        let timeFrom = districtArray[indexPath.row].value(forKey: "from") as? String ?? "Unavailable"
        if timeFrom == ""
        {
            vc.timeFrom = "Unavailable"
        }
        else
        {
            vc.timeFrom = "\(timeFrom)"
        }
        
        let timeTo = districtArray[indexPath.row].value(forKey: "to") as? String ?? "Unavailable"
        if timeTo == ""
        {
            vc.timeTo = "Unavailable"
        }
        else
        {
            vc.timeTo = "\(timeTo)"
        }
        
        let fee = districtArray[indexPath.row].value(forKey: "fee_type") as? String ?? "Unavailable"
        if fee == ""
        {
            vc.fee = "Unavailable"
        }
        else
        {
            vc.fee = "\(fee)"
        }
        
        let date = districtArray[indexPath.row].value(forKey: "date") as? String ?? "Unavailable"
        if date == ""
        {
            vc.date = "Unavailable"
        }
        else
        {
            vc.date = "\(date)"
        }
        
        let age = districtArray[indexPath.row].value(forKey: "min_age_limit") as? String ?? "Unavailable"
        if age == ""
        {
            vc.age = "Unavailable"
        }
        else
        {
            vc.age = "\(age)"
        }
        
        let vaccine = districtArray[indexPath.row].value(forKey: "vaccine") as? String ?? "Unavailable"
        if vaccine == ""
        {
            vc.vaccine = "Unavailable"
        }
        else
        {
            vc.vaccine = "\(vaccine)"
        }
        
        let slot = districtArray[indexPath.row].value(forKey: "slots") as? String ?? "Unavailable"
        if slot == ""
        {
            vc.slot = "Unavailable"
        }
        else
        {
            vc.slot = "\(slot)"
        }
        
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 102
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}
