//
//  Created by Marek Niedbach on 03.09.2017.
//  Copyright © 2017 Marek Niedbach. All rights reserved.
//

import UIKit

class DiceBoardViewController: UIViewController {
    private var diceBoardView: DiceBoardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dice Puzzle"
        view.backgroundColor = .white
        loadDiceBoardView()
    }

    private func loadDiceBoardView() {
        diceBoardView = DiceBoardView(board: DiceBoard())
        view.addSubview(diceBoardView)
        diceBoardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            diceBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            diceBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            diceBoardView.widthAnchor.constraint(equalTo: diceBoardView.heightAnchor),
            diceBoardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
