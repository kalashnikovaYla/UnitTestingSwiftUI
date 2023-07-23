//
//  ContentView.swift
//  UnitTestingSwiftUI
//
//  Created by sss on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: ViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.isPremium.description)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isPremium: true)
    }
}
