import UIKit
import CoreData

class MyCoreTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MainCore.shared.getTasks()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MainCore.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = MainCore.shared.tasks[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = item.name
        if item.isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MainCore.shared.DeleteTask(task: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.allowsSelectionDuringEditing {
            let alertContrl = UIAlertController(title: "Change item", message: nil, preferredStyle: .alert)
            alertContrl.addTextField { (textField) in
                textField.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
            }
            let canBtn = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
            let btn = UIAlertAction(title: "save", style: .cancel) { alert in
                guard let textField = alertContrl.textFields?.first,
                    let nameToSave = textField.text else {
                      return
                  }
                MainCore.shared.changeName(at: indexPath.row, name: nameToSave)
                //print(Main.shared.Items.count)
                self.tableView.reloadData()
            }
            alertContrl.addAction(btn)
            alertContrl.addAction(canBtn)
            present(alertContrl, animated: true, completion: nil)
           
//            self.tableView.reloadData()
        }else{
            if MainCore.shared.changeState(at: indexPath.row){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        MainCore.shared.moveItem(f: fromIndexPath.row, to: to.row)
        tableView.reloadData()
    }
    
    @IBAction func addButton(_ sender: Any) {
        let alertContrl = UIAlertController(title: "Create item", message: nil, preferredStyle: .alert)
        alertContrl.addTextField { (textField) in
            textField.placeholder = "name item"
        }
        let canBtn = UIAlertAction(title: "cancel", style: .destructive, handler: nil)
        let btn = UIAlertAction(title: "add", style: .cancel) { alert in
            guard let textField = alertContrl.textFields?.first,
                let nameToSave = textField.text else { return }
            MainCore.shared.save(name: nameToSave)
            self.tableView.reloadData()
        }
        alertContrl.addAction(btn)
        alertContrl.addAction(canBtn)
        present(alertContrl, animated: true, completion: nil)
    }
    @IBAction func editBtn(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.allowsSelectionDuringEditing = !tableView.allowsSelectionDuringEditing

    }

}
