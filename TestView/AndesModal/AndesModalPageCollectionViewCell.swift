//
//  AndesModalPageCollectionViewCell.swift
//  TestView
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

class AndesModalPageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headerView: AndesModalPageHeaderView!
    
    public var page: Page! {
        didSet {
            headerView.mode = page.header
            setNeedsLayout()
            layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
