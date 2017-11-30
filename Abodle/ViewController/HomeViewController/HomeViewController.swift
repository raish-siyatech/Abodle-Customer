//
//  HomeViewController.swift
//  Abodle
//
//  Created by mac on 29/11/17.
//  Copyright © 2017 Siyatech Ventures. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: OUTLET
    
    @IBOutlet weak var tabView: UIView!
    
    
    //MARK: Properties
    
    @IBOutlet weak var buttonBuy: UIButton!
    @IBOutlet weak var buttonRent: UIButton!
    let blueColor = #colorLiteral(red: 0, green: 0.6633186936, blue: 0.7102137208, alpha: 1)
    let whiteColor = #colorLiteral(red: 0.5556249619, green: 0.5556384325, blue: 0.5556312203, alpha: 1)
    
    var pageViewController = UIPageViewController()
    
    private(set) lazy var arrViewController:[UIViewController] = {
        
        return [self.newViewController(firstName:"Buy"),
                self.newViewController(firstName:"Rent")]
    }()
    
    
    private func newViewController(firstName:String) -> UIViewController {
        
        return UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "\(firstName)ViewController")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    
        tabView.installShadow()
        configurePageViewController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Button Action
    @IBAction func buttonBuyTapped(_ sender: Any) {
        
        moveToLeft()
        guard let childViewController:UIViewController = self.arrViewController[0] as UIViewController? else {
            return
        }
        self.pageViewController.setViewControllers([childViewController], direction: .reverse, animated: true) { (complete:Bool) in
        }
        
    }
    
    
    @IBAction func buttonRentTapped(_ sender: Any) {
        
        moveToRight()
        guard let childViewController:UIViewController = self.arrViewController[1] as UIViewController? else {
            return
        }
        self.pageViewController.setViewControllers([childViewController], direction: .forward, animated: true) { (complete:Bool) in
            
        }
        
    }
    
    
//    @IBAction func buttonBuyTapped(_ sender: UIButton) {
//        
//        guard let childViewController:UIViewController = self.arrViewController[0]! as UIViewController? else {
//            return
//        }
//        
//        self.pageViewController.setViewControllers([childViewController], direction: .reverse, animated: true) { (complete:Bool) in
//        }
//        
//    }
//    
//    @IBAction func buttonRentTapped(_ sender: UIButton) {
//        
//        guard let childViewController:UIViewController = self.arrViewController[1]! as UIViewController? else {
//            return
//        }
//        self.pageViewController.setViewControllers([childViewController], direction: .forward, animated: true) { (complete:Bool) in
//        }
//    }
    
    
    // MARK: HELPER METHODS
    func moveToRight() {
        
        self.buttonBuy.titleLabel?.textColor = whiteColor
        self.buttonRent.titleLabel?.textColor = blueColor
    }
    
    
    func moveToLeft() {
        
        self.buttonBuy.titleLabel?.textColor = blueColor
        self.buttonRent.titleLabel?.textColor = whiteColor
    }
    
    
}

//MARK:  UIPageViewControllerDataSource
extension HomeViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: Helper Method
    func configurePageViewController() {
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        let initialContentViewcontroller = self.arrViewController.first
        
        self.pageViewController.setViewControllers([initialContentViewcontroller!], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRect(x: 20, y: 135, width: view.frame.size.width - 40, height: view.frame.size.height)
        
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        
    }
    
    
    // MARK :- UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = arrViewController.index(of: viewController) else {
            
            moveToLeft()
            return nil
            
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            
            moveToLeft()
            return nil
            
        }
        
        guard arrViewController.count > previousIndex else {
            
            moveToLeft()
            return nil
            
        }
        moveToLeft()
        return arrViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = arrViewController.index(of: viewController) else {
            
            moveToRight()
            return nil
            
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = arrViewController.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            
            moveToRight()
            return nil
            
        }
        
        guard orderedViewControllersCount > nextIndex else {
            
            moveToRight()
            return nil
            
        }
        moveToRight()
        return arrViewController[nextIndex]
    }
    
}





//extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        if viewController is BuyViewController {
//            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuyViewController") as! BuyViewController
//            return vc
//        }
//        return nil
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        if viewController is RentViewController {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RentViewController") as! RentViewController
//            return vc
//        }
//        
//        return nil
//    }
//    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        
//        return arrViewController.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        
//        return 0
//    }
//    
//    func configurePageViewController() {
//        
//        self.pageViewController.dataSource = self
//        self.pageViewController.delegate = self
//        
//        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
//        
//        pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        pageViewController.view.frame = CGRect(x: 0, y: 65, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        
//        if let firstViewController = arrViewController[0] {
//            pageViewController.setViewControllers([firstViewController],
//                                                  direction:.forward,
//                                                  animated:true,
//                                                  completion:nil)
//        }
//        
//        addChildViewController(pageViewController)
//        self.view.addSubview(pageViewController.view)
//        pageViewController.didMove(toParentViewController: self)
//    }
//}
