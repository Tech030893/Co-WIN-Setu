import UIKit

class SelectStateIDViewController: UIViewController
{
    @IBOutlet weak var stateTableView: UITableView!
    
    var stateArray = [NSDictionary]()
    
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

extension SelectStateIDViewController
{
    func APICaller()
    {
        URLSession.shared.dataTask(with: URL(string: "https://cdn-api.co-vin.in/api/v2/admin/location/states")!) { data, response, error in
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
                    let response = json.value(forKey: "states") as! [NSDictionary]
                    self.stateArray = response
                    print("Response: \(self.stateArray)")
                    DispatchQueue.main.async
                    {
                        self.stateTableView.reloadData()
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

extension SelectStateIDViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return stateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectStateTableViewCell") as! SelectStateTableViewCell
        let stateName = stateArray[indexPath.row].value(forKey: "state_name") as? String ?? ""
        cell.stateNameLabel.text = "\(stateName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "SelectDistrictIDViewController") as! SelectDistrictIDViewController
        let stateId = stateArray[indexPath.row].value(forKey: "state_id") as? Int ?? 0
        vc.stateId = stateId
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}
