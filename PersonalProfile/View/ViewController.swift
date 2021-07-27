//
//  ViewController.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/17/21.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataManager: DataManager?
    var profileViewModel:ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: NameAndPhotoCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: NameAndPhotoCell.nibName)
        tableView.register(UINib(nibName: FriendCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: FriendCell.nibName)
        tableView.register(UINib(nibName: AttributeCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: AttributeCell.nibName)
        tableView.register(UINib(nibName: EmailCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: EmailCell.nibName)
        
        dataManager = DataManager()
        dataManager?.completion = { [weak self] result in
            switch result {
            case .success(let profile) :
                self?.profileViewModel = ProfileViewModel(profile: profile)
            case .failure(let error) :
                debugPrint(error.localizedDescription)
            }
        }
        dataManager?.getProfile()
    }
    
}

extension ViewController: UITableViewDataSource,
                          UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileViewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel?.items[section].rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let items = profileViewModel?.items else { return 50 }
        let item = items[indexPath.section]
        
        switch item.type {
            case .nameAndPicture,.friend : return 120
            default: return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = Bundle.main.loadNibNamed(ProfileSectionHeader.nibName, owner: self, options: nil)?.first as? ProfileSectionHeader,
           let items = profileViewModel?.items {
            headerView.sectionLabel.text = items[section].sectionTitle
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = profileViewModel?.items else { return UITableViewCell() }
        let item = items[indexPath.section]
        
        switch item.type {
        case .nameAndPicture:
            if let  cell = tableView.dequeueReusableCell(withIdentifier: NameAndPhotoCell.nibName, for: indexPath) as? NameAndPhotoCell {
                cell.photoImage.layer.masksToBounds = true
                cell.photoImage.layer.cornerRadius = 50
                cell.photoImage.clipsToBounds = true
                cell.item = item
                return cell
            }
        case .about:
            if let  cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.nibName, for: indexPath) as? EmailCell {
                cell.isEmail = ProfileViewModelType.about
                cell.item = item
                return cell
            }
        case .email:
            if let  cell = tableView.dequeueReusableCell(withIdentifier: EmailCell.nibName, for: indexPath) as? EmailCell {
                cell.isEmail = ProfileViewModelType.email
                cell.item = item
                return cell
            }
        case .friend:
            if let  cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.nibName,
                                                         for: indexPath) as? FriendCell ,
               let profile = item as? ProfileFriend {
                cell.photoImage.layer.masksToBounds = true
                cell.photoImage.layer.cornerRadius = 50
                cell.photoImage.clipsToBounds = true
                cell.friend = profile.friends[indexPath.row]
                return cell
            }
        case .attribute:
            if let  cell = tableView.dequeueReusableCell(withIdentifier: AttributeCell.nibName, for: indexPath) as? AttributeCell,                 let attributes = item as? Attributes {
                cell.item = attributes.attributes[indexPath.row]
                return cell

            }
        }
        return UITableViewCell()
    }
}

