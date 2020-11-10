import UIKit

class MyTableViewController: UITableViewController {

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Main.shared.loadUsersData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Main.shared.Items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let curItem = Main.shared.Items[indexPath.row]
        
        cell.textLabel?.text = curItem.name
        if curItem.isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Main.shared.removeItem(at: indexPath.row)
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
                Main.shared.changeName(at: indexPath.row, name: nameToSave)
                //print(Main.shared.Items.count)
                self.tableView.reloadData()
            }
            alertContrl.addAction(btn)
            alertContrl.addAction(canBtn)
            present(alertContrl, animated: true, completion: nil)
           
//            self.tableView.reloadData()
        }else{
            if Main.shared.changeState(at: indexPath.row){
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        Main.shared.moveItem(f: fromIndexPath.row, to: to.row)
        tableView.reloadData()

    }
    
    @IBAction func editTableBrn(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.allowsSelectionDuringEditing = !tableView.allowsSelectionDuringEditing
    }
    @IBAction func addItemBtn(_ sender: Any) {
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
            Main.shared.addItem(nameItem: nameToSave)
            //print(Main.shared.Items.count)
            self.tableView.reloadData()
        }
        alertContrl.addAction(btn)
        alertContrl.addAction(canBtn)
        present(alertContrl, animated: true, completion: nil)
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
