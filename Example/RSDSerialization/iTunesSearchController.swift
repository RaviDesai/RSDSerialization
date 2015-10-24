//
//  ViewController.swift
//  RSDSerialization
//
//  Created by RaviDesai on 08/03/2015.
//  Copyright (c) 2015 RaviDesai. All rights reserved.
//

import UIKit

class iTunesSearchController: UIViewController, UITableViewDelegate {
    var viewModel: iTunesSearchViewModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    func ensureViewModelIsConstructed() {
        if (viewModel != nil) { return }
        
        viewModel = iTunesSearchViewModel(callback: { (tableView, indexPath, content) -> UITableViewCell in
            let cell = tableView.dequeueReusableCellWithIdentifier("iTunesSeachCell") as! iTunesSearchTableViewCell
            cell.populateLabels(content)
            return cell
        }, searchCallback:{ ()->() in
            self.tableView.reloadData()
        })
    }
    
    func instantiateControlsFromViewModel() {
        self.tableView.dataSource = viewModel
        self.searchBar.delegate = viewModel
        self.searchBar.text = viewModel!.searchText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ensureViewModelIsConstructed()
        self.instantiateControlsFromViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

