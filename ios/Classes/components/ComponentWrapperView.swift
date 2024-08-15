@_spi(AdyenInternal)
import Adyen
import Flutter
import UIKit

class ComponentWrapperView: UIStackView {
    
    // MARK: - Properties
    
    private let cardComponent: CardComponent
    private let onLayoutSubviews: () -> Void
    
    // MARK: - View elements
    
    private lazy var submitButton: SubmitButton = {
        let submitButton = SubmitButton(style: cardComponent.configuration.style.mainButtonItem.button)
        submitButton.backgroundColor = .blue
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.title = "PAY"
        submitButton.layer.cornerRadius = 8
        return submitButton
    }()
    
    // MARK: - Initializers
    
    init(cardComponent: CardComponent, 
         onLayoutSubviews: @escaping () -> Void) {
        self.cardComponent = cardComponent
        self.onLayoutSubviews = onLayoutSubviews
        super.init(frame: .zero)
        
        axis = .vertical
        setup()
    }
    
    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        onLayoutSubviews()
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
           return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    // MARK: - Private
    
    private func setup() {
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        [cardView,
         submitButton
         ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            submitButton.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private var cardView: UIView {
        cardComponent.viewController.view
    }
    
    @objc func submit() {
        cardComponent.submit()
    }
}
