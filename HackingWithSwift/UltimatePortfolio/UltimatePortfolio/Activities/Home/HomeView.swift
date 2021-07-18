//
//  HomeView.swift
//  UltimatePortfolio
//
//  Created by Andrei Chenchik on 13/7/21.
//

import CoreData
import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"

    @StateObject var viewModel: ViewModel

    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        if viewModel.projects.isEmpty == false {
                            LazyHGrid(rows: projectRows) {
                                ForEach(viewModel.projects, content: ProjectSummaryView.init)
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    VStack(alignment: .leading) {
                        ItemListView(title: "Up next", items: viewModel.upNext)
                        ItemListView(title: "More to explore", items: viewModel.moreToExplore)
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
#if DEBUG
            .toolbar {
                Button("Add Data") {
                    viewModel.addSampleData()
                }
            }
#endif
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: DataController.preview)
    }
}
