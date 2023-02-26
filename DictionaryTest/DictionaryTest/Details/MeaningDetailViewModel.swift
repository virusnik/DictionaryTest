//
//  MeaningDetailViewModel.swift
//  DictionaryTest
//
//  Created by Sergio Veliz on 24.02.2023.
//

import UIKit.UIImage
import Combine

class MeaningDetailViewModel {
    
    private var service: WordsSearchServiceable
    @Published private(set) var meaning: [MeaningDetail] = []
    @Published private(set) var state: ListViewModelState = .loading
    
    private var cancellable: AnyCancellable?
    
    init(service: WordsSearchServiceable) {
        self.service = service
    }
    
    func getWord(id: String) {
        if !id.isEmpty {
            Task(priority: .userInitiated) {
                self.state = .loading
                let result = await service.getMeaning(id: id)
                
                switch result {
                case .success(let meaningsResponse):
                    meaning = meaningsResponse
                    self.state = .finishedLoading
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }
    
    private func getImageURL() -> URL {
        if let urlString = meaning.first?.images.first?.url {
            let url = URL(string: "https:" + urlString)!
            return url
        }
        return URL(fileURLWithPath: "")
    }
    
    func loadImage() -> AnyPublisher<UIImage?, Never> {
        return Just(getImageURL())
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                return ImageLoader.shared.loadImage(from: self.getImageURL())
            })
            .eraseToAnyPublisher()
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        cancellable = loadImage().sink { image in
            completion(image)
        }
    }
    
}
