//
//  Movie.swift
//  SmoothHeroAnimation
//
//  Created by Bilal SIMSEK on 25.07.2023.
//

import Foundation


struct Movie:Identifiable{
    var id = UUID().uuidString
    var movieTitle:String
    var artwork:String
}

var movies:[Movie] = [
Movie(movieTitle: "Ad Astra", artwork: "adastra"),
Movie(movieTitle: "Star Wars", artwork: "starwars"),
Movie(movieTitle: "Toy Story", artwork: "toystory"),
Movie(movieTitle: "Lion King", artwork: "lionking"),
Movie(movieTitle: "Spider Man", artwork: "spiderman"),
Movie(movieTitle: "Shang Chi", artwork: "shangchi"),
Movie(movieTitle: "Hawkeye", artwork: "hawkeye")
]


let dummyText:String = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tellus cras adipiscing enim eu. Eleifend mi in nulla posuere sollicitudin aliquam. Erat pellentesque adipiscing commodo elit at imperdiet dui. Tincidunt praesent semper feugiat nibh. Et tortor consequat id porta nibh venenatis cras sed. Nisi lacus sed viverra tellus in hac habitasse platea dictumst. Nascetur ridiculus mus mauris vitae. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Elit ullamcorper dignissim cras tincidunt lobortis. Suspendisse potenti nullam ac tortor vitae purus faucibus ornare. Ut tristique et egestas quis.\nTortor consequat id porta nibh venenatis cras sed. Nec feugiat in fermentum posuere urna nec tincidunt. In hac habitasse platea dictumst. Quis eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis. Eget egestas purus viverra accumsan in nisl. Odio pellentesque diam volutpat commodo sed. Sed sed risus pretium quam vulputate dignissim
"""
