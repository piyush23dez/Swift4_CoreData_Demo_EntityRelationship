

import UIKit
import CoreData

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.fetch()
        }
    }
    
    func save() {
        let father: Father = NSEntityDescription.insertNewObject(forEntityName: "Father", into: context) as! Father
        father.id = 1
        father.name = "Mahesh"
    
        let son1: Son = NSEntityDescription.insertNewObject(forEntityName: "Son", into: context) as! Son
        son1.id = 1
        son1.name = "Nitesh"

        let son2: Son = NSEntityDescription.insertNewObject(forEntityName: "Son", into: context) as! Son
        son2.id = 1
        son2.name = "Udit"
        
        father.addToSon(son1)
        father.addToSon(son2)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch() {
        do {
            //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Father")
            let request: NSFetchRequest<Father> = Father.fetchRequest()
            let fathers = try context.fetch(request)
            
            if let father = fathers.first {
                print(father.name ?? "")
                for son in father.son ?? [] {
                    
                    if let kid = son as? Son {
                        print(kid.name ?? "")
                    }
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

