

import UIKit

class PresentViewController: NSObject, UIViewControllerAnimatedTransitioning {
	
	private let duration = 0.5
	var presenting = true
	var originFrame = CGRect.zero
	
	var dismissCompletion: (() -> Void)?
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
		let containerView = transitionContext.containerView
		let toView = transitionContext.view(forKey: .to)!
		containerView.addSubview(toView)
		
		let detailView = presenting ? toView : transitionContext.view(forKey: .from)!
		let initialFrame = presenting ? originFrame : detailView.frame
		let finalFrame = presenting ? detailView.frame : originFrame
		let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
		let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
		let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
		
		let destinationController = transitionContext.viewController(forKey: presenting ? .to : .from) as! ImageDetailController
		
		if presenting {
			detailView.transform = scaleTransform
			detailView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
			detailView.clipsToBounds = true
			
			
			destinationController.containerContent.alpha = 0.0
			
		}
		
		containerView.addSubview(toView)
		containerView.bringSubviewToFront(detailView)
		
		UIView.animate(withDuration: duration,  delay: 0.0, usingSpringWithDamping: 0.8,
									 initialSpringVelocity: 0.0, animations: {
										
										detailView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
										detailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
										
										
										destinationController.containerContent.alpha = self.presenting ? 1.0 : 0.0
										
										
										
		}) { _ in
			if !self.presenting {
				self.dismissCompletion?()
			}
			transitionContext.completeTransition(true)
		}
		
		let round = CABasicAnimation(keyPath: "cornerRadius")
		round.fromValue = !presenting ? 0.0 : 9.0 / xScaleFactor
		round.toValue = presenting ? 0.0 : 9.0 / xScaleFactor
		round.duration = duration / 2
		detailView.layer.add(round, forKey: nil)
		detailView.layer.cornerRadius = presenting ? 0.0 : 9.0 / xScaleFactor
		
	}
}
