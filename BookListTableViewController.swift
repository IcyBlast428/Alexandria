//
//  BookListTableViewController.swift
//  Alexandria
//
//  Created by IcyBlast on 19/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//

import UIKit
import CoreData

extension BookListTableViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

class BookListTableViewController: UITableViewController//, UISearchResultsUpdating
{
    
    private var filteredBookList: [BookEntity] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    //var viewControllerBook: Book?
    /*
    @IBAction func getData(segue: UIStoryboardSegue)
    {
        if segue.identifier == "newBookBackToMain"
        {
            //tableView.beginUpdates()
            tableView.reloadData()
            //tableView.endUpdates()
            tableView.reloadSections([SECTION_COUNT], with: .automatic)
        }
    }
    */
 
    private var bookList: [BookEntity] = []
    private var managedObjectContext: NSManagedObjectContext
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }
    
    private let SECTION_BOOKS = 0
    private let SECTION_COUNT = 1
    
    func addBookData()
    {
        var book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "Python"
        book.bookISBN = "01"
        book.bookAuthor = "Yu Python"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 01"
        book.bookYearOfPublication = "1994"
        book.bookGenre = "Genre Python"
        book.bookDescription = "Introduction to Python"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "C++"
        book.bookISBN = "02"
        book.bookAuthor = "Yu C++"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 02"
        book.bookYearOfPublication = "1995"
        book.bookGenre = "Genre C++"
        book.bookDescription = "Introduction to C++"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "Swift"
        book.bookISBN = "03"
        book.bookAuthor = "Yu Swift"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 03"
        book.bookYearOfPublication = "1996"
        book.bookGenre = "Genre Swift"
        book.bookDescription = "Introduction to CSwift+"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "MEL"
        book.bookISBN = "04"
        book.bookAuthor = "Yu MEL"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 04"
        book.bookYearOfPublication = "1997"
        book.bookGenre = "Genre MEL"
        book.bookDescription = "Introduction to MEL"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "C#"
        book.bookISBN = "05"
        book.bookAuthor = "Yu C#"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 5"
        book.bookYearOfPublication = "1998"
        book.bookGenre = "Genre C#"
        book.bookDescription = "Introduction to C#"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "C"
        book.bookISBN = "06"
        book.bookAuthor = "Yu C"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 06"
        book.bookYearOfPublication = "1999"
        book.bookGenre = "Genre C"
        book.bookDescription = "Introduction to C"
        
        book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: managedObjectContext) as! BookEntity
        book.bookTitle = "Java"
        book.bookISBN = "07"
        book.bookAuthor = "Yu Java"
        book.bookPublisher = "Monash"
        book.bookEdition = "Version 07"
        book.bookYearOfPublication = "2000"
        book.bookGenre = "Genre Jave"
        book.bookDescription = "Introduction to Jave"
        do
        {
            try managedObjectContext.save()
        }
        catch let error
        {
            print("Could not save Core Data: \(error)")
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        request()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All")
    {
        filteredBookList = bookList.filter({(book: BookEntity) -> Bool in return (book.bookTitle?.lowercased().contains(searchText.lowercased()))!})
        tableView.reloadData()
    }
    
    func request()
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
        do
        {
            bookList = try self.managedObjectContext.fetch(fetchRequest) as! [BookEntity]
            if bookList.count == 0
            {
                addBookData()
                bookList = try managedObjectContext.fetch(fetchRequest) as! [BookEntity]
            }
        }
        catch
        {
            fatalError("Failed to fetch super heros: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        request()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == SECTION_COUNT
        {
            return 1
        }
        else
        {
            if searchController.isActive && searchController.searchBar.text != ""
            {
                return filteredBookList.count
            }
        }
        return bookList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cellResuseIdentifier = "BookCell"
        if indexPath.section == SECTION_COUNT
        {
            cellResuseIdentifier = "TotalCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellResuseIdentifier, for: indexPath)
        
        if indexPath.section == SECTION_COUNT
        {
            if searchController.isActive && searchController.searchBar.text != ""
            {
                cell.textLabel?.text = "\(filteredBookList.count) Books"
            }
            else
            {
                cell.textLabel?.text = "\(bookList.count) Books"
            }
        }
        else
        {
            let book: BookEntity
            let bookCell = cell as! BookListTableViewCell
            if searchController.isActive && searchController.searchBar.text != ""
            {
                book = filteredBookList[indexPath.row]
            }
            else
            {
                book = bookList[indexPath.row]
            }
            bookCell.titleLabel.text = book.bookTitle
            bookCell.authorLabel.text = book.bookAuthor
            bookCell.descriptionLabel.text = book.bookDescription
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //self.performSegue(withIdentifier: "showDetailsSegue", sender: self)
    }
    
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Delete"
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let deletedBook = bookList[indexPath.row]
            self.bookList.remove(at: indexPath.row)
            managedObjectContext.delete(deletedBook)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadSections([SECTION_COUNT], with: .fade)
            do
            {
                try managedObjectContext.save()
            }
            catch let error
            {
                print("Could not save Core Data: \(error)")
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == SECTION_BOOKS
        {
            return 80
        }
        else
        {
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let headerHeight: CGFloat
        switch section {
        case SECTION_BOOKS:
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 5
        }
        
        return headerHeight
    }

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showDetailsSegue"
        {
            let destinationVC = segue.destination as? BookDetailsViewController
            destinationVC?.bookDetailsViewControllerBook = bookList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}




