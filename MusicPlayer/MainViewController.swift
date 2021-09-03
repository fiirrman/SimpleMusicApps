//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Firman Aminuddin on 8/20/21.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var fieldSearchSong: UITextField!
    @IBOutlet weak var labelSearch: UILabel!
    @IBOutlet weak var tableViewMain: UITableView!
    @IBOutlet weak var constraintBottomTableview: NSLayoutConstraint!
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var sliderProgressSong: UISlider!
    
    var listSong = [PLAYLIST]()
    var listSongTemp = [PLAYLIST]()
    var isPlay = false
    var playManage = PlaylistManagement.shared
    var currentIndex = 0
    var songLength = Float()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI() // Set UI initializer
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewMain.reloadData()
    }
    
    func initUI(){
        hideKeyboardWhenTappedAround()
        fieldSearchSong.delegate = self
        fieldSearchSong.becomeFirstResponder()
        sliderProgressSong.value = 0.0
    }
    
    func initTableView(){
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        tableViewMain.tableFooterView = UIView()
        tableViewMain.register(UINib(nibName: CellMain.identifier, bundle: nil), forCellReuseIdentifier: CellMain.identifier)
    }
    
    // MARK: UI INITIALIZER
    func showPlayer(urlPreview : String){
        constraintBottomTableview.constant = screenHeight * 0.15
        tableViewMain.layoutIfNeeded()
        viewPlayer.isHidden = false
        
        initSong(url: urlPreview, setPlay: false)
    }
    
    func hidePlayer(){
        constraintBottomTableview.constant = 0
        tableViewMain.layoutIfNeeded()
        viewPlayer.isHidden = true
    }
    
    func initSong(url : String, setPlay : Bool){
        playManage.initSong(url: url)
        isPlay = setPlay
        actionPlay(self)
        
        let duration : CMTime = (playManage.player.currentItem?.asset.duration)!
        songLength = Float(CMTimeGetSeconds(duration))
        
        sliderProgressSong.value = 0.0
        sliderProgressSong.maximumValue = songLength
        playManage.playSong()
        playManage.songTime?.invalidate()
        playManage.songTime = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    
    @objc func updateSlider(){
        let currentDuration : CMTime = (playManage.player.currentTime())
        let currentLength = Float(CMTimeGetSeconds(currentDuration))
        
        sliderProgressSong.value = currentLength
        print("Changing works")
    }
    
    func reArrangeData(index : Int){
        for i in 0 ..< listSong.count{
            if(i == index){
                listSong[i].isPlay = true
            }else{
                listSong[i].isPlay = false
            }
        }
        tableViewMain.reloadData()
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        if isPlay {
            isPlay = false
            btnPlay.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            playManage.pauseSong()
        }else{
            isPlay = true
            btnPlay.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            playManage.playSong()
            
        }
    }
    
    @IBAction func actionBackward(_ sender: Any) {
        if currentIndex > 0{
            currentIndex = currentIndex - 1
            reArrangeData(index: currentIndex)
        }
        
        initSong(url: listSong[currentIndex].previewURL, setPlay: false)
    }
    
    @IBAction func actionForward(_ sender: Any) {
        if currentIndex + 1 < listSong.count{
            currentIndex = currentIndex + 1
            reArrangeData(index: currentIndex)
        }
        
        initSong(url: listSong[currentIndex].previewURL, setPlay: false)
    }
    
    // MARK: API CALL
    func fetchSearchData(textSearch : String){
        labelSearch.text = "Searching..."
        NetworkManager.fetchList(query: "term=\(textSearch.replacingOccurrences(of: " ", with: "+"))&limit=10",vc: self) { [weak self] (listArtist) in
            DispatchQueue.main.async { [self] in
                if listArtist.count == 0{
                    self!.showErrorAlert(errorMsg: "Cant find what you're looking for", isAction: false, title: "", typeAlert: "", titleSingleButton: "Got it")
                }else{
                    self!.listSong = []
                    self!.listSong = listArtist
                    self!.hidePlayer()
                    self?.tableViewMain.reloadData()
                }
                
                self!.labelSearch!.text = "Done"
                self!.labelSearch!.layoutIfNeeded()
            }
        }
    }
}

extension MainViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchSearchData(textSearch: textField.text! as String)
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        screenHeight * 0.15
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listSong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMain.identifier, for: indexPath) as! CellMain
        
        cell.selectionStyle = .gray
        downloadImage(listSong[indexPath.row].imageName) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.imageAlbum.image = image
                }
            }
        }
        cell.songName.text = listSong[indexPath.row].songName
        cell.albumName.text = listSong[indexPath.row].albumName
        cell.artistName.text = listSong[indexPath.row].artistName
        
        if listSong[indexPath.row].isPlay {
            cell.imageCurrentPlay.isHidden = false
        }else{
            cell.imageCurrentPlay.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        reArrangeData(index: currentIndex)
        showPlayer(urlPreview : listSong[currentIndex].previewURL)
    }
}

