//
//  BookDetailsViewController.swift
//  Alexandria
//
//  Created by IcyBlast on 19/4/18.
//  Copyright © 2018 IcyBlast. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController
{
    
    var bookDetailsViewControllerBook: BookEntity?
    
    @IBOutlet weak var bookDetailsISBN: UILabel!
    @IBOutlet weak var bookDetailsAuthor: UILabel!
    @IBOutlet weak var bookDetailsPublisher: UILabel!
    @IBOutlet weak var bookDetailsEdition: UILabel!
    @IBOutlet weak var bookDetailsYear: UILabel!
    @IBOutlet weak var bookDetailsGenre: UILabel!
    @IBOutlet weak var bookDetailsDescription: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = bookDetailsViewControllerBook?.bookTitle
        bookDetailsISBN.text = bookDetailsViewControllerBook?.bookISBN
        bookDetailsAuthor.text = bookDetailsViewControllerBook?.bookAuthor
        bookDetailsPublisher.text = bookDetailsViewControllerBook?.bookPublisher
        bookDetailsEdition.text = bookDetailsViewControllerBook?.bookEdition
        bookDetailsYear.text = bookDetailsViewControllerBook?.bookYearOfPublication
        bookDetailsGenre.text = bookDetailsViewControllerBook?.bookGenre
        bookDetailsDescription.text = bookDetailsViewControllerBook?.bookDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "bookEditSegue"
        {
            let destinationVC = segue.destination as? BookEditViewController
            destinationVC?.bookEditViewControllerBook = bookDetailsViewControllerBook
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
