//
//  ImageExtension.swift
//  OmdbMovieApp
//
//  Created by Selcuk on 19.03.2022.
//

import Foundation
import Kingfisher

extension UIImageView{
    func setImage(imageUrl:String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
