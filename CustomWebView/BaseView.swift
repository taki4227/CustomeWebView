//
//  BaseView.swift
//  CustomWebView
//
//  Created by 滝本直樹 on 2018/10/26.
//  Copyright © 2018年 taki. All rights reserved.
//

import UIKit

/**
 すべての制約を UIView.updateConstraints() で書いた場合、
 updateConstraints()が呼ばれないので、制約を使ったレイアウトであることを明示する
 コードでレイアウトを組む際は、このViewを使うこと
 */
internal final class BaseView: UIView {
    internal override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
}
