//
//  MovieTableViewCell.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-13.
//

import UIKit
import CoreData

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var ReleaseYear: UILabel!
    @IBOutlet weak var isFavMovie: UIButton!
    
    var favMovie: MovieEntity?
    var container: NSPersistentContainer? {
           return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
       }
    
    var movie: MovieModel? {
        didSet {
            updateUI()
        }
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateUI()
    }
    
    @IBAction func isFavMovie(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "star") {
            // Change button image to filled star
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            // Change button image color
            sender.tintColor = .blue
            
            // Create a new instance of favMovie entity
            if let container = container{
                let favMovie = MovieEntity(context: container.viewContext)
                favMovie.movieID = Int64(movie?.jawSummary.id ?? 0)
                favMovie.movieName = movie?.jawSummary.title
                favMovie.image = "movie-image"
                favMovie.movieOverview = movie?.jawSummary.synopsis
                favMovie.releaseYear = String(movie?.jawSummary.releaseYear ?? 0)
                
                // Save the new entity in CoreData
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                alertMessage(message: "added successfully")
            }else{
                print("empty")
            }
        } else {
            // Set star back to empty outline
            // Remove favMovie
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            sender.tintColor = .black
            
            if let movie = favMovie {
                    container?.viewContext.delete(movie)
                    alertMessage(message: "deleted successfully.")
                
            }else{
                print(favMovie?.movieID)
            }
        }
    }
    
    private func updateUI() {
        guard let movie = movie else {
            return
        }
        
            // Update your UI components with movie data
            MovieName.text = movie.jawSummary.title
            ReleaseYear.text = String(movie.jawSummary.releaseYear)
            
            // Check if the movie is in favorites and set button state accordingly
               if let existingFavMovie = favMovie, existingFavMovie.movieID == Int16(movie.jawSummary.id) {
                   isFavMovie.setImage(UIImage(systemName: "star.fill"), for: .normal)
                   isFavMovie.tintColor = .blue
               } else {
                   isFavMovie.setImage(UIImage(systemName: "star"), for: .normal)
                   isFavMovie.tintColor = .black
               }
    }
    
  
    private func alertMessage(message: String){
        let alertController = UIAlertController(title: "Task Complete", message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       alertController.addAction(okAction)
       UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
