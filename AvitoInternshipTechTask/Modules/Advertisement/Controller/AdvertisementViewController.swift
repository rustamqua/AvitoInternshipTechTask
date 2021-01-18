//
//  ViewController.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 17.01.2021.
//

import UIKit

private enum Constants {
    static let collectionViewWidth: CGFloat = UIScreen.main.bounds.width - 32
}

final class AdvertisementViewController: UIViewController {
    
    var presenter: AdvertisementPresentable
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()
    
    private lazy var closeButton = CloseButton()
    private lazy var advertisementTitle = AdvertisementTitleCell()
    private lazy var selectButton = SelectButton()
    
    private var cellViewModels = [AdvertisementOptionCellViewModel]()
    private var titleCellViewModel: AdvertisementTitleCellViewModel?
    
    init(presenter: AdvertisementPresentable) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        addTargets()
        setupUI()
        let loadedData = presenter.loadData()
        configureSubviewsAndReloadData(titleViewModel: loadedData.titleViewModel,
                                       cellViewModels: loadedData.cellViewModels,
                                       buttonViewModel: loadedData.buttonViewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func selectOption() {
        presenter.onSelectButtonDidTap()
    }
    
    private func loadImage(iconUrl: String, completion: @escaping (UIImage?) -> Void) {
        utilityQueue.async {
            let url = URL(string: iconUrl)!
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AdvertisementOptionCell.self, forCellWithReuseIdentifier: "optionCell")
        collectionView.register(AdvertisementTitleCell.self, forCellWithReuseIdentifier: "titleCell")
    }
    
    private func configureSubviewsAndReloadData(titleViewModel: AdvertisementTitleCellViewModel,
                                                cellViewModels: [AdvertisementOptionCellViewModel],
                                                buttonViewModel: SelectButtonViewModel) {
        self.cellViewModels = cellViewModels
        self.titleCellViewModel = titleViewModel
        selectButton.configure(with: buttonViewModel)
        collectionView.reloadData()
    }
    
    private func addTargets() {
        selectButton.addTarget(self, action: #selector(selectOption), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [closeButton, collectionView, selectButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            collectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -16),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            selectButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
}

extension AdvertisementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return cellViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        cellViewModels = presenter.getUpdatedCellViewModelsOnSelect(viewModel: cellViewModels[indexPath.row])
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? AdvertisementOptionCell else { return }
        let iconKey = NSNumber(value: indexPath.item)
        if let cachedImage = self.cache.object(forKey: iconKey) {
            cell.loadIconFromCache(image: cachedImage)
        } else {
            self.loadImage(iconUrl: cellViewModels[indexPath.row].iconUrl) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                cell.loadIconFromCache(image: image)
                self.cache.setObject(image, forKey: iconKey)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleCell", for: indexPath)
            if let viewModel = titleCellViewModel, let cell = cell as? AdvertisementTitleCell {
                cell.configure(with: viewModel)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "optionCell", for: indexPath)
            if let cell = cell as? AdvertisementOptionCell {
                cell.configure(with: cellViewModels[indexPath.row])
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            guard let titleViewModel = titleCellViewModel else { return .zero }
            let height = titleViewModel.title.height(withConstrainedWidth: Constants.collectionViewWidth, font: .boldSystemFont(ofSize: 28))
            return .init(width: Constants.collectionViewWidth, height: height + 48)
        default:
            let viewModel = cellViewModels[indexPath.item]
            var totalHeight = AdvertisementOptionCell.staticContentHeight
            let heightForTitle = viewModel.title.height(withConstrainedWidth:
                                                            AdvertisementOptionCell.textContentWidth, font: .boldSystemFont(ofSize: 24))
            totalHeight += heightForTitle
            if let info = viewModel.info {
                let heightForInfo = info.height(withConstrainedWidth: AdvertisementOptionCell.textContentWidth, font: .systemFont(ofSize: 16))
                totalHeight += heightForInfo
            } else {
                totalHeight -= 12
            }
            return .init(width: Constants.collectionViewWidth, height: totalHeight)
        }
    }
    
}
