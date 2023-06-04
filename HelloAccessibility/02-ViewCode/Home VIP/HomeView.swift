//
//  HomeView.swift
//  HelloAccessibility
//
//  Created by rafael.guimaraes on 20/04/23.
//

import Foundation
import UIKit

final class HomeView: UIView, CodeView {
    
    private lazy var lblValue: UILabel = {
        let label = UILabel()
        label.text = "Valor: nenhum"
        //MARK: - Evitar cores específicas, a não ser que esteja atrelado a um token de design system, que trate Modo Claro e Escuro, e demais variações possíveis.
        //label.textColor = .white
        label.textAlignment = .center
        
        //MARK: Fonte Normal - Tende a ser mais leve, porém perdemos a funcionalidade de texto dinâmico
        //label.font = UIFont(name: "Helvetica", size: 40)
        
        //MARK: Fonte dinâmica - exemplo do uso - Se usada em excesso, pode comprometer a performance.
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: alguns elementos base já são padrão acessíveis.
        //label.isAccessibilityElement = true
        
        //MARK: Validar forma 01 - Forma mais "completa", componente a componente, está em desuso ultimamente. pois a maioria dos componentes já possuem definições padrões.
        /*label.accessibilityLabel = "Valor"
        label.accessibilityValue = "nenhum"
        label.accessibilityTraits = .staticText
        label.accessibilityHint = "Reais"
         */
        
        //MARK: Validar forma 02 - CLEAN: Forma mais utilizada, apenas ajustando o aceessibilityLabel
        //label.accessibilityLabel = "Valor, 10 reais"
        label.accessibilityIdentifier = "lblValue"
        
        
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(lblValue)
    }
    
    func setupConstraints() {
        //MARK: Centralizando horizontal e verticalmente
        lblValue.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblValue.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
    
    func setupAccessibility(_ viewModel: Home.Model.ViewModel) {
        lblValue.accessibilityLabel = "Valor, \(viewModel.value) Reais"
    }
    
    func getCurrentView() -> UIView? {
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            return viewController.view
        }
        return nil
    }
    
}

extension HomeView: HomeDisplayLogic {
    func shareReceipt() -> UIImage? {
        // Obtenha o tamanho da view atual
        let view = getCurrentView()
        let viewSize = view?.frame.size ?? CGSize(width: 0, height: 0)
        
        UIGraphicsBeginImageContextWithOptions(viewSize, true, 0.0)
        var img: UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            view?.layer.render(in: context)
            img = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        /*if let screenshot = img {
            let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }*/
        return img
    }
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        lblValue.text = "Valor: \(viewModel.value) R$"
        //MARK: Definindo o valor dinâmico lido da viewModel.
        setupAccessibility(viewModel)
    }
}

