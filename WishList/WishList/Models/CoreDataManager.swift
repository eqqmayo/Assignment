//
//  File.swift
//  WishList
//
//  Created by CaliaPark on 4/18/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // 싱글톤으로 만들기
//    static let shared = CoreDataManager()
//    private init() {}
//    
//    // 앱 델리게이트
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    
//    // 임시저장소
//    lazy var context = appDelegate?.persistentContainer.viewContext
//    
//    // 엔터티 이름 (코어데이터에 저장된 객체)
//    let modelName: String = "MusicSaved"
//    
//    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
//    func getMusicSavedArrayFromCoreData() -> [MusicSaved] {
//        var savedMusicList: [MusicSaved] = []
//        // 임시저장소 있는지 확인
//        if let context = context {
//            // 요청서
//            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
//            // 정렬순서를 정해서 요청서에 넘겨주기
//            let savedDate = NSSortDescriptor(key: "savedDate", ascending: true)
//            request.sortDescriptors = [savedDate]
//            
//            do {
//                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기
//                if let fetchedMusicList = try context.fetch(request) as? [MusicSaved] {
//                    savedMusicList = fetchedMusicList
//                }
//            } catch {
//                print("가져오는 것 실패")
//            }
//        }
//        
//        return savedMusicList
}
