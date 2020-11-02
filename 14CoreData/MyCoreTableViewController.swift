import UIKit
import CoreData

class MyCoreTableViewController: UITableViewController {

    var tasks: [NSManagedObject] = []

    
    @IBAction func addButton(_ sender: Any) {
        let alertContrl = UIAlertController(title: "Create item", message: nil, preferredStyle: .alert)
        alertContrl.addTextField { (textField) in
            textField.placeholder = "name item"
        }
        let canBtn = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        let btn = UIAlertAction(title: "add", style: .cancel) { alert in
            guard let textField = alertContrl.textFields?.first,
                let nameToSave = textField.text else {
                  return
              }
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        alertContrl.addAction(btn)
        alertContrl.addAction(canBtn)
        present(alertContrl, animated: true, completion: nil)
    }
    @IBAction func editBtn(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoEntities")
      do {
        tasks = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tasks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = item.value(forKeyPath: "name") as? String
        if (item.value(forKeyPath: "isComp") as? Bool)! {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = tasks[indexPath.row]
        if (item.value(forKeyPath: "isComp") as? Bool)!  {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            item.setValue(true, forKeyPath: "isComp")
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//        MainCore.shared.moveItem(f: fromIndexPath.row, to: to.row)
        tableView.reloadData()
    }

    func save(name: String) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
      }
      // 1
      let managedContext = appDelegate.persistentContainer.viewContext
      // 2
      let entity = NSEntityDescription.entity(forEntityName: "ToDoEntities", in: managedContext)!
      let task = NSManagedObject(entity: entity, insertInto: managedContext)
      // 3
      task.setValue(name, forKeyPath: "name")
      task.setValue(false, forKeyPath: "isComp")
      // 4
      do {
        try managedContext.save()
        tasks.append(task)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}
