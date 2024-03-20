// Lv.5-6
import Foundation

class BullsAndCows {
    
    var answer: [Int] = []
    var myNumber: [Int] = []
    var attempt: [Int] = []
    
    func greeting() {
        print("환영합니다! 원하시는 번호를 입력해주세요\n1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        let choice = readLine()!
        switch choice {
        case "1":
            start()
        case "2":
            getRecord()
        case "3":
            endGame()
        default:
            print("올바른 숫자를 입력해주세요!")
            greeting()
        }
    }
    
    func start() {
        getAnswer()
        print("숫자를 입력하세요")
        var count = 0
        while true {
            getMyNumber()
            count += 1
            if myNumber != [] {
                checkAnswer()
                if myNumber == answer { break }
            }
        }
        attempt.append(count)
        answer = []
        myNumber = []
        greeting()
    }
   
    func getRecord() {
        print("<게임 기록 보기>")
        for i in 1...attempt.count {
            print("\(i)번째 게임 : 시도 횟수 - \(attempt[i-1])")
        }
    }
    
    func endGame() {
        attempt = []
        print("<숫자 야구 게임을 종료합니다")
    }
    // 정답도 0으로 시작하면 안되도록 수정
    func getAnswer() {
        answer.append((1...9).randomElement()!)
        while answer.count < 3 {
            let num = (0...9).randomElement()!
            if !answer.contains(num) {
                answer.append(num)
            }
        }
    }
    
    func getMyNumber() {
        let input = readLine()!
        
        if input.count == 3 && Int(input) != nil
            && Set(input).count == 3 && input.first != "0" {
            myNumber = input.map { Int(String($0))! }
        } else {
            myNumber = []
            print("올바르지 않은 입력값입니다")
        }
    }
    
    func checkAnswer() {
        var strike = 0
        var ball = 0
        
        if myNumber == answer {
            print("정답입니다!")
        } else {
            for i in 0...2 {
                for j in 0...2 {
                    if myNumber[i] == answer[j] {
                        if i == j { strike += 1 }
                        else { ball += 1 }
                    }
                }
            }
            if strike == 0 && ball == 0 {
                print("Nothing")
            } else {
                print("\(strike)스트라이크 \(ball)볼")
            }
        }
    }
}
