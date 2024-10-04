import UIKit

class CatViewController: UIViewController {

    // Define UI elements
    private let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let catFactLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel = CatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the UI
        setupUI()
        setupBindings()
        viewModel.fetchNewCatContent()  // Fetch initial cat image and fact
        
        // Tap gesture to trigger new content
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        // Add imageView and label to the view
        view.addSubview(catImageView)
        view.addSubview(catFactLabel)
        
        // Set constraints for imageView
        NSLayoutConstraint.activate([
            catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            catImageView.widthAnchor.constraint(equalToConstant: 300),
            catImageView.heightAnchor.constraint(equalToConstant: 300),
            
            // Set constraints for catFactLabel
            catFactLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 20),
            catFactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            catFactLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupBindings() {
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                // Update cat image
                if let imageURL = self?.viewModel.catImageURL {
                    self?.catImageView.loadImage(from: imageURL)
                }
                // Update cat fact
                self?.catFactLabel.text = self?.viewModel.catFact
            }
        }
    }
    
    @objc func screenTapped() {
        viewModel.fetchNewCatContent()  // Fetch new cat image and fact when tapped
    }
}

// Extension to load images from URL
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
