//
//  ImageService.swift
//  Espeo
//
//  Created by Krzysztof Lech on 13/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

struct ImageService {
    
    static func downloadImage(withUrl urlString: String, closure: @escaping (_ image: UIImage) -> ()) {
        guard
            ReachabilityManager.shared.isReachable(),
            let url = URL(string: urlString)
        else { return }
        
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) { (url, response, error) in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    closure(image)
                }
            }
        }
        downloadTask.resume()
    }
}
