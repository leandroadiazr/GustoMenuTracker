//
//  ViewController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/18/21.
//

import UIKit
import Anchorage

class MenuViewController: UIViewController {
    struct Layout {
        static let cornerRadius = CGFloat(16)
        static let edgeInsets = CGFloat(20)
    }
    
    enum Section: String, CaseIterable {
        case dishOfDay = "Dish of the day"
        case WeekOne = "WeekOne"
        case WeekTwo = "WeekTwo"
    }
    
    var specials = specialMenu
    
    lazy var background: UIView = {
        let customView = CustomBackgroundView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 280))
        customView.background = CustomColors.CustomGreenColor
        customView.label = "Gusto Lunch Tracker"
        return customView
    }()

    var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureCollectionView()
    }
    
    private func configureLayout() {
        view.addSubview(background)
        background.backgroundColor = CustomColors.CustomGreenColor
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.frame = CGRect(x: 0, y: 180, width: view.bounds.width, height: view.bounds.height - 180 )
        collectionView?.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseID)
        collectionView?.register(CurrentWeekCell.self, forCellWithReuseIdentifier: CurrentWeekCell.reuseID)
        collectionView?.register(NextWeekCell.self, forCellWithReuseIdentifier: NextWeekCell.reuseID)
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView?.backgroundColor = .clear
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func customLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sections = Section.allCases[sectionNumber]
            switch sections {
            case .dishOfDay:
                return self.createFeaturedSection(using: .dishOfDay)
            case .WeekOne:
                return self.createWeekOneSection(using: .WeekOne)
            case .WeekTwo:
                return self.createWeekTwoSection(using: .WeekTwo)
            }
        }
        
        return layout}
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return specials.count
        case 1:
            return 6
        case 2:
            return 5
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseID, for: indexPath) as! FeaturedCell
            cell.viewImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.buttonAction = { [weak self] in
                guard let self = self else {return}
                self.customAlert(title: "title", message: "message", buttonTitle: "Ok")
            }
            let item = specials[indexPath.item]
            cell.configure(with: item)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeekCell.reuseID, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextWeekCell.reuseID, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
            header?.configure(with: "Special of the day")
            header?.title.textColor = .white
            return header ?? UICollectionReusableView()
        } else if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
            header?.configure(with: "This Week Menu")
            return header ?? UICollectionReusableView()
        } else if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader
            header?.configure(with: "Next Week Menu")
            return header ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let controller = UIViewController()
        controller.view.backgroundColor = indexPath.section == 0 ? .blue : .yellow
        self.present(controller, animated: true, completion: nil)
    }
    
    
}



extension MenuViewController{
    
//MARK: FEATURED SECTION
    private func createFeaturedSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets.bottom = 16
        layoutSection.orthogonalScrollingBehavior = .continuous
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        return layoutSection
    }
    
    private func createWeekOneSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(160))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
       
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createWeekTwoSection(using section: Section) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(150))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
       
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(20))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with menu: Menu, for indexPath: IndexPath) -> T {
        guard let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: menu)
        return cell
    }
}

extension MenuViewController {
    private func setupConstraints() {
        background.topAnchor == view.topAnchor
    }
}
