//
//  HomeViewController.swift
//  HelloAccessibility
//
//  Created by rafael.guimaraes on 20/04/23.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Home.Model.ViewModel)
    func shareReceipt() -> UIImage?
}

final class HomeViewController: UIViewController, HomeDisplayLogic {
    
    let screen = HomeView()
    // MARK: - Archtecture Objects
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        self.view = screen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
        
        
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        screen.displayScreenValues(viewModel: viewModel)
        
        interactor?.screenShot()
    }
    
    func shareReceipt() -> UIImage? {
        
        let img = screen.shareReceipt()
        
        if let screenshot = img {
            let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
         }
        
        return img
    }
}
