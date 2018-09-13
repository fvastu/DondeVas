//
//  NuovaRecensioneViewController.swift
//  ProgettoViaggio
//
//  Created by Francesco Vasturzo on 12/06/17.
//  Copyright © 2017 Sofia Silvestri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class NuovaRecensioneViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bottoneNuova: UIButton!
    //qui metto la città di cui si vuole aggiornare o caricare una nuova recensione
    var nuovaCittà : String = ""
    var dataCittàEsistente = Data()
    var data2 = Data()
    var dataNil = Data()
    
    
    
    @IBOutlet weak var immagine: UIImageView!
    
    @IBOutlet var starButton: [UIButton]!
    @IBOutlet var starButton2: [UIButton]!
    @IBOutlet var starButton3: [UIButton]!
    @IBOutlet var starButton4: [UIButton]!
    @IBOutlet var starButton5: [UIButton]!
    @IBOutlet var starButton6: [UIButton]!
    @IBOutlet var starButton7: [UIButton]!
    @IBOutlet var starButton8: [UIButton]!
    @IBOutlet var starButton9: [UIButton]!
    @IBOutlet var starButton10: [UIButton]!
    
    //è fisso, è gia presente in dettaglio città ma "non viene visto"
    let parametriStringhe : [String] = ["Beaches", "Museums", "Food", "Reachability", "Relax", "Cheap", "Nature", "Safety", "Weather", "Fun"]
    
    //all'ultimo elemento del vettore trovo il numero di recensioni
    var arrayConValutazioni = [0,0,0,0,0,0,0,0,0,0]
    var numeroRecensioni = 0
    var arrayDiParametri : [String:Int] = [:]
    
    
    
    @IBAction func tapFoto(_ sender: UITapGestureRecognizer) {
        
        let p = UIImagePickerController()
        p.sourceType = .photoLibrary
        p.delegate = self
        present(p, animated:  true, completion:  nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let immagineFatta = info[UIImagePickerControllerOriginalImage] as! UIImage
        immagine.image = immagineFatta
        dismiss(animated: true, completion: nil)
        data2 = UIImageJPEGRepresentation(immagineFatta, 0.6)!
        
    }
    
    
    
    
    
    
    @IBAction func caricaDati(_ sender: UIButton) {
        
        let ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

                //Essendo la prima volta che "vedo" quella città vado a
                //scrivere i valori e metti _Recensioni pari a 1
                //in parametri stringhe trovo beaches e tutto il resto
                //in array con valutazioni,che di default è settato a zero
                //trovo tutti i parametri ricavati dalle stelline
                ref.child(self.nuovaCittà).setValue([self.parametriStringhe[0] : self.arrayConValutazioni[0],
                                              self.parametriStringhe[1] : self.arrayConValutazioni[1],
                                              self.parametriStringhe[2] : self.arrayConValutazioni[2],
                                              self.parametriStringhe[3] : self.arrayConValutazioni[3],
                                              self.parametriStringhe[4] : self.arrayConValutazioni[4],
                                              self.parametriStringhe[5] : self.arrayConValutazioni[5],
                                              self.parametriStringhe[6] : self.arrayConValutazioni[6],
                                              self.parametriStringhe[7] : self.arrayConValutazioni[7],
                                              self.parametriStringhe[8] : self.arrayConValutazioni[8],
                                              self.parametriStringhe[9] : self.arrayConValutazioni[9],
                                              "_Recensioni": 1 ])
                
                let storageRef = Storage.storage().reference()
                let fotoRef = storageRef.child("\(self.nuovaCittà.lowercased().capitalized).jpg")
                
                if (self.data2.isEmpty == false)
                {
                let uploadTask = fotoRef.putData(self.data2, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                        }
                    }
                }
                    
                else{
                    self.dataNil = UIImageJPEGRepresentation(#imageLiteral(resourceName: "immagineGrigia"), 0.6)!
                    let uploadTask = fotoRef.putData(self.dataNil, metadata: nil) { (metadata, error) in
                        guard let metadata = metadata else {
                            // Uh-oh, an error occurred!
                            return
                        }
                    }
                    
                }
        })
        
        
}

            
        


    @IBAction func starButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        for button in starButton {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[0] = tag
        print(arrayConValutazioni)
        
    }
    
    
    @IBAction func starButtonTapped2(_ sender: UIButton) {
        let tag = sender.tag
        for button in starButton2 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[1] = tag
        print(arrayConValutazioni)
    }


    @IBAction func starButtonTapped3(_ sender: UIButton) {
        let tag = sender.tag
        for button in starButton3 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[2] = tag
        print(arrayConValutazioni)
        
        
    }
    
    @IBAction func starButtonTapped4(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton4 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[3] = tag
        print(arrayConValutazioni)
        
    }
    
    @IBAction func starButtonTapped5(_ sender: UIButton) {
        let tag = sender.tag
        for button in starButton5 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[4] = tag
        print(arrayConValutazioni)
        
        
    }
    
    
    @IBAction func starButtonTapped6(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton6 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[5] = tag
        print(arrayConValutazioni)
        
    }

    @IBAction func starButtonTapped7(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton7 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[6] = tag
        print(arrayConValutazioni)
        
        
        
    }
    
    @IBAction func starButtonTapped8(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton8 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[7] = tag
        print(arrayConValutazioni)
}

        


    @IBAction func starButtonTapped9(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton9 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[8] = tag
        print(arrayConValutazioni)
    }
    
    
    @IBAction func starButtonTapped10(_ sender: UIButton) {
        
        let tag = sender.tag
        for button in starButton10 {
            if button.tag <= tag {
                button.setTitle("★", for: .normal)
            }
            else {
                button.setTitle("☆", for: .normal)
            }
        }
        arrayConValutazioni[9] = tag
        print(arrayConValutazioni)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         //self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       immagine.image = #imageLiteral(resourceName: "placeholder")

        bottoneNuova.layer.borderWidth = 1
        bottoneNuova.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func prelevaDatiFirebase () {
        
        //Mi creo un riferimento al database
        let ref = Database.database().reference()
        
        //Cerco il figlio sfruttando la label del tile
        ref.child(self.nuovaCittà).observeSingleEvent(of: .value, with: { (snapshot : DataSnapshot) in
            
            //mi prendo il dato come NSDictionary
            let snap = snapshot.value as? NSDictionary
            
            //Lo casto per facilità di utilizzo
            self.arrayDiParametri = (snap as? [String:Int])!
            
            self.aggiornaDatiFirebase()
            
        })
        
        
    } //chiudo la funzione prelevataDatiFirebase
    
    
    func aggiornaDatiFirebase () {
        
        
        let ref = Database.database().reference()
        
        let dimensione = parametriStringhe.count
        
        for i in 0...(dimensione-1){
            if ( arrayDiParametri[parametriStringhe[i]] != nil)
            {
                arrayConValutazioni[i] = Int((arrayConValutazioni[i] + self.arrayDiParametri[parametriStringhe[i]]!)/2)
            }
        }
        
        //Aggiorna il numero di recensioni
        if ( arrayDiParametri[parametriStringhe[dimensione-1]] != nil)
        {
            numeroRecensioni = Int(self.arrayDiParametri["_Recensioni"]!) + 1
        }
        
        //ricarica i dati
        ref.child(self.nuovaCittà).setValue([self.parametriStringhe[0] : self.arrayConValutazioni[0],
                                      self.parametriStringhe[1] : self.arrayConValutazioni[1],
                                      self.parametriStringhe[2] : self.arrayConValutazioni[2],
                                      self.parametriStringhe[3] : self.arrayConValutazioni[3],
                                      self.parametriStringhe[4] : self.arrayConValutazioni[4],
                                      self.parametriStringhe[5] : self.arrayConValutazioni[5],
                                      self.parametriStringhe[6] : self.arrayConValutazioni[6],
                                      self.parametriStringhe[7] : self.arrayConValutazioni[7],
                                      self.parametriStringhe[8] : self.arrayConValutazioni[8],
                                      self.parametriStringhe[9] : self.arrayConValutazioni[9],
                                      "_Recensioni": self.numeroRecensioni])
        
    }//chiudo la funzione aggiorna Dati
    
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
        label.font = UIFont(name: "Times New Roman", size: CGFloat(40))
        
        immagine.addSubview(label)
        
        
    }

}
