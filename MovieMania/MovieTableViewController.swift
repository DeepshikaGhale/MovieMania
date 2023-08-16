//
//  MovieTableViewController.swift
//  MovieMania
//
//  Created by Bikash Chhantyal on 2023-08-13.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movieData: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let movieDataResponse = try await MovieMania_Helper.fetchMovieData()
                movieData = movieDataResponse.titles
                
                // Reload the table view to display the fetched data
                tableView.reloadData()
                
                print("Movie data fetched:", movieData) // Verify that data is correctly fetched and stored
            } catch {
                print("Error fetching movie data:", error)
                preconditionFailure("program fail with error message \(error)")
            }
        }

        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as!
        MovieTableViewCell
           // Configure the cell...
        cell.MovieName.text = movieData[indexPath.row].jawSummary.title
        cell.ReleaseYear.text = String(movieData[indexPath.row].jawSummary.releaseYear)
            
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
