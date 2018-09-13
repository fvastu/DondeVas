//
//  ConfrontoCittà.swift
//  ProgettoViaggio
//
//  Created by Francesco Vasturzo on 12/06/17.
//  Copyright © 2017 Sofia Silvestri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage



class confrontoCella: UITableViewCell {
    
    @IBOutlet var stellePrimaCittà: UILabel!
    @IBOutlet var stelleSecondaCittà: UILabel!
    @IBOutlet var Parametro : UILabel!
}




class ConfrontoCitta_: UITableViewController {
    
    
    
    func configuraImmagine (immagine:UIImageView, nomeCittà:String) {
        //immagine.layer.cornerRadius = 10
        immagine.layer.masksToBounds = true
        
        let label = UILabel()
        
        label.frame = CGRect(x:0, y:0, width:immagine.frame.width , height:immagine.frame.height+immagine.frame.height/(1.5))
        label.text = nomeCittà
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Times New Roman", size: CGFloat(20))
        
        immagine.addSubview(label)
        
        
    }
    
    
    var arrayDiParametri = [String:Int]()
    var arrayDiParametri2 = [String:Int]()
    var cittàDaConfrontare = [String]()
    
    
    @IBOutlet weak var primaImmagineConfronto: UIImageView!
    @IBOutlet weak var secondaImmagineConfronto: UIImageView!
    
    
    
    
    var parametriStringhe : [String] = ["Beaches", "Museums", "Food", "Reachability", "Relax", "Cheap", "Nature", "Safety", "Weather", "Fun"]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundView = UIImageView (image: #imageLiteral(resourceName: "sfondoDefinitivo"))
        
        let ref = Database.database().reference()
        
        let storage = Storage.storage().reference(withPath: "\(cittàDaConfrontare[0]).jpg")
        
        storage.getData(maxSize: 25*1024*2014) { (data,error) in
            
            self.primaImmagineConfronto.image = UIImage(data: data!)
            
            self.configuraImmagine(immagine: self.primaImmagineConfronto, nomeCittà: self.cittàDaConfrontare[0])
            
        }
        
        let storage2 = Storage.storage().reference(withPath: "\(cittàDaConfrontare[1]).jpg")
        
        storage2.getData(maxSize: 25*1024*2014) { (data,error) in
            
            self.secondaImmagineConfronto.image = UIImage(data: data!)
            
            self.configuraImmagine(immagine: self.secondaImmagineConfronto, nomeCittà: self.cittàDaConfrontare[1])
        
        }
        
        
        
        
        
        //rimuovo le righe grige di separazione
        //self.tableView.separatorStyle = .none
        
        
        //Cerco il figlio sfruttando la label del tile
        ref.child(self.cittàDaConfrontare[0]).observeSingleEvent(of: .value, with: { (snapshot : DataSnapshot) in
            
            //mi prendo il dato come NSDictionary
            let snap = snapshot.value as? NSDictionary
            
            //Lo casto per facilità di utilizzo
            self.arrayDiParametri = (snap as? [String:Int])!
            
            //aggiorno i dati nella tableview
            self.tableView.reloadData()
            
            self.tableView.separatorColor = .white
        })
        
        
        
        //Cerco il figlio , prendo i dati della seconda città da visualizzare
        ref.child(self.cittàDaConfrontare[1]).observeSingleEvent(of: .value, with: { (snapshot2 : DataSnapshot) in
            
            //mi prendo il dato come NSDictionary
            let snap2 = snapshot2.value as? NSDictionary
            
            //Lo casto per facilità di utilizzo
            self.arrayDiParametri2 = (snap2 as? [String:Int])!
            
            //aggiorno i dati nella tableview
            self.tableView.reloadData()
            
            
        })
        
        
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as! confrontoCella
        
        let chiave = parametriStringhe[indexPath.row]
        let rating = arrayDiParametri[chiave]
        var rating2 = arrayDiParametri2[chiave]
        
        let parametro = chiave
        
        //metto il parametro nella cella
        cell.Parametro.text = parametro
        
        var str1 : String = ""
        if (rating != nil){
        for k in  0...4 {
            if k >= rating! {
                str1 = str1 + "☆"
            }
            else {
                str1 = str1 + "★"
            }
            
        }
            
        
        cell.stellePrimaCittà.text = str1
            
        }
        
        var str2 : String = ""
        if (rating2 != nil){
        for k in  0...4 {
            if k >= rating2! {
                str2 = str2 + "☆"
            }
            else {
                str2 = str2 + "★"
            }
            
        }
        
        cell.stelleSecondaCittà.text = str2
        
        }
        
        //cell.backgroundColor = .black
        
        return cell
    }
    
    
    
}
