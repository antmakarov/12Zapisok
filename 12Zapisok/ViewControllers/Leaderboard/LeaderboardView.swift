//
//  LeaderboardView.swift
//  12Zapisok
//
//  Created by Anton Makarov on 21.09.2021.
//  Copyright © 2021 A.Makarov. All rights reserved.
//

import SwiftUI

struct LeaderboardView<ViewModel: LeaderboardViewModeling>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Text("Hello, World!")
    }
}

//struct LeaderboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardView(viewModel: <#_#>)
//    }
//}
