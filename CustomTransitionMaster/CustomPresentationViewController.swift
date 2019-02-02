import UIKit

final class CustomPresentationViewController: UIViewController {
    let transitionController = CustomPresentationTransitions()

    deinit {
        print(type(of: self), #function)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = .custom
        transitioningDelegate = transitionController
    }

    @IBAction func didTapDismissButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
