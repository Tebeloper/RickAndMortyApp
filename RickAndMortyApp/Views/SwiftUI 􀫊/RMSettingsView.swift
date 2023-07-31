//
//  RMSettingsView.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 31/07/2023.
//

import SwiftUI

struct RMSettingsView: View {
    
    private let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack(spacing: 18) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color(uiColor: viewModel.iconContainerColor))
                        .cornerRadius(8)
                }
                Text(viewModel.title)
                
                Spacer()
            } //:HStack
            .padding(.bottom, 10)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        } //:List
    } //:View
} //:RMSettingsView

// MARK: - Preview
struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0) { option in
            }
        })))
    }
}
