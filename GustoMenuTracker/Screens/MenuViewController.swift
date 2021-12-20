//
//  ViewController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/18/21.
//

import UIKit
import Anchorage


protocol MenuViewControllerDelegate: AnyObject {
    func notify(item: Menu)
}

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
    var weekOne = weekOneMenu
    var weekTwo = weekTwoMenu
    
    lazy var background: UIView = {
        let customView = CustomBackgroundView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 280))
        customView.background = CustomColors.CustomGreenColor
        customView.label = "Gusto Lunch Tracker"
        return customView
    }()
    
    var collectionView: UICollectionView?
    weak var menuDelegate: MenuViewControllerDelegate?
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
        collectionView?.backgroundColor = .clear
        registerCells()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func registerCells() {
        collectionView?.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseID)
        collectionView?.register(CurrentWeekCell.self, forCellWithReuseIdentifier: CurrentWeekCell.reuseID)
        collectionView?.register(NextWeekCell.self, forCellWithReuseIdentifier: NextWeekCell.reuseID)
        collectionView?.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
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
        return layout
    }
    
    private func addToCart(item: Menu) {
        PersistenceManager.updateWith(menuItem: item, actionType: .add) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.customAlert(title: "Success!...", message: "User added to Cart..", buttonTitle: "Okay")
                return
            }
            self.customAlert(title: "Something went wrong...", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    private func removeFromCart(item: Menu) {
        PersistenceManager.updateWith(menuItem: item, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            DispatchQueue.main.async {
                self.customAlert(title: "Item Removed", message: error.rawValue, buttonTitle: "Continue")
            }
        }
    }
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
            return weekOne.count
        case 2:
            return weekTwo.count
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseID, for: indexPath) as! FeaturedCell
            cell.viewImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            let item = specials[indexPath.item]
            cell.configure(with: item)
            cell.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.addToCart(item: item)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeekCell.reuseID, for: indexPath) as? CurrentWeekCell
            let item = weekOne[indexPath.item]
            cell?.configure(with: item)
            cell?.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.addToCart(item: item)
            }
            return cell ?? UICollectionViewCell()
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextWeekCell.reuseID, for: indexPath) as? NextWeekCell
            let item = weekOne[indexPath.item]
            cell?.configure(with: item)
            cell?.buttonAction = { [weak self] in
                guard let self = self else { return }
                self.addToCart(item: item)
            }
            return cell ?? UICollectionViewCell()
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
        let controller = DetailsViewController()
        switch indexPath.section {
        case 1:
            let item = weekOne[indexPath.row]
            controller.generics.append(item)
            self.present(controller, animated: true, completion: nil)
        case 2:
            let item = weekTwo[indexPath.row]
            controller.generics.append(item)
            self.present(controller, animated: true, completion: nil)
        default:
            let item = specials[indexPath.row]
            controller.generics.append(item)
            self.present(controller, animated: true, completion: nil)
        }
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
