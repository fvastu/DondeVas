//
//  DettaglioCittà.swift
//  ProgettoViaggio
//
//  Created by Sofia Silvestri on 09/06/17.
//  Copyright © 2017 Sofia Silvestri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage


class DettaglioCitta_: UITableViewController {
    
    //@IBOutlet weak var immagineCittà: UIImageView!
    @IBOutlet var indicatorDettaglio: UIActivityIndicatorView!
    var cittàDaVisualizzare : String = ""
    var arrayDiParametri = [String:Int]()
    
    @IBOutlet weak var bottoneDettaglio: UIButton!
    
    @IBOutlet weak var immagineCittà: UIImageView!
  
    
    func configuraImmagine (immagine:UIImageView, nomeCittà:String) {
        //immagine.layer.cornerRadius = 10
        immagine.layer.masksToBounds = true
        
        let label = UILabel()
        
        label.frame = CGRect(x:0, y:0, width:immagine.frame.width-immagine.frame.height/(0.84) , height:immagine.frame.height+immagine.frame.height/(1.5))
        label.text = nomeCittà
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Times New Roman", size: CGFloat(30))
        
        immagine.addSubview(label)
        
        
    }
    
    @IBAction func inserisciNuovaRecensione(_ sender: UIButton) {
        
    
        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinazione = segue.destination as! NuovaRecensioneCitta_Esistente
            //prendo la label dal tile
            let nomeCittà = cittàDaVisualizzare
            //la passo al parametro che userò nella table view per fare la
            //query al database
            destinazione.cittàDaAggiornare = nomeCittà
    
    }
   
    var parametriStringhe : [String] = ["Beaches", "Museums", "Food", "Reachability", "Relax", "Cheap", "Nature", "Safety", "Weather", "Fun"]
    
    override func viewDidAppear(_ animated: Bool) {
    
        immagineCittà.addSubview(indicatorDettaglio)
        indicatorDettaglio.startAnimating()
        indicatorDettaglio.center = immagineCittà.center
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
            self.indicatorDettaglio.color = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        bottoneDettaglio.layer.borderWidth = 1
        bottoneDettaglio.layer.borderColor = UIColor.white.cgColor
        self.tableView.backgroundView = UIImageView (image: #imageLiteral(resourceName: "sfondoDefinitivo"))

        //rimuovo le righe grige di separazione
        self.tableView.separatorStyle = .none
        
        //Mi creo un riferimento al database
        let ref = Database.database().reference()
        
        let storage = Storage.storage().reference(withPath: "\(cittàDaVisualizzare).jpg")
        
        storage.getData(maxSize: 25*1024*2014) { (data,error) in
            
            self.indicatorDettaglio.stopAnimating()
        
            self.indicatorDettaglio.isHidden = true
        self.immagineCittà.image = UIImage(data: data!)
            
        self.configuraImmagine(immagine: self.immagineCittà, nomeCittà: self.cittàDaVisualizzare)
            
    }
        
        
        //Cerco il figlio sfruttando la label del tile
        ref.child(cittàDaVisualizzare).observeSingleEvent(of: .value, with: { (snapshot : DataSnapshot) in
            
            //mi prendo il dato come NSDictionary
            let snap = snapshot.value as? NSDictionary
            
            //Lo casto per facilità di utilizzo
            self.arrayDiParametri = snap as! [String:Int]
            
            //aggiorno i dati nella tableview
            self.tableView.reloadData()
            
            self.tableView.separatorColor = .white
            
            
        })
        //self.immagineCittà.image = #imageLiteral(resourceName: "Schermata 2017-06-08 alle 16.48.01")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //#warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parametriStringhe.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath)
        print(arrayDiParametri)
        
        
        
        let chiave = parametriStringhe[indexPath.row]
        
        print(chiave)
        
        cell.textLabel?.text = chiave
        
        
 
        var str : String = ""
        
        var rating = arrayDiParametri[chiave]
        
        if (rating != nil)
        {
            print(rating!)
            
            for k in  0...4 {
                if k >= rating! {
                    str = str + "☆"
                }
                else {
                    str = str + "★"
                }
                
            }
            cell.detailTextLabel?.text = str
        }
        else
        {
            cell.detailTextLabel?.text = "☆☆☆☆☆"
        }
        
        return cell
    }
    
    
    
}
