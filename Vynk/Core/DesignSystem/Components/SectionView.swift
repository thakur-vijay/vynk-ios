//
//  SectionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import SwiftUI

struct SectionView<ID: RowIDProtocol>: View {
    let section: SectionModel<ID>
    var selection: ID?
    let toggleBinding: ((ID) -> Binding<Bool>?)?
    let onRowTap: (_ rowID: ID, _ kind: SectionRowKind) -> Void
    init(
        section: SectionModel<ID>,
        selection: ID? = nil,
        toggleBinding: ((ID) -> Binding<Bool>?)? = nil,
        onRowTap: @escaping (_ rowID: ID, _ kind: SectionRowKind) -> Void
        
    ) {
        self.section = section
        self.selection = selection
        self.toggleBinding = toggleBinding
        self.onRowTap = onRowTap
    }
    
    var body: some View {
        Section {
            ForEach(section.rows) { row in
                SectionRowView(row: row, toggleBinding: toggleBinding?(row.id), selection: selection) {
                    onRowTap(row.id, row.kind)
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
