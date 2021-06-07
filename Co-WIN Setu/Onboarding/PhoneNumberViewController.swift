import UIKit
import Lottie
import FirebaseAuth
import FirebaseCore

class PhoneNumberViewController: UIViewController
{
    @IBOutlet weak var phoneAnimationView: AnimationView!
    
    @IBOutlet weak var mobileNumberTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        phoneAnimationView.loopMode = .loop
        phoneAnimationView.play()
    }
    
    @IBAction func generateOtpButton(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "ValidateOTPViewController") as! ValidateOTPViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
}
