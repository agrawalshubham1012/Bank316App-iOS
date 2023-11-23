

import Foundation
import UIKit

extension UITableView {
    
    func safeScroll(indexPath:IndexPath,position:UITableView.ScrollPosition,animated:Bool) {
        
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        guard section >= 0,row >= 0 else {
            return
        }
        guard indexPath.section <= section,indexPath.row < self.numberOfRows(inSection: indexPath.section) else {
            return
        }
        self.scrollToRow(at: indexPath, at: position, animated: animated)
    }
    
    func safeReloadAtIndexPath(arrRows:[IndexPath],animation: UITableView.RowAnimation) {
        var arrSafeRows : [IndexPath] = []
        for indexPath in arrRows {
            let section = self.numberOfSections - 1
            let row = self.numberOfRows(inSection: section) - 1
            if section >= 0,row >= 0,indexPath.section <= section,indexPath.row < self.numberOfRows(inSection: indexPath.section) {
                arrSafeRows.append(indexPath)
            }
        }
        self.beginUpdates()
        self.reloadRows(at: arrSafeRows, with: animation)
        self.endUpdates()
    }
    
    
    func scrollToBottom(animated:Bool = true) {
        let section = self.numberOfSections - 1
        let row = self.numberOfRows(inSection: section) - 1
        self.safeScroll(indexPath: IndexPath(row: row, section: section), position: .bottom, animated: animated)
    }
    
    func scrollToTop(animated:Bool = true) {
        self.safeScroll(indexPath: IndexPath(row: 0, section: 0), position: .top, animated: animated)
    }
    
}

extension UIScrollView {
    
    func scrollToBottomScroll(animated:Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollToTopScroll(animated:Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: 0)
        self.setContentOffset(bottomOffset, animated: animated)
    }
}


class ContentSizedTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}

class ContentSizedCollectionView: UICollectionView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
