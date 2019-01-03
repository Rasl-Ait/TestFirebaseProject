

import Foundation
import Kingfisher

extension UIImageView {
	func setImage(fromURL url: URL) {
		kf.setImage(with: url)
	}
	
	@discardableResult
	func setImage(fromURL url: URL,
								withPlaceholderImage placeholder: UIImage?,
								completion: CompletionHandler? = nil) -> RetrieveImageTask {
		return kf.setImage(with: url,
											 placeholder: placeholder,
											 options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))],
											 progressBlock: nil,
											 completionHandler: completion)
	}
	
	@discardableResult
	func setImage(fromString string: String?, placeholder: UIImage?) -> RetrieveImageTask? {
		guard let string = string, let url = URL(string: string) else { return nil }
		return self.setImage(fromURL: url, withPlaceholderImage: placeholder)
	}
}
