//
//  UUScrollableSubviewProtocol.swift
//  UUScrollableSubviewProtocol
//
//  Created by uxiu.me on 2018/8/17.
//  Copyright © 2018年 uxiu.me. All rights reserved.
//

import UIKit

public protocol UUScrollableViewProtocol: NSObjectProtocol {}
extension UITableView: UUScrollableViewProtocol {}
extension UICollectionView: UUScrollableViewProtocol {}

public protocol UUScrollableSubviewProtocol: NSObjectProtocol {}
extension UITableViewCell: UUScrollableSubviewProtocol {}
extension UICollectionReusableView: UUScrollableSubviewProtocol {}
extension UITableViewHeaderFooterView: UUScrollableSubviewProtocol {}

public enum UUScrollableSubviewReuseMode: Int {
    case indexPath = 0
    case section = 1
    case item = 3
    case row = 2
}

public enum UUScrollableSubviewType: Int {
    case header = 0
    case cell = 1
    case footer = 2
}

extension UUScrollableSubviewProtocol {
    
    private static var className: String {
        return "\(self)"
    }
    
    private static var isNibExist: Bool {
        return Bundle.main.path(forResource: className, ofType: "nib") == nil ? false : true
    }
    
    private static var nibInstance: Self? {
        return Bundle.main.loadNibNamed(className, owner: self, options: nil)?.last as? Self
    }
    
    private static var nib: UINib? {
        return isNibExist ? UINib(nibName: className, bundle: nil) : nil
    }
    
    private static func identifier(isForTableView: Bool, at indexPath: IndexPath, reuseby reuseMode: UUScrollableSubviewReuseMode = .indexPath) -> String {
        var section: String = "_Section" + String(format: "%03ld", indexPath.section)
        var index: String = (isForTableView ? "_Row" : "_Item") + String(format: "%03ld", isForTableView ? indexPath.row : indexPath.item)
        switch reuseMode {
        case .indexPath:
            break
        case .section:
            index = ""
        case .item:
            section = ""
        case .row:
            section = ""
        }
        return className + section + index
    }
    
    private static func register(_ viewKind: UUScrollableSubviewType, for container: UUScrollableViewProtocol, with reuseIdentifier: String) {
        if let tableView = container as? UITableView {
            switch viewKind {
            case .cell:
                isNibExist ? 
                    tableView.register(nib, forCellReuseIdentifier: reuseIdentifier) :
                    tableView.register(self , forCellReuseIdentifier: reuseIdentifier)
            default :
                isNibExist ?
                    tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier) :
                    tableView.register(self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            }
            return
        }
        if let collectionView = container as? UICollectionView {
            switch viewKind {
            case .header:
                isNibExist ?
                    collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier) :
                    collectionView.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
            case .cell:
                isNibExist ? 
                    collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier) :
                    collectionView.register(self , forCellWithReuseIdentifier: reuseIdentifier)
            case .footer:
                isNibExist ?
                    collectionView.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier) :
                    collectionView.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier)
            }
            return
        }
    }
    
}

extension UUScrollableSubviewProtocol where Self: UITableViewHeaderFooterView {
    
    public static func newAlways() -> Self {
        return isNibExist ? nibInstance! : Self(reuseIdentifier: className)
    }
    
    public static func setup(in tableView: UITableView, at section: Int, reuseable: Bool = true) -> Self {
        if reuseable {
            let reuseIdentifier = identifier(isForTableView: true, at: IndexPath(row: 0, section: section), reuseby: .section)
            register(.header, for: tableView, with: reuseIdentifier)
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! Self
        }
        return newAlways()
    }
    
}

extension UUScrollableSubviewProtocol where Self: UITableViewCell {
    
    public static func newAlways(_ cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        return isNibExist ? nibInstance! : Self(style: cellStyle, reuseIdentifier: className)
    }
    
    public static func setup(in tableView: UITableView, reuseIdentifier: String) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? Self else {
            return isNibExist ? nibInstance! : Self(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell
    }
    
    public static func setup(in tableView: UITableView, cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: className) as? Self else {
            return newAlways(cellStyle)
        }
        return cell
    }
    
    public static func setup(in tableView: UITableView, at indexPath: IndexPath, reuseBy reuseMode: UUScrollableSubviewReuseMode = .indexPath) -> Self {
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseby: reuseMode)
        register(.cell, for: tableView, with: reuseIdentifier)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

extension UUScrollableSubviewProtocol where Self: UICollectionReusableView {
    
    private static var randomIndexPath: IndexPath {
        return IndexPath(item: Int(arc4random() / 2 + arc4random() / 3), section: Int(arc4random() / 2 + arc4random() / 3))
    }
    
    fileprivate static func setup(_ viewKind: UUScrollableSubviewType, in collectionView: UICollectionView, at indexPath: IndexPath, reuseby reuseMode: UUScrollableSubviewReuseMode) -> Self {
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseby: reuseMode)
        register(viewKind, for: collectionView, with: reuseIdentifier)
        switch viewKind {
        case .header:
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
        case .cell:
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
        case .footer:
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
        }
    }
    
    public static func newAlways(_ sectionViewKind: UUScrollableSubviewType, in collectionView: UICollectionView) -> Self {
        return setup(sectionViewKind, in: collectionView, at: randomIndexPath, reuseby: .indexPath)
    }
    
    public static func setup(_ sectionViewKind: UUScrollableSubviewType, in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        return setup(sectionViewKind, in: collectionView, at: indexPath, reuseby: .section)
    }
    
}

extension UUScrollableSubviewProtocol where Self: UICollectionViewCell {
    
    public static func newAlways(in collectionView: UICollectionView) -> Self {
        return setup(in: collectionView, at: randomIndexPath, reuseby: .indexPath)
    }
    
    public static func setup(in collectionView: UICollectionView, at indexPath: IndexPath, reuseby reuseMode: UUScrollableSubviewReuseMode = .indexPath) -> Self {
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseby: reuseMode)
        register(.cell, for: collectionView, with: reuseIdentifier)
        return setup(.cell, in: collectionView, at: indexPath, reuseby: reuseMode)
    }
    
}




