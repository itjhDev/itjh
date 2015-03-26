//
//  SearchResultsController.swift
//  Sections
//
//  Created by Kim Topley on 10/11/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

import UIKit

private let longNameSize = 6
private let shortNamesButtonIndex = 1
private let longNamesButtonIndex = 2

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names:[String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UISearchResultsUpdating Conformance
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        filteredNames.removeAll(keepCapacity: true)

        if !searchString.isEmpty {
            let filter: String -> Bool = { name in
                // Filter out long or short names depending on which
                // scope button is selected.
                let nameLength = countElements(name)
                if (buttonIndex == shortNamesButtonIndex
                            && nameLength >= longNameSize)
                        || (buttonIndex == longNamesButtonIndex
                            && nameLength < longNameSize) {
                    return false
                }
                
                let range = name.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range != nil
            }
            
            for key in keys {
                let namesForKey = names[key]!
                let matches = namesForKey.filter(filter)
                filteredNames += matches
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier) as UITableViewCell
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }
}
