//
//
//  ViewController.swift
//  ProgettoViaggio
//
//  Created by Sofia Silvestri on 06/06/17.
//  Copyright © 2017 Sofia Silvestri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SwiftSpinner



var flagCheap : Bool = false
var flagRelax : Bool = false
var flagFun : Bool = false
var flagPrimaEsecuzione : Bool = true



func getDataFromFirebase(parametro: String, callback: @escaping (_ città: [String: UIImage])->Void){
    
    var DictionaryCittàEconomiche: [String: UIImage] = [:]
   
    let ref = Database.database().reference()
   
    //ordinato in dati a base a qualche parametro da noi deciso
    let query = ref.queryOrdered(byChild: parametro).queryLimited(toLast: 3)
    
    query.observe(.value, with: { (snapshot: DataSnapshot) in
    
        //i dati li sposto in db
        let db = snapshot.value as? [String: AnyObject] ?? [:]
        
        print(db)
    
        for child in db {
        
            
            let key = child.key
            //print (key)
            
            //in storage è presente la locazione dove andare a prendere i dati
            let storage = Storage.storage().reference(withPath: "\(key).jpg")
            
            storage.getData(maxSize: 25 * 1024 * 1024) { (data, error) in
                
                if error == nil
                {
                    let pic = UIImage(data: data!)
                    
                    DictionaryCittàEconomiche[key] = pic
                    
                    if ( DictionaryCittàEconomiche.count == 3)
                    {
                        //eseguo la callback se e solo se sono arrivato a 3,ossia ho caricato tutte le immagini
                        callback(DictionaryCittàEconomiche)
                    }
                }//chiudo l'if dell'errore = nil
                else{
                    
                    let pic = #imageLiteral(resourceName: "immagineGrigia")
                    
                    DictionaryCittàEconomiche[key] = pic
                    
                    if ( DictionaryCittàEconomiche.count == 3)
                    {
                        //eseguo la callback se e solo se sono arrivato a 3,ossia ho caricato tutte le immagini
                        callback(DictionaryCittàEconomiche)
                    }
                    
                    
                    
                }
                
            }
        }
        
        
        
        
        
    })
}


class ViewController: UIViewController,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let ref = Database.database().reference()
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //verificato se la città è già presente,con opportuni controlli riducendo 
            //a caratteri piccoli e mettendo la maiuscola
            if snapshot.hasChild(searchBar.text!.lowercased().capitalized){
                
                //se il dato è già presente nel database faccio la segue
                self.performSegue(withIdentifier: "dettaglioCittà", sender: self)
                
                }
                
            //se la città non è nel database mostra un popup per lasciar decidere all'utente
            else {
                
                //se l'utente fa cancel non aggiungo una nuova
                let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:
                    
                    {  (paramAction:UIAlertAction!) in
                        
                        //print("Il messaggio di chiusura è stato premuto")
                })
                
                let action2 = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler:
                
                    {
                    (paramAction:UIAlertAction!) in
                    self.performSegue(withIdentifier: "nuovaRecensione", sender: self)
                    })
                
                
                var controller = UIAlertController(title: "City not found", message: "Add a new destination?" ,preferredStyle: .alert)
