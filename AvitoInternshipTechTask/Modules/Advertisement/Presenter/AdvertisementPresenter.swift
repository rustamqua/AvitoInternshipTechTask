//
//  AdvertisementPresenter.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import Foundation

//swiftlint:disable large_tuple
protocol AdvertisementPresentable {
    func loadData() -> (titleViewModel: AdvertisementTitleCellViewModel,
                             cellViewModels: [AdvertisementOptionCellViewModel],
                             buttonViewModel: SelectButtonViewModel)
    func onSelectButtonDidTap()
    func getUpdatedCellViewModelsOnSelect(viewModel: AdvertisementOptionCellViewModel) -> [AdvertisementOptionCellViewModel]
}

final class AdvertisementPresenter: AdvertisementPresentable {
    
    private let interactor: AdvertisementInteractorOutput
    private let router: AdvertisementRoutable
    
    private var cellViewModels = [AdvertisementOptionCellViewModel]()
    
    init(interactor: AdvertisementInteractorOutput, router: AdvertisementRoutable) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadData() -> (titleViewModel: AdvertisementTitleCellViewModel,
                             cellViewModels: [AdvertisementOptionCellViewModel],
                             buttonViewModel: SelectButtonViewModel) {
        guard let advertisement = interactor.fetchAdvertisement() else {
            return (AdvertisementTitleCellViewModel(title: String()), [], SelectButtonViewModel(title: String()))
        }
        
        var cellViewModels = advertisement.result.list.compactMap {
            AdvertisementOptionCellViewModel(id: $0.id,
                                             title: $0.title,
                                             info: $0.description,
                                             price: $0.price,
                                             isSelected: $0.isSelected,
                                             iconUrl: $0.icon.small)
        }
        
        let firstSelectedIndex = cellViewModels.firstIndex(where: { $0.isSelected })
        if let firstSelectedIndex = firstSelectedIndex {
            cellViewModels = cellViewModels.enumerated().map { index, viewModel in
                if index != firstSelectedIndex {
                    return .init(prevModel: viewModel, isSelected: false)
                }
                return viewModel
            }
        }
        self.cellViewModels = cellViewModels
        
        return (AdvertisementTitleCellViewModel(title: advertisement.result.title),
                cellViewModels,
                SelectButtonViewModel(title: advertisement.result.selectedActionTitle)
        )
    }
    
    func getUpdatedCellViewModelsOnSelect(viewModel: AdvertisementOptionCellViewModel) -> [AdvertisementOptionCellViewModel] {
        cellViewModels = cellViewModels.map {
            if $0.id == viewModel.id {
                return .init(prevModel: $0, isSelected: !$0.isSelected)
            }
            return .init(prevModel: $0, isSelected: false)
        }
        return cellViewModels
    }
    
    func onSelectButtonDidTap() {
        let viewModel = cellViewModels.first(where: { $0.isSelected })
        router.presentAdvertisementDetails(with: viewModel, errorMessage: "Выберите опцию!")
    }

}
