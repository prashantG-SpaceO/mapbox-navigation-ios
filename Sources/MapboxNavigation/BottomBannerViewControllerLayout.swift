import UIKit

extension BottomBannerViewController {
    
    func setupRootViews() {
        let children = [bottomBannerView, bottomPaddingView]
        view.addSubviews(children)
        setupRootViewConstraints()
    }
    
    func setupRootViewConstraints() {
        let constraints = [
            bottomBannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bottomBannerView.bottomAnchor.constraint(equalTo: bottomPaddingView.topAnchor),
            bottomBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomPaddingView.topAnchor.constraint(equalTo: view.safeBottomAnchor),
            bottomPaddingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomPaddingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPaddingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBottomBanner() {
        let timeRemainingLabel: TimeRemainingLabel = .forAutoLayout()
        timeRemainingLabel.font = .systemFont(ofSize: 28, weight: .medium)
        bottomBannerView.addSubview(timeRemainingLabel)
        self.timeRemainingLabel = timeRemainingLabel
        
        let distanceRemainingLabel: DistanceRemainingLabel = .forAutoLayout()
        distanceRemainingLabel.font = .systemFont(ofSize: 15, weight: .medium)
        bottomBannerView.addSubview(distanceRemainingLabel)
        self.distanceRemainingLabel = distanceRemainingLabel
        
        let arrivalTimeLabel: ArrivalTimeLabel = .forAutoLayout()
        arrivalTimeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        bottomBannerView.addSubview(arrivalTimeLabel)
        self.arrivalTimeLabel = arrivalTimeLabel
        
//        let arrivalTimeImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
//        arrivalTimeImage.image = UIImage(named: "arrivaltime")
//        bottomBannerView.addSubview(arrivalTimeImage)
        
        let arrivalTimeImage = CancelButton(type: .custom)
        arrivalTimeImage.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        arrivalTimeImage.translatesAutoresizingMaskIntoConstraints = false
        arrivalTimeImage.setImage(UIImage(named: "distancer", in: .mapboxNavigation, compatibleWith: nil), for: .normal)
        bottomBannerView.addSubview(arrivalTimeImage)
        self.arrivalTimeImage = arrivalTimeImage
        
        let remainingTimeImage = CancelButton(type: .custom)
        remainingTimeImage.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
        remainingTimeImage.translatesAutoresizingMaskIntoConstraints = false
        remainingTimeImage.setImage(UIImage(named: "arrivaltime", in: .mapboxNavigation, compatibleWith: nil), for: .normal)
        bottomBannerView.addSubview(remainingTimeImage)
        self.remainingTimeImage = remainingTimeImage
        
        let cancelButton = CancelButton(type: .custom)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setImage(UIImage(named: "close", in: .mapboxNavigation, compatibleWith: nil), for: .normal)
        bottomBannerView.addSubview(cancelButton)
        self.cancelButton = cancelButton
        
        let verticalDivider: SeparatorView = .forAutoLayout()
        bottomBannerView.addSubview(verticalDivider)
        self.verticalDividerView = verticalDivider
        self.verticalDividerView.isHidden = true
        
        let horizontalDividerView: SeparatorView = .forAutoLayout()
        bottomBannerView.addSubview(horizontalDividerView)
        self.horizontalDividerView = horizontalDividerView
        
        let trailingSeparatorView: SeparatorView = .forAutoLayout()
        bottomBannerView.addSubview(trailingSeparatorView)
        self.trailingSeparatorView = trailingSeparatorView
        
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        setupVerticalCompactLayout(&verticalCompactConstraints)
        setupVerticalRegularLayout(&verticalRegularConstraints)
        reinstallConstraints()
    }
    
    fileprivate func setupVerticalCompactLayout(_ layoutConstraints: inout [NSLayoutConstraint]) {
        layoutConstraints.append(bottomBannerView.heightAnchor.constraint(equalToConstant: 60))
        
        layoutConstraints.append(timeRemainingLabel.leadingAnchor.constraint(equalTo: bottomBannerView.leadingAnchor, constant: 10))
        layoutConstraints.append(timeRemainingLabel.lastBaselineAnchor.constraint(equalTo: bottomBannerView.centerYAnchor, constant: 0))
        
        layoutConstraints.append(distanceRemainingLabel.leadingAnchor.constraint(equalTo: timeRemainingLabel.leadingAnchor))
        layoutConstraints.append(distanceRemainingLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 0))
        
        layoutConstraints.append(arrivalTimeLabel.centerYAnchor.constraint(equalTo: bottomBannerView.centerYAnchor))
        layoutConstraints.append(arrivalTimeLabel.trailingAnchor.constraint(equalTo: verticalDividerView.leadingAnchor, constant: -5))
        
        layoutConstraints.append(cancelButton.widthAnchor.constraint(equalTo: bottomBannerView.heightAnchor))
        layoutConstraints.append(cancelButton.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(cancelButton.trailingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
        layoutConstraints.append(cancelButton.bottomAnchor.constraint(equalTo: bottomBannerView.bottomAnchor))
        
        layoutConstraints.append(verticalDividerView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(verticalDividerView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor, constant: 10))
        layoutConstraints.append(verticalDividerView.bottomAnchor.constraint(equalTo: bottomBannerView.bottomAnchor, constant: -10))
        layoutConstraints.append(verticalDividerView.centerYAnchor.constraint(equalTo: bottomBannerView.centerYAnchor))
        layoutConstraints.append(verticalDividerView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor))
        
        layoutConstraints.append(horizontalDividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(horizontalDividerView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(horizontalDividerView.leadingAnchor.constraint(equalTo:bottomBannerView.leadingAnchor))
        layoutConstraints.append(horizontalDividerView.trailingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
        
        layoutConstraints.append(trailingSeparatorView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(trailingSeparatorView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(trailingSeparatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        layoutConstraints.append(trailingSeparatorView.leadingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
    }
    
    fileprivate func setupVerticalRegularLayout(_ layoutConstraints: inout [NSLayoutConstraint]) {
        layoutConstraints.append(bottomBannerView.heightAnchor.constraint(equalToConstant: 80))
        
        layoutConstraints.append(timeRemainingLabel.leadingAnchor.constraint(equalTo: bottomBannerView.leadingAnchor, constant: 10))
        layoutConstraints.append(timeRemainingLabel.lastBaselineAnchor.constraint(equalTo: bottomBannerView.centerYAnchor, constant: 0))
        
        layoutConstraints.append(distanceRemainingLabel.leadingAnchor.constraint(equalTo: timeRemainingLabel.leadingAnchor, constant: 30))
        layoutConstraints.append(distanceRemainingLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 9))
        
        layoutConstraints.append(arrivalTimeImage.leadingAnchor.constraint(equalTo: timeRemainingLabel.leadingAnchor, constant: 0))
        layoutConstraints.append(arrivalTimeImage.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 8))
        
        layoutConstraints.append(arrivalTimeLabel.leadingAnchor.constraint(equalTo: timeRemainingLabel.leadingAnchor, constant: 155))
        layoutConstraints.append(arrivalTimeLabel.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 9))
        
        layoutConstraints.append(remainingTimeImage.leadingAnchor.constraint(equalTo: timeRemainingLabel.leadingAnchor, constant: 125))
        layoutConstraints.append(remainingTimeImage.topAnchor.constraint(equalTo: timeRemainingLabel.bottomAnchor, constant: 8))
        
        layoutConstraints.append(cancelButton.widthAnchor.constraint(equalTo: bottomBannerView.heightAnchor))
        layoutConstraints.append(cancelButton.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(cancelButton.trailingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
        layoutConstraints.append(cancelButton.bottomAnchor.constraint(equalTo: bottomBannerView.bottomAnchor))
        
        layoutConstraints.append(verticalDividerView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(verticalDividerView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor, constant: 10))
        layoutConstraints.append(verticalDividerView.bottomAnchor.constraint(equalTo: bottomBannerView.bottomAnchor, constant: -10))
        layoutConstraints.append(verticalDividerView.centerYAnchor.constraint(equalTo: bottomBannerView.centerYAnchor))
        layoutConstraints.append(verticalDividerView.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor))
        
        layoutConstraints.append(horizontalDividerView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(horizontalDividerView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(horizontalDividerView.leadingAnchor.constraint(equalTo: bottomBannerView.leadingAnchor))
        layoutConstraints.append(horizontalDividerView.trailingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
        
        layoutConstraints.append(trailingSeparatorView.widthAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale))
        layoutConstraints.append(trailingSeparatorView.topAnchor.constraint(equalTo: bottomBannerView.topAnchor))
        layoutConstraints.append(trailingSeparatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        layoutConstraints.append(trailingSeparatorView.leadingAnchor.constraint(equalTo: bottomBannerView.trailingAnchor))
    }
    
    public func reinstallConstraints() {
        NSLayoutConstraint.deactivate(verticalCompactConstraints)
        NSLayoutConstraint.deactivate(verticalRegularConstraints)
        
        verticalCompactConstraints.forEach { $0.isActive = traitCollection.verticalSizeClass == .compact }
        verticalRegularConstraints.forEach { $0.isActive = traitCollection.verticalSizeClass == .regular }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            setupConstraints()
        }
        
        // Do not show trailing separator view in case of regular layout.
        if traitCollection.verticalSizeClass == .regular {
            trailingSeparatorView.isHidden = true
        } else {
            trailingSeparatorView.isHidden = false
        }
    }
}
