import UIKit

final class CustomAnimationViewController: UIViewController {

    let transitionController = CustomAnimationTransitions()

    deinit {
        print(type(of: self), #function)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        modalPresentationStyle = .overCurrentContext 後ろのVCを見せたいとき
        transitioningDelegate = transitionController
    }

    @IBAction func didTapDismissButton(_ sender: Any) {
        // animated: trueじゃないと動かないよ！
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

