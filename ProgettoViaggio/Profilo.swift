//
//  Profilo.swift
//  ProgettoViaggio
//
//  Created by Sofia Silvestri on 09/06/17.
//  Copyright © 2017 Sofia Silvestri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

//classe chiamata inizialmente profilo poi divenuta VersusClasse
class Profilo: UIViewController,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar1: UISearchBar!
    @IBOutlet weak var searchBar2: UISearchBar!
    
    
    @IBOutlet weak var bottoneConfronto: UIButton!
    
    
    func vsButton(_ sender: UIButton) {
        
        let ref = Database.database().reference()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //verificato se la città è già presente,con opportuni controlli riducendo
            //a caratteri piccoli e mettendo la maiuscola
            if snapshot.hasChild(self.searchBar1.text!.lowercased().capitalized) {
                
                if snapshot.hasChild(self.searchBar2.text!.lowercased().capitalized)
                {
                    self.performSegue(withIdentifier: "confrontoCittà" , sender: self)
                    
                }
                    
                    
                //se la seconda città non c'è
                else {
                   
                    let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:
                        
                        {  (paramAction:UIAlertAction!) in
                            
                            print("Il messaggio di chiusura è stato premuto")
                    })
                    
                    let controller = UIAlertController(title: "Second city not found", message: "Try to find another destination" ,preferredStyle: .alert)
                    
                    self.show(controller, sender: nil)
                    
                    controller.addAction(action)
                    
                    
                }
                
            }
                
                
                
    
            else {
               
                
                let action2 = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:
                    
                    {
                        (paramAction:UIAlertAction!) in
                        self.performSegue(withIdentifier: "nuovaRecensione", sender: self)
                })
                
                
                let controller = UIAlertController(title: "First city not found", message: "Try to find another destination" ,preferredStyle: .alert)
                self.show(controller, sender: nil)

                controller.addAction(action2)
                
                //print ("errore")
                
                
            }
        })
        
}
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar2: UISearchBar) {
//        searchBar2.resignFirstResponder()
//    }
    
    
    
//    func disposeKeyboard() {
//        view.endEditing(true)
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar1.endEditing(true)
        searchBar2.endEditing(true)
        
//        let tap = UITapGestureRecognizer()
//        tap.addTarget(self, action: #selector(disposeKeyboard))
//        view.addGestureRecognizer(tap)
        
        bottoneConfronto.layer.borderColor = UIColor.white.cgColor
        bottoneConfronto.layer.borderWidth = 1
        searchBar1.delegate = self
        searchBar2.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinazione = segue.destination as! ConfrontoCitta_
        
        
            //prendo la label dal tile
            let nomiCittàConfronto = [searchBar1.text,searchBar2.text]
        
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaConfrontare = nomiCittàConfronto as! [String]
        
            
        }
    


}
