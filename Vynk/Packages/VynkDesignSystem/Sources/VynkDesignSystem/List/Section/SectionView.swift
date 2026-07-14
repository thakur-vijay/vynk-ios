//
//  SectionView.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 13/07/26.
//


import SwiftUI

public struct SectionView<RowID: Hashable>: View {
    let section: SectionModel<RowID>
    var selection: RowID?
    let binding: ((RowID) -> Binding<Bool>?)?
    let onRowTap: (_ rowID: RowID, _ kind: SectionRowKind) -> Void
    public init(
        section: SectionModel<RowID>,
        selection: RowID? = nil,
        binding: ((RowID) -> Binding<Bool>?)? = nil,
        onRowTap: @escaping (_ rowID: RowID, _ kind: SectionRowKind) -> Void
        
    ) {
        self.section = section
        self.selection = selection
        self.binding = binding
        self.onRowTap = onRowTap
    }
    
    public var body: some View {
        Section {
            ForEach(section.rows) { row in
                SectionRowView(row: row, binding: binding?(row.id), selection: selection) {
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
