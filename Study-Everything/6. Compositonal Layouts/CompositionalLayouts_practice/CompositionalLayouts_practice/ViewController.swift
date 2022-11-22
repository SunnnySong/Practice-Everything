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
 youtubeMusic 메인 화면 clone coding
 */
class ViewController: UIViewController {
    
    // MARK: - Properties

    let firstSection = FirstSection()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewModel.createLayout())
        cv.isScrollEnabled = true
        // ScrollIndicator = 스크롤 시 오른쪽에 보이는 스크롤바
        cv.showsVerticalScrollIndicator = true
        cv.showsHorizontalScrollIndicator = false
        cv.scrollIndicatorInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 4)
        // TODO: UIScrollView - ContentOffset, ContentInset, ContentSize 공부하기
        // 참조 : https://yoojin99.github.io/app/ContentOffset,-ContentInset,-ContentSize/
        cv.backgroundColor = .clear
        
        // cell 등록
        cv.register(CollectionViewCell1.self, forCellWithReuseIdentifier: "\(CollectionViewCell1.self)")
        cv.register(CollectionViewCell2.self, forCellWithReuseIdentifier: "\(CollectionViewCell2.self)")
        cv.register(CollectionViewCell3.self, forCellWithReuseIdentifier: "\(CollectionViewCell3.self)")
        cv.register(CollectionViewCell4.self, forCellWithReuseIdentifier: "\(CollectionViewCell4.self)")
        // Header 등록
        cv.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(Header.self)")
        return cv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupFirstSection()
        setupCollectionView()
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
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(firstSection.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(70)
            make.right.equalToSuperview()
        }
    }
}


// MARK: - Extensions

extension ViewController: UICollectionViewDataSource {
    // section 별 item 갯수 정하기
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1{
            return 12
        } else if section == 2 {
            return 12
        } else if section == 3 {
            return 7
        } else {
            return 5
        }
    }
    
    // section 별 cell 연결하기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell1.self)", for: indexPath) as! CollectionViewCell1
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell2.self)", for: indexPath) as! CollectionViewCell2
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell3.self)", for: indexPath) as! CollectionViewCell3
        let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell4.self)", for: indexPath) as! CollectionViewCell4
        
        if indexPath.section == 0 {
            return cell1
        } else if indexPath.section == 1 {
            return cell2
        } else if indexPath.section == 2 {
            return cell3
        } else {
            return cell4
        }
    }
    
    // collectionView에 Header 연결하기
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(Header.self)", for: indexPath) as! Header
            
            // header 별 text 변경
            if indexPath.section == 0 {
                header.headerLabel.text = "새 앨범 및 싱글"
            } else if indexPath.section == 1 {
                header.headerLabel.text = "인기곡"
            } else if indexPath.section == 2 {
                header.headerLabel.text = "분위기 및 장르"
            } else if indexPath.section == 3 {
                header.headerLabel.text = "최신 앨범"
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate {

    // collectionView에서 section의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
}