//                self.show(controller, sender: nil)
                self.present(controller, animated: true, completion: nil)
                
                controller.addAction(action)
                controller.addAction(action2)
                
                //print ("errore")
                
                
            }
        })
        
        
}
    
    //in array nomi salvo il contenuto delle 3 città che soddisfano quel determinato parametro
    
    var arraynomi : [String] = []
    var arraynomi2 : [String] = []
    var arraynomi3 : [String] = []
    
    
    //Funzione per configurare le immagini nei diversi tile
    func configuraImmagine (immagine:UIImageView, nomeCittà:String) {
        
        immagine.layer.cornerRadius = 10
        immagine.layer.masksToBounds = true
        
        let label = UILabel()
        
        label.frame = CGRect(x:0, y:0, width:immagine.frame.width , height:immagine.frame.height)
        label.text = nomeCittà
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Helvetica", size: CGFloat(18))
        
        immagine.addSubview(label)
        
        
    }
    
    
    @IBOutlet weak var prova: UILabel!
    
    //Immagini nei tile
    @IBOutlet weak var primaImmagine: UIImageView!
    @IBOutlet weak var secondaImmagine: UIImageView!
    @IBOutlet weak var terzaImmagine: UIImageView!
    @IBOutlet weak var quartaImmagine: UIImageView!
    @IBOutlet weak var quintaImmagine: UIImageView!
    @IBOutlet weak var sestaImmagine: UIImageView!
    @IBOutlet weak var settimaImmagine: UIImageView!
    @IBOutlet weak var ottavaImmagine: UIImageView!
    @IBOutlet weak var nonaImmagine: UIImageView!
    
    
    //Funzioni per riconoscere il tap sui tile
    @IBAction func primoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "primoTileSegue", sender: self)
    }
    
    @IBAction func secondoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "secondoTileSegue", sender: self)
    }
    
    
    @IBAction func terzoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "terzoTileSegue", sender: self)
    }
    
    
    @IBAction func quartoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "quartoTileSegue", sender: self)
    }
    
    
    
    @IBAction func quintoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "quintoTileSegue", sender: self)
    }

    @IBAction func sestoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "sestoTileSegue", sender: self)
    }
    
    
    @IBAction func settimoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "settimoTileSegue", sender: self)
    }
    
    
    @IBAction func ottavoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ottavoTileSegue", sender: self)
    }
    
    
    @IBAction func nonoTileTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "nonoTileSegue", sender: self)
    }
    
    
    
    //preparo i dati dopo aver cliccato sul tile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        switch segue.identifier! {
            
            
        case "primoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi[0]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "secondoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi[1]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "terzoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi[2]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "quartoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi2[0]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "quintoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi2[1]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "sestoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi2[2]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "settimoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi3[0]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "ottavoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi3[1]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "nonoTileSegue" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = arraynomi3[2]
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà
            
        case "dettaglioCittà" :
            let destinazione = segue.destination as! DettaglioCitta_
            //prendo la label dal tile
            let nomeCittà = searchBar.text?.lowercased().capitalized
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaVisualizzare = nomeCittà!
            
        case "nuovaRecensione" :
            let destinazione = segue.destination as! NuovaRecensioneViewController
            //prendo la label dal tile
            let nomeCittà = searchBar.text?.lowercased().capitalized
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.nuovaCittà = nomeCittà!
            
        case "nuovaRecensioneCittàPresente":
            let destinazione = segue.destination as! NuovaRecensioneViewController
            //prendo la label dal tile
            let nomeCittà = searchBar.text?.lowercased().capitalized
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.nuovaCittà = nomeCittà!

 
        default: print("Ciao mondo")
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if flagPrimaEsecuzione == true {
            SwiftSpinner.show("Loading the best destinations...")
            flagPrimaEsecuzione = false
        }
        flagRelax = false
        flagFun = false
        flagRelax = false
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func disposeKeyboard() {
        
        view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.isHidden = true
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(disposeKeyboard))
        view.addGestureRecognizer(tap)
        
        //prendo le immagini dal database
        getDataFromFirebase(parametro: "Cheap", callback: {(città) in
            
            print("Mi sono arrivate le economiche")
            
            for (nome1,foto) in città {
                
                self.arraynomi.append(nome1)
                
                if self.arraynomi.count == 3 {
                    
                    self.primaImmagine.image = città[self.arraynomi[0]]
                    self.configuraImmagine(immagine: self.primaImmagine, nomeCittà: self.arraynomi[0])
                    self.secondaImmagine.image = città[self.arraynomi[1]]
                    self.configuraImmagine(immagine: self.secondaImmagine, nomeCittà: self.arraynomi[1])
                    self.terzaImmagine.image = città[self.arraynomi[2]]
                    self.configuraImmagine(immagine: self.terzaImmagine, nomeCittà: self.arraynomi[2])
                    flagCheap = true
                    if (flagRelax == true && flagCheap == true && flagFun == true)
                    {
                        SwiftSpinner.hide()
                        flagFun = false
                        flagCheap = false
                        flagRelax = false
                    }
                }
                
            }
            
        })
        
        
        
        getDataFromFirebase(parametro: "Fun", callback: {(città) in
            
            
            print("Mi sono arrivate le divertenti")
            for (nome2,foto) in città {
                
                self.arraynomi2.append(nome2)
                
                if self.arraynomi2.count == 3 {
                    
                    self.quartaImmagine.image = città[self.arraynomi2[0]]
                    self.configuraImmagine(immagine: self.quartaImmagine, nomeCittà: self.arraynomi2[0])
                    self.quintaImmagine.image = città[self.arraynomi2[1]]
                    self.configuraImmagine(immagine: self.quintaImmagine, nomeCittà: self.arraynomi2[1])
                    self.sestaImmagine.image = città[self.arraynomi2[2]]
                    self.configuraImmagine(immagine: self.sestaImmagine, nomeCittà: self.arraynomi2[2])
                    flagFun = true
                    if (flagRelax == true && flagCheap == true && flagFun == true)
                    {
                        SwiftSpinner.hide()
                        flagFun = false
                        flagCheap = false
                        flagRelax = false
                    }
                }
                
            }
            
        })
        
        
        getDataFromFirebase(parametro: "Relax", callback: {(città) in
            
            print("Mi sono arrivate le rilassanti")
            for (nome3,foto) in città {
                
                self.arraynomi3.append(nome3)
                
                if self.arraynomi3.count == 3 {
                    
                    self.settimaImmagine.image = città[self.arraynomi3[0]]
                    self.configuraImmagine(immagine: self.settimaImmagine, nomeCittà: self.arraynomi3[0])
                    self.ottavaImmagine.image = città[self.arraynomi3[1]]
                    self.configuraImmagine(immagine: self.ottavaImmagine, nomeCittà: self.arraynomi3[1])
                    self.nonaImmagine.image = città[self.arraynomi3[2]]
                    self.configuraImmagine(immagine: self.nonaImmagine, nomeCittà: self.arraynomi3[2])
                    flagRelax = true
                    if (flagRelax == true && flagCheap == true && flagFun == true)
                    {
                        SwiftSpinner.hide()
                        flagFun = false
                        flagCheap = false
                        flagRelax = false
                    }
                    
                }
                
            }
            
        })
        
        
        
    }
        
        
        

    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

        



}
