import UIKit

extension UIViewController {
    
    func userErrorAlert(localizedError:LocalizedError) {
        let alertToShow = UIAlertController(
            title: "ERROR!",
            message: localizedError.localizedDescription,
            preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alertToShow.addAction(dismissAction)
        
        present(alertToShow, animated: true)
    }
}
