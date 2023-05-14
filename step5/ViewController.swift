//
//  ViewController.swift
//  step5
//
//  Created by Nikolay Volnikov on 14.05.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var presentButton: UIButton = {
        let button = UIButton()
        button.configuration = getConfig()
        button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(presentButton)
        configureConstraints()
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

fileprivate extension ViewController {

    func configureConstraints() {
        presentButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.centerX.equalToSuperview()
        }
    }

    func getConfig() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.title = "Present"
        config.titleAlignment = .center

        return config
    }

    @objc func presentController() {
        let vc = PresentViewController()
        vc.modalPresentationStyle = .popover

        vc.preferredContentSize = .init(width: 300, height: 300)  // the size of popover
        vc.popoverPresentationController?.sourceView = self.view    // the view of the popover
        vc.popoverPresentationController?.sourceRect = CGRect(    // the place to display the popover
            origin: CGPoint(
                x: self.presentButton.frame.midX,
                y: self.presentButton.frame.midY + 10
            ),
            size: .zero
        )
        vc.popoverPresentationController?.permittedArrowDirections = .up // the direction of the arrow
        vc.popoverPresentationController?.delegate = self

        present(vc, animated: true)
    }
}

class PresentViewController: UIViewController {

    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["280pt","150pt"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(chageFrame), for: .valueChanged)
        return control
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .systemGray


        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentControl)
        view.addSubview(closeButton)
        self.preferredContentSize = CGSize(width: 320, height: 280)

        segmentControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(10)
        }
    }

    @objc func chageFrame(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
         case 0:
             self.preferredContentSize = CGSize(width: 320, height: 280)
         case 1:
             self.preferredContentSize = CGSize(width: 320, height: 150)
         default:
            self.preferredContentSize = CGSize(width: 320, height: 280)
         }
    }

    @objc func closeController() {
        dismiss(animated: true)
    }
}
