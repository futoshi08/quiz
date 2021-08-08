import UIKit

class quizViewController: UIViewController {
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    //問題データを入れる箱
    var csvArray : [String] = []
    //問題を入れる配列
    var quizArray : [String] = []
    //問題数をカウント
    var quizCount = 0
    //正解数を入れる箱
    var correctCount = 0
    //どの問題を選択したか受取る箱
    var selectLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvArray = loadcsv(fileName: "quiz\(selectLevel)")
        csvArray.shuffle()
        print(csvArray)
        
        //問題を代入
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        quizTextView.layer.borderWidth = 2
        quizTextView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! scoreViewController
        scoreVC.correct = correctCount
    }
    
    
    @IBAction func btn (sender :UIButton){
        //正誤判定
        if sender.tag == Int(quizArray[1]) {
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
        }else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        judgeImageView.isHidden = false
        //ボタン無効化
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
    }
    
    //次の問題をセットするブロック
    func nextQuiz(){
        quizCount += 1
        //次の問題がなかったらスコア画面に行く
        if quizCount < csvArray.count {
            //問題を代入
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        }else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    
    //csvを読み込み、配列に変換
    func loadcsv(fileName:String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineCange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineCange.components(separatedBy: "\n")
            csvArray.removeLast()
        }catch {
            print("エラー")
        }
        return csvArray
    }
    

}
