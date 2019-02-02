import UIKit

final class CustomPresentationTransitions: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }

    final class PresentationController: UIPresentationController {

        override var frameOfPresentedViewInContainerView: CGRect {
            let frame = super.frameOfPresentedViewInContainerView
            return frame.inset(by: UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50))

            // サイドバー
//            return CGRect(x: frame.width / 2, y: frame.origin.y, width: frame.width, height: frame.height)
        }

        override func containerViewWillLayoutSubviews() {
            super.containerViewWillLayoutSubviews()
            presentedView?.frame = frameOfPresentedViewInContainerView
        }
    }
}

