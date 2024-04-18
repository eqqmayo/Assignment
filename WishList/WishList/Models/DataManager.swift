//
//  DataManager.swift
//  WishList
//
//  Created by CaliaPark on 4/18/24.
//

import UIKit

//class DataManager {
//    let movieURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?&key=761c4714a263ebca9298eaf63f89ee30&targetDt=20240222"
//    
//    // 1. URL 구조체로 만들기
//    let structUrl = URL(string: movieURL)!
//    
//    // 2. URLSession(네트워킹 하는 객체, 브라우저 같은 역할) 만들고 3. 통신 작업 부여(일시정지 상태)
//    URLSession.shared.dataTask(with: structUrl) { data, response, error in
//        if error != nil {   // 일반적으로 에러 먼저 확인
//            print(error!)
//            return
//        }
//        
//        guard let safeData = data else { return }
//        // 데이터 출력해보기
//        // print(String(decoding: safeData, as: UTF8.self))
//        
//        var movieArray = parseJSON(safeData)
//        dump(movieArray!)  // print()와 비슷하나 보기 좋고 깔끔하게 출력
//        
//        
//        // 4. 시작(일시정지 상태이기 때문에 반드시 시작 해주어야함)
//    }.resume()
//    
//    // 받아온 데이터를 쓰기 좋게 변환 ==============================
//    
//    func parseJSON(_ movieData: Data) -> [WeeklyBoxOfficeList]? {
//        do {
//            let decoder = JSONDecoder()
//            // movieData를 받아 MovieData 형태로 바꿈
//            let decodedData = try decoder.decode(MovieData.self, from: movieData)
//            return decodedData.boxOfficeResult.weeklyBoxOfficeList
//        } catch {
//            return nil
//        }
//    }
//    
//    // 서버에서 주는 데이터의 형태 ================================
//    
//    struct MovieData: Codable {
//        let boxOfficeResult: BoxOfficeResult
//    }
//    
//    struct BoxOfficeResult: Codable {
//        let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
//    }
//    
//    struct WeeklyBoxOfficeList: Codable {
//        let rank: String
//        let movieNm: String
//        let audiCnt, audiAcc: String
//    }
//}
