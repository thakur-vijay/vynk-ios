//
//  CountryPicker.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI
import ComposableArchitecture

@available(iOS 17.0, *)
public struct CountryPickerView: View {

    @Bindable
    var store: StoreOf<CountryPickerFeature>

    public init(
        store: StoreOf<CountryPickerFeature>
    ) {
        self.store = store
    }

    public var body: some View {

        NavigationStack {

            ScrollViewReader { proxy in

                List {

                    ForEach(store.filteredCountries) { country in

                        Button {

                            store.send(
                                .countryTapped(country)
                            )

                        } label: {

                            CountryRowView(
                                model: country,
                                isSelected: country.id == store.selectedCountry?.id
                            )
                        }
                        .tint(.primary)
                        .id(country.id)
                    }
                }
                .onChange(of: store.currentCountry?.id) { _, id in
                    guard let id else { return }
                    proxy.scrollTo(id, anchor: .center)
                }
                .task {
                    await store.send(.onTask).finish()
                    await MainActor.run {
                        if let currentCountry = store.currentCountry {
                            print("Current Country is", currentCountry.name)
                            proxy.scrollTo(
                                currentCountry.id,
                                anchor: .center
                            )
                        }else {
                            print("Current Country is nil")
                        }
                    }
                }
            }
            .navigationTitle("Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(
                    placement: .topBarTrailing
                ) {

                    Button(
                        "",
                        systemImage: "xmark"
                    ) {
                        store.send(.closeButtonTapped)
                    }
                }
            }
            .searchable(
                text: $store.searchText,
                placement: .navigationBarDrawer(
                    displayMode: .always
                ),
                prompt: Text("Search")
            )
        }
    }
}
