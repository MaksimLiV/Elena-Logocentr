//
//  SelfSizingCollectionView.swift
//  Elena Logocentr
//
//  Created by Maksim Li on 01/01/2026.
//

import UIKit

class SelfSizingCollectionView: UICollectionView {
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
