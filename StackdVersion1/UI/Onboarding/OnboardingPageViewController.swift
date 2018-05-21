//
//  OnboardingPageViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//
import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 150, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        // self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    func getStepOne() -> Gif1ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "gif1VC") as! Gif1ViewController
    }
    
    func getStepTwo() -> Gif2ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "gif2VC") as! Gif2ViewController
    }
    
    func getStepThree() -> Gif3ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "gif3VC") as! Gif3ViewController
    }
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.getStepOne(), self.getStepTwo(), self.getStepThree()]
    }()
    override func viewDidLoad() {
        dataSource = self
        delegate = self
        // MARK: ???
        setViewControllers([orderedViewControllers[0]], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }
    
    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }
}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // MARK: ???
        
        if viewController is Gif2ViewController {
            // 2 -> 1
            return orderedViewControllers[0]  // getStepOne() // <- Shouldn't make new one!
        } else if viewController is Gif3ViewController {
            // 3 -> 2
            return orderedViewControllers[1]
        } else{
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is Gif1ViewController {
            // 1 -> 2
            return orderedViewControllers[1]
        } else if viewController is Gif2ViewController {
            // 2 -> 3
            return orderedViewControllers[2]
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // MARK: ????
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPageViewController: UIPageViewControllerDelegate {}


