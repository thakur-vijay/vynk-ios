//
//  CountryPicker.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

@available(iOS 17.0, *)
public struct CountryPickerView: View {
    let selectedCountry: CountryModel?
    let onClose: (CountryModel?)->()
    @State private var viewModel: CountryPickerViewModel
    
    public init(
        selectedCountry: CountryModel?,
        onClose: @escaping (CountryModel?)->()
    ) {
        self.onClose = onClose
        self.selectedCountry = selectedCountry
        let dataSource = LocalCountryDataSource()
        let repository = DefaultCountryRepository(dataSource: dataSource)
        _viewModel = State(
            wrappedValue: CountryPickerViewModel(
                fetchCountriesUseCase: FetchCountriesUseCase(repository: repository),
                selectedCountry: selectedCountry
            )
        )
    }
    
    public var body: some View {
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
                        .tint(.primary)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "xmark"){
                        onClose(viewModel.selectedCountry)
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search"))
        }

    }
}
