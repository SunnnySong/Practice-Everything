//
//  CollectionViewModel.swift
//  CompositionalLayouts_practice
//
//  Created by 송선진 on 2022/11/13.
//

import UIKit

struct CollectionViewModel {
    static func createLayout() -> UICollectionViewCompositionalLayout {
//        section이 1개일때: UICollectionViewCompositionalLayout(section: <#T##NSCollectionLayoutSection#>)
//        section이 여러개일때: UICollectionViewCompositionalLayout(sectionProvider: <#T##UICollectionViewCompositionalLayoutSectionProvider##UICollectionViewCompositionalLayoutSectionProvider##(Int, NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?#>)
        
        let layout = UICollectionViewCompositionalLayout { (sectionNum, env) -> NSCollectionLayoutSection? in
            
            switch sectionNum {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case 1:
                // fractionalHeight/fractionalWidth : containing group의 크기에 비례해서 크기 결정. 0 ~ 1
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                // group : item의 넘어가는 방향을 결정.
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .fractionalWidth(0.47))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 16, trailing: 15)
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                // header
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 17)
                
                // 차트 형식으로 만들으려 하면, groupSize의 heightDimension을 .fractionalHeight로 설정X
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.87), heightDimension: .estimated(70))
//                 ViewController에서 이 section의 Item 갯수 12개 설정.
//                 layoutSize 크기의 repeatingSubitem을 count갯수만큼 반복해서 vertical한 group을 생성.
//                 즉, 아래는 높이가 70만큼의 item 4개가 생성되는 것.
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 17)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .estimated(60))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            case 4:
                /*
                 한 group당 여러개의 Item이 들어가듯, group 또한 여러개의 group을 묶을 수 있음.
                 -> 하나의 section에 Item, group은 여러개 가능.
                 */
                let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(200))
                let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
                let itemSize3 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(120))
                let itemSize4 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(120))
                let itemSize5 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(160))
                let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
                let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
                let item3 = NSCollectionLayoutItem(layoutSize: itemSize3)
                let item4 = NSCollectionLayoutItem(layoutSize: itemSize4)
                let item5 = NSCollectionLayoutItem(layoutSize: itemSize5)
                
                // group1
                let groupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
                let group1 = NSCollectionLayoutGroup.vertical(layoutSize: groupSize1, repeatingSubitem: item2, count: 2)
                
                let horizontalSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalSize, subitems: [item1, group1])
                
                let bottomSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
                let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomSize, subitems: [item3, item4])
                
                let leftSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(320))
                let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftSize, subitems: [horizontalGroup, bottomGroup])
                
                let rightSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(320))
                let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightSize, repeatingSubitem: item5, count: 2)
                
                /*
                 몇 시간동안 해결한 오류
                 문제) rightGroup를 추가해도 보이지 않고, 추가하지도 않았던 horizontalGroup의 Item들이 대신 추가되는 현상 발생.
                 let leftSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1)) 로 실행해보길 바람.
                 
                 - 해결: 개고생 끝에, 문득 위에 있는 group들은 height를 모두 .absolute로 주었는데 leftSize를 상위 컨테이너의 높이로 설정해버리면(.fractionalHeight), leftGroup 안에 있는 horizontalGroup + bottomGroup과 상위 컨테이너 높이 간 차이가 발생할 수 있고 결국 그 여백을 메꾸기 위해 rightGroup 대신 호출하지도 않은 horizontalGroup의 Item들이 다시 생성되며 빈자리 메꿈.
                 - 결론: 함부로 .fractionalHeight 사용하지 마라. 그리고 처음부터 .absolute를 사용했으면 끝까지 사용하라.
                 
                 추가적 문제)    let totalSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320)) 여기서 height를 .fractionalHeight 로 주게되면 하단 스크롤이 매우 매우 쭈욱 늘어나 여백이 많이 생기기 때문에 왠만하면 .absolute로 사용하라. 
                 */
                let totalSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(320))
                let totalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: totalSize, subitems: [leftGroup, rightGroup])
                
                let section = NSCollectionLayoutSection(group: totalGroup)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
                section.boundarySupplementaryItems = [header]
                return section
                
            default:
                return NSCollectionLayoutSection(group: NSCollectionLayoutGroup(layoutSize: .init(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(0.2))))
            }
        }
        return layout
    }
}
