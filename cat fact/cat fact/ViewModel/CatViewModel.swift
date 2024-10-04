import Foundation

class CatViewModel {
    private let catService: CatService
    
    var catFact: String? {
        didSet {
            updateUI?()
        }
    }
    
    var catImageURL: String? {
        didSet {
            updateUI?()
        }
    }
    
    var updateUI: (() -> Void)?
    
    init(catService: CatService = CatService()) {
        self.catService = catService
    }
    

    
    func fetchNewCatContent() {
        // Create a group for concurrent fetching
        let dispatchGroup = DispatchGroup()

        // Fetch random cat fact
        dispatchGroup.enter()
        catService.fetchRandomCatFact { [weak self] fact in
            self?.catFact = fact
            dispatchGroup.leave() // Signal completion
        }

        // Fetch random cat image
        dispatchGroup.enter()
        catService.fetchRandomCatImage { [weak self] image in
            self?.catImageURL = image?.url
            dispatchGroup.leave() // Signal completion
        }

        // Notify when all fetches are complete
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.updateUI?() // Call updateUI only after both fetches
        }
    }
}
