import UIKit

final class CustomAnimationTransitions: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // nilを返すとでデフォルトのアニメーションできる
        return AnimationController(isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // すべてoptionalのprotocolなのでpresent時だけ変えたいならこのメソッド自体不要
        return AnimationController(isPresenting: false)
    }

    final class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
        let isPresenting: Bool

        init(isPresenting: Bool) {
            self.isPresenting = isPresenting
        }

        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.5
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            // ここにアニメーションを書く！
            if isPresenting {
                animateForPresentation(context: transitionContext)
            } else {
                animateForDismissal(context: transitionContext)
            }
        }

        func animateForPresentation(context: UIViewControllerContextTransitioning) {
            guard let destination = context.viewController(forKey: .to) else { return }

            let containerView = context.containerView
            destination.view.transform.ty = containerView.frame.maxY
            containerView.addSubview(destination.view) // 遷移先のViewを準備する

            let timing = UISpringTimingParameters(dampingRatio: 0.5)
            let animator = UIViewPropertyAnimator(duration: transitionDuration(using: context), timingParameters: timing)
            animator.addAnimations {
                destination.view.transform = .identity
            }
            animator.addCompletion { (position) in
                context.completeTransition(position == .end) // completeTransition(true, false)を呼ばないとアニメーションが終わらないバグになる
            }
            animator.startAnimation()
        }

        func animateForDismissal(context: UIViewControllerContextTransitioning) {
            guard let from = context.viewController(forKey: .from) else { return }
            let containerView = context.containerView

            UIView.animate(withDuration: transitionDuration(using: context),
                           animations: {
                            from.view.transform.ty = -containerView.bounds.height
            },
                           completion: { finished in
                            context.completeTransition(true)
            })
        }

    }

}

