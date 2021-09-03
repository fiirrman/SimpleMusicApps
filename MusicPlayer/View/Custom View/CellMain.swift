//
//  CellMain.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 8/31/21.
//

import UIKit

class CellMain: UITableViewCell {
    
    static var identifier = "CellMain"

    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var imageCurrentPlay: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
