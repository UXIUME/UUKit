//
//  UUScrollablesViewProtocol.swift
//  UUScrollablesViewProtocol
//
//  Created by uxiu.me on 2018/8/17.
//  Copyright © 2018年 uxiu.me. All rights reserved.
//

import UIKit

public protocol UUScrollableProtocol: NSObjectProtocol {}
extension UITableView: UUScrollableProtocol {}
extension UICollectionView: UUScrollableProtocol {}

public  protocol UUScrollablesViewProtocol: NSObjectProtocol {}
extension UITableViewCell: UUScrollablesViewProtocol {}
extension UICollectionReusableView: UUScrollablesViewProtocol {}
extension UITableViewHeaderFooterView: UUScrollablesViewProtocol {}

//avable above tag '0.1.1'
public enum UUReuseMode: Int {
    case `default` = 0
    case indexPath = 1
    case section = 2
    case row = 3
}

extension UUScrollablesViewProtocol {
    
    private static var selfName: String {
        return "\(self)"
    }
    
    private static var isNibExist: Bool {
        return Bundle.main.path(forResource: selfName, ofType: "nib") == nil ? false : true
    }
    
    private static var instance: Self? {
        return Bundle.main.loadNibNamed(selfName, owner: self, options: nil)?.last as? Self
    }
    
    private static var nib: UINib? {
        return isNibExist ? UINib(nibName: selfName, bundle: nil) : nil
    }
    
    private static func identifier(isForTableView: Bool, at indexPath: IndexPath, reuseBy reuseMode: UUReuseMode = .indexPath) -> String {
        var section: String = "_Section" + String(format: "%03ld", indexPath.section)
        var index: String = (isForTableView ? "_Row" : "_Item") + String(format: "%03ld", isForTableView ? indexPath.row : indexPath.item)
        switch reuseMode {
        case .indexPath:
            break
        case .section:
            index = ""
        case .row:
            section = ""
        case .default:
            section = ""
            index = ""
        }
        return selfName + section + index
    }
    
    private static func register(in container: UUScrollableProtocol, with reuseIdentifier: String) {
        let isTableView = container is UITableView
        isNibExist ?
            { isTableView ?
                (container as! UITableView).register(nib, forCellReuseIdentifier: reuseIdentifier) :
                (container as! UICollectionView).register(nib, forCellWithReuseIdentifier: reuseIdentifier) }() :
            { isTableView ?
                (container as! UITableView).register(self , forCellReuseIdentifier: reuseIdentifier) :
                (container as! UICollectionView).register(self , forCellWithReuseIdentifier: reuseIdentifier) }()
    }
    
}

extension UUScrollablesViewProtocol where Self: UITableViewHeaderFooterView {
    
    public static func newAlways() -> Self {
        return isNibExist ? instance! : Self(reuseIdentifier: selfName)
    }
    
    public static func setup(in tableView: UITableView, at section: Int, reuseBy reuseMode: UUReuseMode = .default) -> Self {
        var mode: UUReuseMode = .default
        if reuseMode == .indexPath || reuseMode == .section {
            mode = .section
        } else {
            mode = .default
        }
        let reuseIdentifier = identifier(isForTableView: true, at: IndexPath(row: 0, section: section), reuseBy: mode)
        isNibExist ?
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier) :
            tableView.register(self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! Self
    }
    
}

extension UUScrollablesViewProtocol where Self: UITableViewCell {
    
    public static func newAlways(_ cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        return isNibExist ? instance! : Self(style: cellStyle, reuseIdentifier: selfName)
    }
    
    public static func setup(in tableView: UITableView, reuseIdentifier: String) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? Self else {
            return isNibExist ? instance! : Self(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell
    }
    
    public static func setup(in tableView: UITableView, cellStyle: UITableViewCell.CellStyle = .default) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: selfName) as? Self else {
            return newAlways(cellStyle)
        }
        return cell
    }
    
    public static func setup(in tableView: UITableView, at indexPath: IndexPath, reuseBy reuseMode: UUReuseMode = .indexPath) -> Self {
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseBy: reuseMode)
        register(in: tableView, with: reuseIdentifier)
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

extension UUScrollablesViewProtocol where Self: UICollectionReusableView {
    
    private static var randomIndexPath: IndexPath {
        return IndexPath(item: Int(arc4random() / 2 + arc4random() / 3), section: Int(arc4random() / 2 + arc4random() / 3))
    }
    
    public static func newAlways(_ viewKind: String, in collectionView: UICollectionView) -> Self {
        return setup(viewKind, in: collectionView, at: randomIndexPath, reuseBy: .section)
    }
    
    public static func setup(_ viewKind: String, in collectionView: UICollectionView, at indexPath: IndexPath, reuseBy reuseMode: UUReuseMode = .default) -> Self {
        var mode: UUReuseMode = .default
        if reuseMode == .indexPath || reuseMode == .section {
            mode = .section
        } else {
            mode = .default
        }
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseBy: mode)
        isNibExist ?
            collectionView.register(nib, forSupplementaryViewOfKind: viewKind, withReuseIdentifier: reuseIdentifier) :
            collectionView.register(self, forSupplementaryViewOfKind: viewKind, withReuseIdentifier: reuseIdentifier)
        return collectionView.dequeueReusableSupplementaryView(ofKind: viewKind, withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}

extension UUScrollablesViewProtocol where Self: UICollectionViewCell {
    
    public static func newAlways(in collectionView: UICollectionView) -> Self {
        return setup(in: collectionView, at: randomIndexPath, reuseBy: .indexPath)
    }
    
    public static func setup(in collectionView: UICollectionView, at indexPath: IndexPath, reuseBy reuseMode: UUReuseMode = .indexPath) -> Self {
        let reuseIdentifier = identifier(isForTableView: false, at: indexPath, reuseBy: reuseMode)
        register(in: collectionView, with: reuseIdentifier)
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Self
    }
    
}




