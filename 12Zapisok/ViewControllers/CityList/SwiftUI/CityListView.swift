//
//  CityListView.swift
//  CityList
//
//  Created by Anton Makarov on 18.09.2021.
//

import SwiftUI

struct CityListView<ViewModel: CityListViewModeling>: View {

    @ObservedObject var viewModel: ViewModel

    var colors: [Color] = [.yellow, .purple, .green]
    var chooseCompletion: ((City) -> Void)?

    var gridItemLayout = [GridItem(.flexible()),
                          GridItem(.flexible())]

    var body: some View {
        //  CustomNavBar(title: "Custom Nav", content:
        //ScrollView {
            //CityListHeaderView()

            //LazyVGrid(columns: gridItemLayout, spacing: 16) {

                List(viewModel.citiesSU) { index in
                    //Text("Test")
                    CityListItemView(name: index.name)
                        .frame(maxWidth: .infinity, minHeight: 190)
                }

                //                                ForEach(0 ..< 20) { value in
                //                                    CityListItemView()
                //                                        .frame(maxWidth: .infinity, minHeight: 190)
                //
                //                                }
           // }
       // }
       // .padding(.horizontal, 16)
        //).frame(width: .infinity, height: 64)
        .onAppear(perform: viewModel.fetchCities)
    }
}

struct CustomNavBar<Content>: View where Content: View {

    let title: String
    let content: Content

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("12345")
                        .resizable()
                        .frame(height: 135)
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                }
                content
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
}
