//
//  HeroesDelegateFlowLayout.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 23/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class HeroesDelegate : NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let margin: CGFloat
    let spacing: CGFloat
    private let heroSelected: (_ row: Int) -> Void
    private let loadMoreHeroes: () -> Void
    
    required init(onHeroSelection: @escaping (Int) -> Void,
                  onLoadMoreHeroes: @escaping () -> Void,
                  margin: CGFloat = 8.0,
                  spacing: CGFloat = 10.0) {
        self.margin = margin
        self.spacing = spacing
        heroSelected = onHeroSelection
        loadMoreHeroes = onLoadMoreHeroes
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        heroSelected(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        
        if maximumOffset - currentOffset <= 10.0 {
            loadMoreHeroes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellPerRow = CGFloat(2)
        let availableSpace = collectionView.bounds.size.width - (2 * margin) - (numberOfCellPerRow * spacing)
        
        let cellWith = availableSpace / numberOfCellPerRow
        let cellAspectRatio = CGFloat(1.5)
        
        let height = cellAspectRatio * cellWith
        return CGSize(width: cellWith, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: margin,
                                 left: margin,
                                 bottom: margin,
                                 right: margin)
    }
}
