//
//  ApresentationScreen.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 02/03/23.
//
//MARK: Aqui posso fazer todo o resto da tela.

import UIKit

class CustomView: UIView {
    
    var imagesBackground = ["image1", "image2", "image3"]
    var orangeColors: OrangeColors = .lightOrange
    var backgroundView = [ContentView(),ContentView(), ContentView()]
    var titleTexts = ["Uma nova forma","Sinta a emoção", "Através da conversa"]
    var subtitleTexts = ["Compartilhe momentos, conquistas, lembranças, experimente o diferente","Novas formas de conversar, novas formas de criar conexões", "Com um simples gesto, acabamos com a diferença de distância na palma de nossa mão."]
    var scrollView = UIScrollView()
    var pageControl = UIPageControl()
    
    weak var delegate: UIScrollViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupPageControl()
        addViewToScroll()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setupPageControl()
        addViewToScroll()
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        addSubview(pageControl)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            // Isso é da View, referente a View, ou seja se eu predeterminar uma altura da View ele tem que ter aquela determinada altura e ajustar-se dentro daquele espaço
        ])
    }
    
    func setupPageControl(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = backgroundView.count
        pageControl.currentPage = 0
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = OrangeColors.textColor.color
        pageControl.currentPageIndicatorTintColor = .white
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addViewToScroll() {
        
        for i in 0..<backgroundView.count {
            let contentView = backgroundView[i]
            contentView.ivCircle.image = UIImage(named: imagesBackground[i])
            contentView.lbPresentation.text = titleTexts[i]
            contentView.lbSubPresentation.text = subtitleTexts[i]
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            if i == 0 {
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            } else {
                contentView.leadingAnchor.constraint(equalTo: backgroundView[i - 1].trailingAnchor).isActive = true
            }
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            
            if i == backgroundView.count - 1 {
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            }
        }
    }
    
}

extension CustomView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.x != 0, scrollView.frame.size.width != 0 else {
               return
           }
           let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
           pageControl.currentPage = Int(pageNumber)
    }
}
