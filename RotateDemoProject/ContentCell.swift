//
//  ContentCell.swift
//  TestSwiftPro
//
//  Created by Hans Hsu on 2020/7/23.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

class ConetentCell : UITableViewCell {
    var allConstraints: [NSLayoutConstraint] = .init()
    let titleLabel: UILabel = .init(frame: .zero)
    let contentLabel: UILabel = .init(frame: .zero)
    var shouldRefreshLayout: Bool = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        contentLabel.text = nil
        allConstraints.removeAll()
    }

    override func updateConstraints() {
        if shouldRefreshLayout {
            shouldRefreshLayout = false
            setupConstraints()
        }
        
        super.updateConstraints()
    }
}

//private - api
private extension ConetentCell {
    func setupViews() {
        contentView.backgroundColor = .lightGray
        
        titleLabel.backgroundColor = .red
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        contentLabel.backgroundColor = .blue
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .white
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)
        setNeedsUpdateConstraints()
    }
}

//private - constraints
private extension ConetentCell {
    func setupConstraints() {
        guard let orientation = UIApplication.shared.keyWindow?.windowScene?.interfaceOrientation else {
                   return
        }
        
        contentView.removeConstraints(allConstraints)
        titleLabel.removeConstraints(allConstraints)
        contentLabel.removeConstraints(allConstraints)
        allConstraints.removeAll()
               
        switch orientation {
        case .portrait , .portraitUpsideDown:
            setupPortraitConstraints()
            break

        case .landscapeLeft , .landscapeRight:
            setupLandscapeConstraints()
            break
        default:
            break
        }
    }
    
    func setupPortraitConstraints() {
        let titleAnchor1 = titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 10)
        titleAnchor1.isActive = true
        let titleAnchor2 = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10)
        titleAnchor2.isActive = true
        let titleAnchor3 = titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant: -10)
        titleAnchor3.isActive = true
        let titleAnchor4 = titleLabel.heightAnchor.constraint(equalToConstant: 30)
        titleAnchor4.isActive = true
        allConstraints.append(contentsOf: [titleAnchor1,titleAnchor2,titleAnchor3,titleAnchor4])
        
        let contentAnchor1 = contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        contentAnchor1.isActive = true
        let contentAnchor2 = contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        contentAnchor2.isActive = true
        let contentAnchor3 = contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        contentAnchor3.isActive = true
        let contentAnchor4 = contentLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        contentAnchor4.priority = UILayoutPriority.init(999)
        contentAnchor4.isActive = true
        let contentAnchor5 = contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -10)
        contentAnchor5.isActive = true
        allConstraints.append(contentsOf: [contentAnchor1,contentAnchor2,contentAnchor3,contentAnchor4,contentAnchor5])
    }
    
    func setupLandscapeConstraints() {
        let titleAnchor1 = titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 10)
        titleAnchor1.isActive = true
        let titleAnchor2 = titleLabel.rightAnchor.constraint(equalTo: contentLabel.leftAnchor , constant: -10)
        titleAnchor2.isActive = true
        let titleAnchor3 = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10)
        titleAnchor3.isActive = true
        let titleAnchor4 = titleLabel.heightAnchor.constraint(equalToConstant: 60)
        titleAnchor4.isActive = true
        allConstraints.append(contentsOf: [titleAnchor1,titleAnchor2,titleAnchor3,titleAnchor4])
        
        let contentAnchor2 = contentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant:  -10)
        contentAnchor2.isActive = true
        let contentAnchor3 = contentLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        contentAnchor3.isActive = true
        let contentAnchor4 = contentLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
        contentAnchor4.isActive = true
        let contentAnchor5 = contentLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        contentAnchor5.priority = UILayoutPriority.init(999)
        contentAnchor5.isActive = true
        let contentAnchor6 = contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -10)
        contentAnchor6.isActive = true
        
        allConstraints.append(contentsOf: [contentAnchor2,contentAnchor3,contentAnchor4,contentAnchor5,contentAnchor6])
    }
}

//observer
extension ConetentCell {
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func rotated() {
        guard let orientation = UIApplication.shared.keyWindow?.windowScene?.interfaceOrientation else {
            return
        }
        
        switch orientation {
        case .portrait , .portraitUpsideDown , .landscapeLeft , .landscapeRight:
            shouldRefreshLayout = true
            break
        default:
            break
        }
        
        if shouldRefreshLayout {
            setNeedsUpdateConstraints()
        }
    }
}

//public api
internal extension ConetentCell {
    func configure(info:ContentInfo) {
        titleLabel.text = info.title
        contentLabel.text = info.content
    }
}
