//
//  OptionsPopover.swift
//  IntermittentFastingApp
//
//  Created by Romero Peces Barba, Kevin on 9/1/23.
//

import SwiftUI

struct OptionsPopover: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done", action: viewModel.optionsDoneButtonAction)
            }
            .padding(.vertical)
            .padding(.horizontal, 6)
            
            HStack {
                Text("Session Kind")
                Spacer()
                SessionKindPicker()
            }
            
            Spacer()
                .frame(height: 100)
        }
    }
    
    private func SessionKindPicker() -> some View {
        Menu {
            SessionKindPickerSection("Daily", kinds: IFSession.Kind.dailyCases)
            SessionKindPickerSection("Weekly", kinds: IFSession.Kind.weeklyCases)
            SessionKindPickerSection("Other", kinds: IFSession.Kind.otherCases)
            SessionKindPickerSection("Debug", kinds: IFSession.Kind.debugCases)
        } label: {
            Text(viewModel.optionsSessionKind.title)
                .frame(minWidth: 60)
        }
        .buttonStyle(.bordered)
    }
    
    private func SessionKindPickerSection(_ title: LocalizedStringKey, kinds: [IFSession.Kind]) -> some View {
        Section(title) {
            ForEach(kinds) { kind in
                SessionKindPickerButton(kind: kind)
            }
        }
    }
    
    private func SessionKindPickerButton(kind: IFSession.Kind) -> some View {
        Button(kind.title) {
            viewModel.optionsSessionKind = kind
        }
        .tag(kind)
    }
}

//struct OptionsPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionsPopover()
//    }
//}
