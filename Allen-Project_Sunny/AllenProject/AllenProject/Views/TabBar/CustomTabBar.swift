//
//  CustomTabBar.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/18.
//

import UIKit
import SnapKit

class CustomTabBar: UITabBar {
    
    public var middleBtnActionHandler:() -> () = {}
    
    private var shapeLayer: CALayer?
    
    let middleButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(hex: "5294F9")
        
        var titleAttr = AttributedString.init("로또 QR")
        titleAttr.font = .systemFont(ofSize: 13, weight: .bold)
        config.attributedSubtitle = titleAttr
        config.titleAlignment = .center
        
        let image = UIImage(systemName: "qrcode")
        // image 사이즈 조정
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
        config.preferredSymbolConfigurationForImage = imageConfig
        config.image = image
        config.imagePadding = 5
        config.imagePlacement = .top
        
        return UIButton(configuration: config)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(hex: "202632")
        // tabBarItem font 변경
//        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font : UIFont.gmarksans(weight: .regular, size: ._11)]
//        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.font : UIFont.gmarksans(weight: .medium, size: ._11)]
        
        self.standardAppearance = tabBarAppearance
        self.scrollEdgeAppearance = tabBarAppearance
        self.itemSpacing = 130
        self.tintColor = .white
        
        self.frame.size.height += 50
    }
    
    private func setupMiddleBtn() {
        self.addSubview(middleButton)
        
        middleButton.frame = CGRect(x: (self.bounds.width / 2)-(80 / 2), y: -40, width: 80, height: 80)
        middleButton.clipsToBounds = true
        middleButton.layer.cornerRadius = middleButton.frame.width / 2
        middleButton.addTarget(self, action: #selector(middleBtnAction), for: .touchUpInside)
    }
    
    @objc func middleBtnAction() {
        middleBtnActionHandler()
        print("tapped")
    }
    
    // middleButton 전역 touch 활성화
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
      guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }

      return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
    }
    
    // 곡선 TabBar
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor(hex: "202632").cgColor
        shapeLayer.lineWidth = 0

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
        self.setupMiddleBtn()
        }
    
    private func createPath() -> CGPath {
        let f = CGFloat(80 / 2.0) + 5
        let h = frame.height
        let w = frame.width
        let halfW = frame.width/2.0
        let r = CGFloat(10)
        let path = UIBezierPath()
        path.move(to: .zero)
        
        path.addLine(to: CGPoint(x: halfW-f-(r/2.0), y: 0))
        
        path.addArc(withCenter: CGPoint(x: halfW , y: (r/2.0) - 5), radius: f , startAngle: .pi, endAngle: 0, clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0.0, y: h))
        
        return path.cgPath
    }
    
}

