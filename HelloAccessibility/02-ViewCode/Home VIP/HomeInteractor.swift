//
//  HomeInteractor.swift
//  HelloAccessibility
//
//  Created by rafael.guimaraes on 20/04/23.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues()
    func screenShot()
}

protocol HomeDataStore {
    // var name: String { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: HomePresentationLogic?
    let worker: HomeWorkerLogic
    
    // MARK: - DataStore Objects
    
    // var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: HomeWorkerLogic = HomeWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
    
    func screenShot() {
        presenter?.screenShot()
    }
}
