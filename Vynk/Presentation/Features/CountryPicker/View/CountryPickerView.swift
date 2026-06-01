//
//  CountryPicker.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

struct CountryPickerView: View {
    let onClose: (CountryModel?)->()
    @State private var viewModel: CountryPickerViewModel
    
    init(viewModel: CountryPickerViewModel, onClose: @escaping (CountryModel?)->()) {
        _viewModel = State(wrappedValue: viewModel)
        self.onClose = onClose
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.filteredCountries) { country in
                        Button {
                            viewModel.selectedCountry = country
                            onClose(country)
                        } label: {
                            CountryRowView(model: country, isSelected: country.id == viewModel.selectedCountry?.id)
                        }
                        .tint(AppColors.contentDefault)
                    }
                }
                .task {
                    viewModel.loadCountries()
                    await MainActor.run {
                        if let currentCountry = viewModel.currentCountry {
                            proxy.scrollTo(
                                
                                currentCountry.id,
                                
                                anchor: .center
                                
                            )
                            
                        }
                        
                    }
                }
            }
            .navigationTitle("Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarCloseButton {
                    onClose(viewModel.selectedCountry)
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search"))
        }

    }
}
