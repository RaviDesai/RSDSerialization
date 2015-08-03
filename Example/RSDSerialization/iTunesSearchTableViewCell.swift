//
//  iTunesSearchTableViewCell.swift
//  RSDSerialization
//
//  Created by Ravi Desai on 8/3/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import RSDSerialization

class iTunesSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var totalTracksLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func populateLabels(content: Content?) {
        if let contentForLabel = content {
            artistLabel.text = contentForLabel.ArtistName
            albumLabel.text = contentForLabel.CollectionName
            trackNumberLabel.text = "\(contentForLabel.TrackNumber)"
            totalTracksLabel.text = "\(contentForLabel.TrackCount)"
            trackLabel.text = "\(contentForLabel.TrackName)"
            releaseDateLabel.text = toStringFromDate("MM-dd-yyyy", contentForLabel.ReleaseDate)
        } else {
            trackLabel.text = "Missing data"
        }
    }
}