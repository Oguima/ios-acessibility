//
//  HomePresenter.swift
//  HelloAccessibility
//
//  Created by rafael.guimaraes on 20/04/23.
//

import UIKit

protocol HomePresentationLogic {
    func presentScreenValues()
    func screenShot()
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Home.Model.ViewModel(value: 10)
        viewController?.displayScreenValues(viewModel: viewModel)
    }
    
    func screenShot() {
        let _ = viewController?.shareReceipt()
    }
}
