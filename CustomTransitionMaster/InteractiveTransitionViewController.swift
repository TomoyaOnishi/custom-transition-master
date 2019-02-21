import UIKit

final class InteractiveTransitionViewController: UIViewController, UIViewControllerTransitioningDelegate {
    lazy var pullToDismissTransitionController = PullToDismissTransitionController(viewController: self)

    deinit {
        print(type(of: self), #function)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let pan = UIPanGestureRecognizer(target: pullToDismissTransitionController,
                                         action: #selector(PullToDismissTransitionController.observePanGesture(panGesture:)))
        view.addGestureRecognizer(pan)
    }

}

extension InteractiveTransitionViewController {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NoAnimatedAnimationController()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return pullToDismissTransitionController
    }
}
