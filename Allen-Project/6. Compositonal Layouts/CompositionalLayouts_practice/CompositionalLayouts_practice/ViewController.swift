//
//  ViewController.swift
//  CompositionalLayouts_practice
//
//  Created by 송선진 on 2022/11/08.
//

import UIKit
import SnapKit

/*
 - UICollectionView 참조: https://lsh424.tistory.com/52
 */
class ViewController: UIViewController {
    
    // MARK: - Properties

    let firstSection = FirstSection()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupFirstSection()
    }

    // MARK: - Helpers

    func setupFirstSection() {
        view.addSubview(firstSection)
        
        firstSection.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(60)
            make.height.equalTo(60)
        }
    }
    
//    func setupCollectionView() {
//        // collectionView) header register
//        self.collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(Header.self)")
//    }
    
    // collectionView header 불러오기
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        guard kind == UICollectionView.elementKindSectionHeader, // kind가 header이고,
//              let header = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: "\(Header.self)",
//                for: indexPath
//              ) as? Header else { return UICollectionReusableView() }
//
//        return header
//    }
}
