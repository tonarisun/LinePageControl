//
//  Copyright © 2014-2020 Reactive Reality. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: LinePageControl!

    var totalContentWidth: Double = 0
    var items: [UIColor] = {
        var arr = [UIColor]()
        for i in 0...5 {
            arr.append(UIColor(
                red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                alpha: 1
            ))
        }
        return arr
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        totalContentWidth = UIScreen.main.bounds.width * Double(items.count)
        pageControl.itemsCount = items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCollectionViewCell", for: indexPath) as? ColorCollectionViewCell {
            cell.contentView.backgroundColor = items[indexPath.item]
            cell.numberLabel.text = "\(indexPath.item)"
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percents = scrollView.contentOffset.x * 100.0 / totalContentWidth
        pageControl.setOffset(percent: percents)
    }
}

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet var numberLabel: UILabel!
}
