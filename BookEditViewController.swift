//
//  BookEditViewController.swift
//  Alexandria
//
//  Created by IcyBlast on 20/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//

import UIKit
import CoreData

class BookEditViewController: UIViewController
{
    private var managedObjectContext: NSManagedObjectContext
    
    required init?(coder aDecoder: NSCoder)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }
    
    var bookEditViewControllerBook: BookEntity?
    
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editAuthor: UITextField!
    @IBOutlet weak var editPublisher: UITextField!
    @IBOutlet weak var editYear: UITextField!
    @IBOutlet weak var editGenre: UITextField!
    @IBOutlet weak var editDescription: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        editTitle.text = bookEditViewControllerBook?.bookTitle
        editAuthor.text = bookEditViewControllerBook?.bookAuthor
        editPublisher.text = bookEditViewControllerBook?.bookPublisher
        editYear.text = bookEditViewControllerBook?.bookYearOfPublication
        editGenre.text = bookEditViewControllerBook?.bookGenre
        editDescription.text = bookEditViewControllerBook?.bookDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEditButton(_ sender: Any)
    {
        let alertController = UIAlertController(title: "Edit Book?", message: "Are you sure you wish to edit this book?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            action in
            
            let title = self.editTitle.text
            let author = self.editAuthor.text
            let publisher = self.editPublisher.text
            let year = self.editYear.text
            let genre = self.editGenre.text
            let description = self.editDescription.text
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "BookEntity")
            let condition = (self.bookEditViewControllerBook?.bookISBN)!
            let pre =  NSPredicate.init(format: "bookISBN = '\(condition)'")
            request.predicate = pre
            do {
                let result = try self.managedObjectContext.fetch(request)
                
                let resultData = result as! [BookEntity]
                for book in resultDataq
                {
                    book.bookTitle = title
                    book.bookAuthor = author
                    book.bookPublisher = publisher
                    book.bookYearOfPublication = year
                    book.bookGenre = genre
                    book.bookDescription = description
                }
                try self.managedObjectContext.save()
            } catch let error
            {
                print("Error : \(error)")
            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
