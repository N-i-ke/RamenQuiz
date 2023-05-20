//
//  QuizViewController.swift
//  RamenQuiz
//
//  Created by KengoNishi Apple on 2022/02/26.
//

import UIKit

//今回に関してはUIKitを使用しているimportする数は減らしている

class QuizViewController: UIViewController {
    
    
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var judgeImageView: UIImageView!
    
//    @IBOutletは一つにまとめること同じ処理を繰り返すところはまとめるべき
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    
//    var変数に関しても定義する場所を設けるべきちゃんとファイルで分けて処理速度を上げることでアプリの起動、初動、終わりまでの速度を滑らかにすること
    
    
//    関数を定義することはすごく大事だけど関数の数が多くなった場合はファイルを分ける必要がある

    
//    ロード開始
    

//    関数定義の内容
    override func viewDidLoad() {
        super.viewDidLoad()

//        csvArray = loadCSV(fileName: "quiz")　CSVファイルにしてファイル名quizを読み込む
//        csvArray.shuffle()　読み込んだファイルをランダムに
//        print(csvArray)　ファイルを出力する
        
        
        
        
        
//        quizArray = csvArray[quizCount].components(separatedBy: ",")　quizArrayにはcsvArrayの要素の中の全体のcsvArrayに対して要素でわける。分け方は,で【°直訳】
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        
//        レイアウトの高さとか色の指定これも違うファイルで管理しよう多すぎ
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        
//        レイアウトの高さとか色の指定これも違うファイルで管理しよう多すぎ
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    //button action code
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            print("正解")
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("score:\(correctCount)")
        judgeImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
        }
        nextQuiz()
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count - 1 {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("error")
        }
        return csvArray
    }

}
