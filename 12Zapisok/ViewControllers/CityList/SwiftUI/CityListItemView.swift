//
//  CityListItemView.swift
//  CityList
//
//  Created by Anton Makarov on 19.09.2021.
//

import SwiftUI

struct CityListItemView: View {
    var name: String

    var body: some View {
        VStack(spacing: 0) {
            Image(Bool.random() ? "nn" : "kazan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.blue)

            HStack() {
                Spacer()
                VStack() {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text("Пройдено: 80%")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.vertical, 8)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
}
