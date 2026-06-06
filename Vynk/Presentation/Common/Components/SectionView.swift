//
//  SectionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct SectionView<ID: RowIDProtocol>: View {
    let section: SectionModel<ID>
    let toggleBinding: ((ID) -> Binding<Bool>?)?
    let onRowTap: (_ rowID: ID) -> Void
    init(
        section: SectionModel<ID>,
        toggleBinding: ((ID) -> Binding<Bool>?)? = nil,
        onRowTap: @escaping (_ rowID: ID) -> Void
        
    ) {
        self.section = section
        self.toggleBinding = toggleBinding
        self.onRowTap = onRowTap
    }
    
    var body: some View {
        Section {
            ForEach(section.rows) { row in
                SectionRowView(row: row, toggleBinding: toggleBinding?(row.id)) {
                    onRowTap(row.id)
                }
            }
        } header: {
            if let header = section.header {
                Text(header)
            }
        } footer: {
            if let footer = section.footer {
                Text(footer)
            }
        }
    }
}
