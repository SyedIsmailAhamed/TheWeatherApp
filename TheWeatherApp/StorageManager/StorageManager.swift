//
//  Environment.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//


import Foundation
import RealmSwift
import Unrealm


class StorageManager {
    private static var sharedInstance : StorageManager{
        return StorageManager()
    }

    func saveData<T:Realmable>(model:T, completionHandler : @escaping ((Bool)->())){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(model, update: .all)
                completionHandler(true)
            }
        } catch let error {
            print("failed to save to realm\(error)")
            completionHandler(false)
        }

    }

    func fetchData<T: Realmable>(with type: T.Type, filterPredicate:NSPredicate? = nil)->[T]{
        var dataArray = [T]()
        do {
            let realm = try Realm()
            if let predicate = filterPredicate{
                dataArray = realm.objects(type).filter(predicate).map{$0}
            }else{
                dataArray = realm.objects(type).map{$0}
            }
           // print("data is \(dataArray)") //map{$0}
        } catch let error {
            print("failed to fetch data from realm\(error)")
        }
        return dataArray
    }

    class func shared() -> StorageManager {
        return sharedInstance
    }

    func registerRealmables(){
        Realm.registerRealmables(User.self)
        Realm.registerRealmables(HomeWeather.self)
        Realm.registerRealmables(Current.self)
        Realm.registerRealmables(Hourly.self)
        Realm.registerRealmables(Daily.self)
        Realm.registerRealmables(FeelsLike.self)
        Realm.registerRealmables(Temperature.self)
        Realm.registerRealmables(Weather.self)
    }
}


extension RealmSwift.List {

    func toArray() -> [Any] {
        return self.map{$0}
    }
}



class User : Realmable {
    private static var sharedInstance : User{
        let currentUser = User()
        currentUser.iD = UUID().uuidString
        return currentUser
    }
    var iD : String?

    static func primaryKey() -> String? {
        return "iD"
    }
    required init() {

    }
    class func shared() -> User {
        return sharedInstance
    }
}
