//
//  CityInfoViewModel.swift
//  12Zapisok
//
//  Created by Anton Makarov on 19.03.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//

import Foundation

enum CityInfoRoute {
    case map
    case back
}

protocol CityInfoViewModeling {
    var routeTo: ((CityInfoRoute) -> Void)? { get set }
    func getName() -> String
    func getImageCount() -> Int
    func getImageUrl(by index: Int) -> String
    func getDescription() -> String
    func getBuildingYear() -> String
    func getPopulation() -> String
    func getRegionCode() -> String
}

class CityInfoViewModel {
    var routeTo: ((CityInfoRoute) -> Void)?
    let imageUrls = ["A", "B"]
}

extension CityInfoViewModel: CityInfoViewModeling {
    
    func getName() -> String {
        return "Нижний Новгород"
    }
    
    func getImageUrl(by index: Int) -> String {
        return imageUrls[index]
    }
    
    func getImageCount() -> Int {
        return imageUrls.count
    }
    
    func getDescription() -> String {
        return "Нижний Новгород (в советское время — Горький) является пятым по численности населения городом России, расположен на берегах Оки при впадении в Волгу. Находится на стыке Поволжья и Центральной России, сочетая величие Кремля и камерность центральных районов с размахом старинной волжской ярмарки и промышленных окраин. Нижний — город на удивление многоликий, где вы найдёте памятники самых разных веков, перемежающиеся захватывающими панорамами с высокого волжского берега. Кроме совершенно разноплановой архитектуры в Нижнем Новгороде не один десяток музеев и активная культурная жизнь, не уступающая другим крупным городам России."
    }
    
    func getBuildingYear() -> String {
        return "1221 г"
    }
    
    func getPopulation() -> String {
        return "1.25 млн"
    }
    
    func getRegionCode() -> String {
        return "152 RUS"
    }
}
