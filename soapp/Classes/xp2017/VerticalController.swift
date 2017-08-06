//
//  VerticalController.swift
//  XPApp
//
//  Created by zhuxietong on 2017/3/21.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import Foundation
import JoLoading
import Eelay
//import soapp
open class VerticalKit: JoView {
    
    var contentView = UIView()
    required public init(frame: CGRect) {
        super.init(frame: frame)
        self.eelay = [
            [contentView,[ee.T.L.B.R]],
        ]
        addLayoutRules()
    }
    
    required public init()
    {
        super.init(frame: CGRect.zero)
        self.eelay = [
            [contentView,[ee.T.L.B.R]],
        ]
        addLayoutRules()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.eelay = [
            [contentView,[ee.T.L.B.R]],
        ]
        addLayoutRules()
    }
    
}

open class VerticalController:TypeInitController,LoadingPresenter
{
    public let stackView = UIStackView()
    
    public let scrollView = UIScrollView()
    
    open func buildView() {
        jo_contentView.eelay = [
            [scrollView,[ee.T.L.B.R]],
        ]
        
        scrollView.eelay = [
            [stackView,[ee.T.L.B.R,[0,0,0,0]],Int(Swidth)],
        ]
        
        stackView.axis = .vertical
        stackView.spacing = 13
        jo_contentView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true

    }
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    
}
