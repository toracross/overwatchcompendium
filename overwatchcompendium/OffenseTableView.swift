//
//  OffenseTableView.swift
//  overwatchcompendium
//
//  Created by Wellison Pereira on 12/12/16.
//  Copyright © 2016 Wellison Pereira. All rights reserved.
//

import UIKit

class OffenseTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //TableView Delegates
        tableView.delegate = self
        tableView.dataSource = self
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "offenseCell", for: indexPath) as? OffenseCell {
            return cell
        } else {
            return OffenseCell()
        }
    }


}
