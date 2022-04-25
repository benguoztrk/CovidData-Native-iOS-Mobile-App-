//
//  MainVC.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//
import SideMenu
import UIKit
import AVFoundation

class MainVC: UIViewController, MenuListControllerDelegate {
    
    var audioPlayer: AVAudioPlayer!
   

    // implementing sound to a button
    @IBAction func mSoundBarButton(_ sender: UIBarButtonItem) {
        playSound()
    }
    
    func playSound() {
        
        let urlString = Bundle.main.path(forResource: "btnsound", ofType: "mp3")
        
        do  {
            
            guard let urlString = urlString  else{
                return
            }
         audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
        }
        catch{
            
            print ("Something went wrong")
            
        }
        
        
        audioPlayer.play()
    }
    
    
    
    @IBAction func onDoubleTap(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "jsonvc", sender: self)
    }
    
    @IBAction func didOpenMenu(){
        present(sideMenu!, animated: true)
   }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        
    }

    //implementing an extarnal library SideMenu using CocoaPods.
    private var sideMenu: SideMenuNavigationController?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let menu = MenuListController(with: ["Home", "Info"])
        menu.delegate = self

        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
       
        //swiping to open the menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }

    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            if named == "Home" {
                self?.view.backgroundColor = .white
            }
            else if named == "Info"{
                self?.performSegue(withIdentifier: "infovc", sender: self)
            }
          }
        )
    }
}

protocol MenuListControllerDelegate {  //protoccol of delagate below
    func didSelectMenuItem(named: String)
}


class MenuListController: UITableViewController{
    
    public var delegate: MenuListControllerDelegate? //creating delegate
    
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName:nil, bundle:nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let darkColor = UIColor(red: 221/255, green: 231/255, blue: 255/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menuItems[indexPath.row] //every time we select an item this function called
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}
