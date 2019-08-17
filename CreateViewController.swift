//
//  CreateViewController.swift
//  Alexandria
//
//  Created by IcyBlast on 19/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//

import UIKit
import CoreData

protocol addBookProtocol
{
    func newBook(book: BookEntity) -> Bool
}

class CreateViewController: UIViewController
{
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputISBN: UITextField!
    @IBOutlet weak var inputAuthor: UITextField!
    @IBOutlet weak var inputPublisher: UITextField!
    @IBOutlet weak var inputEdition: UITextField!
    @IBOutlet weak var inputYear: UITextField!
    @IBOutlet weak var inputGenre: UITextField!
    @IBOutlet weak var inputDescription: UITextField!
    
    var addBookDelegate: addBookProtocol?
    
    private var managedObjectContext: NSManagedObjectContext
    
    required init?(coder aDecoder: NSCoder)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }
    
    @IBAction func saveButton(_ sender: Any)
    {
        let title = self.inputTitle.text
        let isbn = self.inputISBN.text
        let author = self.inputAuthor.text
        let publisher = self.inputPublisher.text
        let edition = self.inputEdition.text
        let year = self.inputYear.text
        let genre = self.inputGenre.text
        let description = self.inputDescription.text
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
        let condition = (isbn)!
        let pre =  NSPredicate.init(format: "bookISBN = '\(condition)'")
        request.predicate = pre
        do {
            let result = try self.managedObjectContext.fetch(request)
            let resultData = result as! [BookEntity]
            if resultData == []
            {
                let alertController = UIAlertController(title: "Add Book?", message: "Are you sure you wish to add this book?", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                alertController.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {
                    action in
                    
                    let book = NSEntityDescription.insertNewObject(forEntityName: "BookEntity", into: self.managedObjectContext) as! BookEntity
                    book.bookTitle = title
                    book.bookISBN = isbn
                    book.bookAuthor = author
                    book.bookPublisher = publisher
                    book.bookEdition = edition
                    book.bookYearOfPublication = year
                    book.bookGenre = genre
                    book.bookDescription = description
                    do
                    {
                        try self.managedObjectContext.save()
                    }
                    catch let error {
                        print("Could not save Core Data: \(error)")
                    }
                    self.navigationController?.popViewController(animated: true)
                    //self.performSegue(withIdentifier: "newBookBackToMain", sender: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: "The book has already existed! Please change the ISBN!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        catch let error
        {
            print("Error: \(error)")
        }
        
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "newBookBackToMain"
        {
            segue.destination as? BookListTableViewController
            //destinationVC?.viewControllerBook = createBook
        }
    }
 */
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
