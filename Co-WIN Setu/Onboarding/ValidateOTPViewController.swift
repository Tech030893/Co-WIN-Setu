import UIKit
import Lottie
import FirebaseAuth
import FirebaseCore

class ValidateOTPViewController: UIViewController
{
    @IBOutlet weak var otpAnimationView: AnimationView!
    
    @IBOutlet weak var codeOneTF: UITextField!
    @IBOutlet weak var codeTwoTF: UITextField!
    @IBOutlet weak var codeThreeTF: UITextField!
    @IBOutlet weak var codeFourTF: UITextField!
    @IBOutlet weak var codeFiveTF: UITextField!
    @IBOutlet weak var codeSixTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        otpAnimationView.loopMode = .loop
        otpAnimationView.play()
    }
    
    @IBAction func validateOtpButton(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "WelcomeSliderViewController") as! WelcomeSliderViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    @IBAction func changeNumberButton(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "PhoneNumberViewController") as! PhoneNumberViewController
        UIApplication.shared.windows[0].rootViewController = vc
    }
}
