//
//  CityListHeaderView.swift
//  CityList
//
//  Created by Anton Makarov on 19.09.2021.
//

import SwiftUI

struct CityListHeaderView: View {

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "star")
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.purple, lineWidth: 2))

            Rectangle()
                .frame(width: 40, height: 2)
                .cornerRadius(8)
                .foregroundColor(.gray)

            VStack(spacing: 2) {
                Text("Ваш выбранный город")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)

                Text("Нижний Новгород")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
        }
    }
}

struct CityListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CityListHeaderView()

    }
}
