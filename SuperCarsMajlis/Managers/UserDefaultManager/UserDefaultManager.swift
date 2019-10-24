//
//  UserDefaultManager.swift
//  Nibou
//
//  Created by Ongraph on 5/8/19.
//  Copyright © 2019 OnGraph. All rights reserved.
//

import Foundation

//MARK: - AccessToken Data
/**
 MARK: - Set AccessToken Data
 */
func setAccessTokenModel(model: RegisterModel){
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(model) {
        Constants.kUserDefault.set(encoded, forKey: Constants.kAccessModel)
        Constants.kUserDefault.synchronize()
    }
}

/**
 MARK: - Get AccessToken Data
 - Returns: AccessToken Data
 */
func getAccessTokenModel() -> RegisterModel?{
    if let data = Constants.kUserDefault.object(forKey: Constants.kAccessModel) as? Data {
        let decoder = JSONDecoder()
        if let model = try? decoder.decode(RegisterModel.self, from: data) {
            return model
        }else{
            return nil
        }
    }else{
        return nil
    }
}

enum UserState: String{
    case walkthrough
    case pastEvent
    case home
}

func setUserState(state: UserState){
    Constants.kUserDefault.set(state.rawValue, forKey: Constants.kUserState)
    Constants.kUserDefault.synchronize()
}

func getUserState() -> UserState{
    if let state = Constants.kUserDefault.value(forKey: Constants.kUserState) as? String{
        return UserState(rawValue: state) ?? .walkthrough
    }else{
        return .walkthrough
    }
}

//MARK: - Clear All Defaults
func clearUserDefault(){
    Constants.kUserDefault.removeObject(forKey: Constants.kAccessModel)
    Constants.kUserDefault.removeObject(forKey: Constants.kUserState)
    Constants.kUserDefault.synchronize()
}
