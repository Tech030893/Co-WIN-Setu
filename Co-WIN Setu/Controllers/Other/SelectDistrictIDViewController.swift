import UIKit

class SelectDistrictIDViewController: UIViewController
{
    @IBOutlet weak var districtTableView: UITableView!
    
    var districtArray = [NSDictionary]()
    
    var stateId = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        APICaller()
    }
}

// MARK: - Calling API

extension SelectDistrictIDViewController
{
    func APICaller()
    {
        URLSession.shared.dataTask(with: URL(string: "https://cdn-api.co-vin.in/api/v2/admin/location/districts/\(stateId)")!) { data, response, error in
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
                    let response = json.value(forKey: "districts") as! [NSDictionary]
                    self.districtArray = response
                    print("Response: \(self.districtArray)")
                    DispatchQueue.main.async
                    {
                        self.districtTableView.reloadData()
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

extension SelectDistrictIDViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return districtArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectDistrictTableViewCell") as! SelectDistrictTableViewCell
        let districtName = districtArray[indexPath.row].value(forKey: "district_name") as? String ?? ""
        cell.districtNameLabel.text = "\(districtName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "FindByDistrictViewController") as! FindByDistrictViewController
        let districtId = districtArray[indexPath.row].value(forKey: "district_id") as? Int ?? 0
        vc.passId = "\(districtId)"
        UIApplication.shared.windows[0].rootViewController = vc
    }
}
