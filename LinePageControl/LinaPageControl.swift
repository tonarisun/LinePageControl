//
//  Copyright © 2014-2020 Reactive Reality. All rights reserved.
//

import UIKit

class LinePageControl: UIView {
    let pagesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()
    let currentPageIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    var leftConstraint: NSLayoutConstraint?

    var itemsCount: Int = 0 {
        didSet {
            guard itemsCount > 0 else { return }
            configurePages()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(pagesView)
        pagesView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        pagesView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 82).isActive = true
        pagesView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -82).isActive = true
        pagesView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    private func configurePages() {
        
        pagesView.addSubview(currentPageIndicator)
        leftConstraint = NSLayoutConstraint(item: currentPageIndicator,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: pagesView,
                                            attribute: .left,
                                            multiplier: 1,
                                            constant: 0)
        leftConstraint?.isActive = true
        currentPageIndicator.heightAnchor.constraint(equalTo: pagesView.heightAnchor).isActive = true
        currentPageIndicator.widthAnchor.constraint(equalTo: pagesView.widthAnchor, multiplier: 1/Double(itemsCount)).isActive = true
    }

    func setOffset(percent: Double) {
        let offset = pagesView.bounds.width * (percent / 100.0)
        guard offset > 0, offset < pagesView.bounds.width - currentPageIndicator.bounds.width else { return }
        leftConstraint?.constant = offset
    }
}
