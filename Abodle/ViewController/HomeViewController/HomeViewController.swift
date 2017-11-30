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
    
    var pageViewController = UIPageViewController()
    
    private(set) lazy var arrViewController:[UIViewController?] = {
        
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
    
    @IBAction func buttonBuyTapped(_ sender: UIButton) {
        
        guard let childViewController:UIViewController = self.arrViewController[0]! as UIViewController? else {
            return
        }
        
        self.pageViewController.setViewControllers([childViewController], direction: .reverse, animated: true) { (complete:Bool) in
        }
        
    }
    
    @IBAction func buttonRentTapped(_ sender: UIButton) {
        
        guard let childViewController:UIViewController = self.arrViewController[1]! as UIViewController? else {
            return
        }
        self.pageViewController.setViewControllers([childViewController], direction: .forward, animated: true) { (complete:Bool) in
        }
    }
}

//MARK:  UIPageViewControllerDataSource

extension HomeViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController is BuyViewController {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuyViewController") as! BuyViewController
            return vc
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController is RentViewController {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RentViewController") as! RentViewController
            return vc
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return arrViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    func configurePageViewController() {
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        
        pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = CGRect(x: 0, y: 65, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        if let firstViewController = arrViewController[0] {
            pageViewController.setViewControllers([firstViewController],
                                                  direction:.forward,
                                                  animated:true,
                                                  completion:nil)
        }
        
        addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
}
