//
//  *@项目名称:  UICollectionViewFlowlayout
//  *@文件名称:  ViewController.swift
//  *@Date 2018/11/26
//  *@Author lanjing 
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
}

class ViewController: UIViewController {
    
    let data = [["abc", "DFD"], ["124", "456", "789", "245", "124"]]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let layout = UICollectionViewHorizontalFlowLayout.init()
        layout.itemSize = CGSize.init(width: 150, height: 50)
        layout.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        layout.lineSpacing = 13
        layout.interItemSpace = 11
        collectionView.setCollectionViewLayout(layout, animated: true, completion: nil)
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if indexPath.section == 0{
            cell.backgroundColor = UIColor.blue
        }else{
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
}

