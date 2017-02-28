//
//  LSPageTitleView.swift
//  LSPDouYuTV
//
//  Created by lishaopeng on 17/2/28.
//  Copyright © 2017年 lishaopeng. All rights reserved.
//

import UIKit

//MARK: - 定义协议
protocol LSPageTitleViewDelegate : class {
    func pageTitleView(titleView: LSPageTitleView, selectedIndex index: Int)
}

//MARK: - 定义常量
fileprivate let kScrollLineH: CGFloat = 2
fileprivate let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class LSPageTitleView: UIView {

    //MARK:--定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex: Int = 0
    weak var delegate : LSPageTitleViewDelegate?
    
    //MARK:--懒加载
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    
   //MARK:-自定义一个构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:-设置UI界面
extension LSPageTitleView{
    fileprivate func setupUI(){
        //1.添加UIScrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //2.添加title对应的Label
        setupTitleLabels()
        
        //3.设置底线和滚动线
        setupBottomMenuAndScrollLine()
    }
    fileprivate func setupTitleLabels(){
        
        //0.确定label的一些frame的值
        let  labelW: CGFloat = frame.width / CGFloat(titles.count)
        let  labelH: CGFloat = frame.height - kScrollLineH
        let  labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //3.设置Label的frame
            let  labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func setupBottomMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH , width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK: - 监听Label的点击
extension LSPageTitleView {
    
    @objc fileprivate func titleLabelClick(tap: UITapGestureRecognizer){
        //1.获取当前label的下标值
        guard let currentLabel = tap.view as? UILabel else {
            return
        }
        //2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理做事情
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}
//MARK:--对外暴露的方法
extension LSPageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTolalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTolalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,
                          kSelectColor.1 - kNormalColor.1,
                          kSelectColor.2 - kNormalColor.2)
        //3.2变化的sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress,
                                        g: kSelectColor.1 - colorDelta.1 * progress,
                                        b: kSelectColor.2 - colorDelta.2 * progress)
        //3.3变化的targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress,
                                        g: kNormalColor.1 + colorDelta.1 * progress,
                                        b: kNormalColor.2 + colorDelta.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
}

