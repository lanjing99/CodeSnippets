//
//  *@项目名称:  UICollectionViewFlowlayout
//  *@文件名称:  UICollectionViewHorizontalFlowLayout.swift
//  *@Date 2018/11/26
//  *@Author lanjing 
//

import UIKit

class UICollectionViewHorizontalFlowLayout: UICollectionViewLayout {
    
    public var lineSpacing: CGFloat = 0
    public var interItemSpace: CGFloat = 0
    public var contentInset: UIEdgeInsets = UIEdgeInsets.zero
    public var itemSize: CGSize = CGSize.zero
    
    fileprivate var sections: Int = 0
    fileprivate var maxItemNumberInSections: Int = 0
    
    
    override func invalidateLayout() {
//       prepare()
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView, let dataSource = collectionView.dataSource,
            let numberOfSections = dataSource.numberOfSections?(in: collectionView) else{
                return
        }
        
        sections = numberOfSections
        maxItemNumberInSections = (0..<sections).reduce(0) { (max, section) -> Int in
            let itemsCount = collectionView.numberOfItems(inSection: section)
            if itemsCount > max {
                return itemsCount
            }else{
                return max
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
//        return CGSize.init(width: 100, height: 100)
        return contentSize()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in 0..<sections {
            for item in 0..<collectionView!.numberOfItems(inSection: section){
                if let attribute = layoutAttributesForItem(at: IndexPath.init(item: item, section: section)){
                    attributes.append(attribute)
                }
            }
        }
        
        return attributes
        
//        (0..<sections).reduce([UICollectionViewLayoutAttributes]()) { (result, section) -> [UICollectionViewLayoutAttributes] in
//            let itemsCount = collectionView!.numberOfItems(inSection: section)
//            (0..<itemsCount).reduce(result, { (result, item) -> [UICollectionViewLayoutAttributes] in
//                result.append(layoutAttributesForItem(at: IndexPath.init(item: item, section: section)))
//            })
//        }
        
        
    }
    
    
    private func contentSize() -> CGSize{
//        guard  sections > 0, maxItemNumberInSections > 0 else{
//           return CGSize.zero
//        }
//
//        var contentSize = CGSize.zero
//        contentSize.width += contentInset.left + contentInset.right
//        contentSize.width += itemSize.width + CGFloat((maxItemNumberInSections - 1)) * (itemSize.width + interItemSpace)
//
//        contentSize.height += contentInset.top + contentInset.bottom
//        contentSize.height += itemSize.height + CGFloat(sections) * (itemSize.height + lineSpacing)
//
//        return contentSize
    
        return UICollectionViewHorizontalFlowLayout.contentSize(itemSize: itemSize, contentInset: contentInset, lineSpacing: lineSpacing, interItemSpace: interItemSpace, sections: sections, maxItemNumberInSections: maxItemNumberInSections)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var xOffset = contentInset.top, yOffset = contentInset.left
        xOffset += (itemSize.width +  interItemSpace) * CGFloat(indexPath.row)
        yOffset += (itemSize.height + lineSpacing) * CGFloat(indexPath.section)
        let attribute = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attribute.frame = CGRect.init(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height)
        return attribute
    }
    
    static func contentSize(itemSize: CGSize = CGSize.zero,
                            contentInset: UIEdgeInsets,
                            lineSpacing: CGFloat,
                            interItemSpace: CGFloat,
                            sections: Int,
                            maxItemNumberInSections: Int) -> CGSize{
        
        guard  sections > 0, maxItemNumberInSections > 0 else{
            return CGSize.zero
        }
        
        var contentSize = CGSize.zero
        contentSize.width += contentInset.left + contentInset.right
        contentSize.width += itemSize.width + CGFloat((maxItemNumberInSections - 1)) * (itemSize.width + interItemSpace)
        
        contentSize.height += contentInset.top + contentInset.bottom
        contentSize.height += itemSize.height + CGFloat(sections) * (itemSize.height + lineSpacing)
        
        return contentSize
        
    }
}
