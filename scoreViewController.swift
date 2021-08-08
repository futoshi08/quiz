import UIKit

class scoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    
    
    //正解数を受取る箱
    var correct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(correct)問正解!"
        
        shareButton.layer.borderWidth = 2
        shareButton.layer.borderColor = UIColor.black.cgColor
        topButton.layer.borderWidth = 2
        topButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        let activityItems = ["\(correct)問正解しました","basukeQuiz"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    
    @IBAction func toTopBtnAction(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
        
    }
    
    

}
