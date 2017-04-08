//
//  LanguagesViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/3/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse

class LanguagesViewController: UIViewController, SelectLanguageDelegate, MatchedAffiliationsAndProjects {

    
    @IBOutlet weak var tableView: UITableView!
    var currentUser: User!
    let matchHeaderIdentifier = "MatchHeaderView"
    var selectedLanguage: String?
    var matchedAffiliations: [Affiliation] = []
    var matchedProjects: [Project] = []
    var retrievedAffiliations: [Affiliation] = []
    var retrievedProjects: [Project] = []
    var matchedItemsCount: Int?
    var currentLanguageCollection: LanguageCollection?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = User.current()

        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.blue
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.plain, target: self, action: #selector(LanguagesViewController.goToProfile))

        navigationItem.rightBarButtonItems = [nextButton]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: matchHeaderIdentifier)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "Languages"
        
    }
    
    func goToProfile() {
        print("Going to Profile")
        self.performSegue(withIdentifier: "Profile", sender: self)
    }
    
    func didTapSubmit() {
        print("Submitting Match Data")
        
        if currentLanguageCollection != nil && currentLanguageCollection?.language_name == selectedLanguage {
            
            LanguageCollection.updateLanguageCollection(collection: self.currentLanguageCollection!) {
                (success: Bool, error: Error?) -> Void in
                if success {
                    print("Successful Post to Parse")
                    self.fetchMatches()
                    // clear borders on cells
                }
                else {
                    print("Can't post to parse")
                }
            }
        }
        else {
            
            currentLanguageCollection = LanguageCollection.init(user: User.current()!, langName: selectedLanguage!, affiliations: matchedAffiliations, projects: matchedProjects)
            
            LanguageCollection.postLanguageCollectionToParse(collection: currentLanguageCollection!) {
                (success: Bool, error: Error?) -> Void in
                if success {
                    print("Successful Post to Parse")
                    self.fetchMatches()
                    // clear bordres on cells
                }
                else {
                    print("Can't post to parse")
                }
            }
        }
    }
    
    // MARK: - PARSE FETCH METHODS
    
       
    
    
    // MARK: - PROTOCOL METHODS 
    
    func didSelectLanguage(language: String) -> String {
        selectedLanguage = language
        currentLanguageCollection = fetchMatches()
        return selectedLanguage!
    }
    
    func didSelectAffiliation(affiliation: Affiliation) -> Affiliation {
        print("Did select affiliation: \(affiliation)")
        matchedAffiliations.insert(affiliation, at: 0)
        print("Matched affiliation is \(affiliation)")
        print("Printing from array: \(matchedAffiliations[0])")
        return affiliation
    }
    
    func didSelectProject(project: Project) -> Project {
        print("Did select project: \(project)")
        matchedProjects.insert(project, at: 0)
        print("Matched project is \(project)")
        print("Printing from array: \(matchedProjects[0])")
        return project
    }
    
    
    // MARK: - FETCHES FROM PARSE 
    
    func fetchMatches() -> LanguageCollection {
        
        var langCollection = LanguageCollection()
        
        retrievedAffiliations = []
        retrievedProjects = []
        tableView.reloadData()
        
        let query = PFQuery(className: LanguageCollection.parseClassName())
        query.includeKey("affiliations")
        query.includeKey("projects")
        query.order(byDescending: "_created_at")
        query.whereKey("user_name", equalTo: currentUser.username!)
        query.whereKey("language_name", equalTo: selectedLanguage!)
        query.limit = 20
        query.findObjectsInBackground { (matches: [PFObject]?, error: Error?) -> Void in
            
            if let myMatches = matches {
                print("Matched Items: \(myMatches)"
                )
                for match in myMatches {
                    if let match = match as? LanguageCollection {
                        print("matched object cast as languageCollection")
                        langCollection = match
                        if let affMatches = langCollection.affiliations {
                            for affiliation in affMatches{
                                self.retrievedAffiliations.append(affiliation)
                            }
                        }
                        if let projMatches = langCollection.projects{
                            for proj in projMatches {
                                self.retrievedProjects.append(proj)
                                print("First Project is: \(self.retrievedProjects[0].name!)")
                            }
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        return langCollection
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension LanguagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()  
    
    switch indexPath.section {
    case 0:
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PickLanguageCell", for: indexPath) as! PickLanguageCell
        cell1.selectLanguageDelegate = self
        return cell1

    case 1:
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
        
            matchedItemsCount = retrievedProjects.count + retrievedAffiliations.count
            cell2.cellSection = 1
            cell2.selectedLanguage = selectedLanguage
        
            if selectedLanguage != nil {
                print("selected Language: \(selectedLanguage!)")
                print("number of Items: \(matchedItemsCount!)")
            }
        
            cell2.matchedItemsCount = matchedItemsCount
            cell2.retrievedAffiliations = retrievedAffiliations
            cell2.retrievedProjects = retrievedProjects
            cell2.collectionView.reloadData()
     
        return cell2
        
    case 2:
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
            cell3.cellSection = 2
            cell3.selectedAffiliationsDelegate = self
        return cell3
        
    case 3:
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "AffProjCell", for: indexPath) as! AffProjCell
            cell4.cellSection = 3
            cell4.selectedProjectsDelegate = self 
        return cell4
        
    default:
        break
    }


    return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
        
        switch section {
        case 0:
            return "Select Language"
        case 1:
            return "Matched Affiliations & Projects"
        case 2:
            return "Affiliations"
        case 3:
            return "Projects"
        default:
            break
        }
        return nil
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        if section == 1 {
            headerView.backgroundColor = UIColor.groupTableViewBackground
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
            label.center = CGPoint(x: 150, y: 15)
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            
            if selectedLanguage != nil {
                label.text = "\(selectedLanguage!) Affiliations and Projects"
            } else {
                print("No selected language")
                label.text = "My matched affiliations and projects for [xxx]"
            }
            
            // get selected language
            
            headerView.addSubview(label)
            
            let submitButton = UIButton(frame: CGRect(x: 300, y: 0, width: 50, height: 30))
            submitButton.backgroundColor = UIColor.red
            submitButton.titleLabel?.text = "Submit"
            submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
            headerView.addSubview(submitButton)
            
            return headerView
        }
        
        return nil
    }
    
    
}

