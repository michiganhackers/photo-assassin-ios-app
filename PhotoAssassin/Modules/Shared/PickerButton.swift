//
//  PickerButton.swift
//  PhotoAssassin
//
//  Created by Thomas Smith on 4/6/19.
//  Copyright © 2019 Michigan Hackers. All rights reserved.
//

import UIKit

class PickerButton<T>:
UIButton, UIPopoverPresentationControllerDelegate, PickerViewControllerDelegate {
    let borderWidth: CGFloat = 1.0
    let cornerRadius: CGFloat = 15.0
    let fontSize: CGFloat = 36.0
    let height: CGFloat = 67.0

    private let options: [(String, T)]
    private var selectedOptionIndex: Int
    private lazy var pickerVC: PickerViewController<T> = {
        let viewController = PickerViewController<T>(
            options: options,
            defaultRow: selectedOptionIndex
        )
        viewController.delegate = self
        return viewController
    }()

    func optionWasSelected(option index: Int) {
        selectedOptionIndex = index
        onRowSelected()
    }

    func onRowSelected() {
        setTitle(options[selectedOptionIndex].0, for: .normal)
    }

    func addStyling() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true

        layer.borderColor = Colors.text.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius

        setTitleColor(Colors.seeThroughText, for: .normal)
        setTitleColor(Colors.seeThroughContrast, for: .disabled)
        setTitleColor(Colors.seeThroughContrast, for: .focused)
        setTitleColor(Colors.seeThroughContrast, for: .highlighted)
        setTitleColor(Colors.seeThroughContrast, for: .selected)

        titleLabel?.font = R.font.economicaBold(size: fontSize)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    func displayPickerPopover(from viewController: UIViewController) {
        pickerVC.modalPresentationStyle = .popover
        if let popoverVC = pickerVC.popoverPresentationController {
            popoverVC.sourceView = self
            popoverVC.delegate = self
            popoverVC.permittedArrowDirections = [.up]
            popoverVC.backgroundColor = Colors.behindGradient
            popoverVC.canOverlapSourceViewRect = false
            popoverVC.sourceRect = bounds
        }
        pickerVC.preferredContentSize = CGSize(
            width: pickerVC.tableView.contentSize.width,
            height: PickerViewCell.getHeight() * CGFloat(options.count)
        )
        viewController.present(pickerVC, animated: true) {
            // The popover is now visible
        }
    }

    func getSelectedValue() -> T {
        return options[selectedOptionIndex].1
    }

    required init?(coder aDecoder: NSCoder) {
        self.options = []
        self.selectedOptionIndex = 0
        super.init(coder: aDecoder)
    }

    init(options: [(String, T)], defaultRow: Int = 0) {
        assert(defaultRow >= 0 && defaultRow < options.count,
               "Invalid default row for PickerButton")
        self.options = options
        self.selectedOptionIndex = defaultRow
        super.init(frame: .zero)
        addStyling()
        onRowSelected()
    }
}
