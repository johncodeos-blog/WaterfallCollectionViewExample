//
//  CollectionView.swift
//  WaterfallCollectionView
//
//  Created by John Codeos on 10/10/2019.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit


class CollectionView: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var itemsArray = [ItemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionViewNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: "collectionviewcellid")

        loadData()

        // CollectionView Layout Setup
        setupCollectionViewLayout()
    }


    func loadData() {
        for _ in 0...80 {
            itemsArray.append(ItemModel(color: getRandomColor(), width: getRandomNumber(), height: getRandomNumber()))
        }
        self.collectionView.reloadData()
    }

    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    func getRandomNumber() -> Int {
        return Int.random(in: 250..<500)
    }

    func setupCollectionViewLayout() {

        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()

        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 3.0
        layout.minimumInteritemSpacing = 3.0

        // Set the waterfall layout to your collection view
        self.collectionView.collectionViewLayout = layout
    }

}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as! CollectionViewCell
        cell.imageView.backgroundColor = itemsArray[indexPath.row].color
        return cell
    }

}

extension CollectionView: CHTCollectionViewDelegateWaterfallLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsArray[indexPath.row].width, height: itemsArray[indexPath.row].height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
        return 2
    }

}
