//
//  ViewController.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import SwiftUI
import ESPullToRefresh

class GeneralViewController: UIViewController {
    
    let generalView = GeneralView()
    var profile: ProfileModel?
    var page = 0
    private let reuseIdentifierTableView = "CellTableView"
    private let apiKey = "5f76114aee814760aa190c69"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPullToRefresh()
    }
    
    private func urlGenerator() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dummyapi.io"
        urlComponents.path = "/data/api/user/"
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "app-id")
        
        return request
    }
    
    private func setupPullToRefresh() {
        generalView.tableView.es.addInfiniteScrolling { [unowned self] in
            self.loadMore()
        }
        
        generalView.tableView.es.addPullToRefresh { [unowned self] in
            self.refresh()
        }
        
        refresh()
    }
    
    
    private func loadMore() {
        guard let apiData = profile else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.page += 1
            if self.page <= apiData.total {
                
                let request = self.urlGenerator()
                
                Network.shared.fetchData(for: request, model: ProfileModel.self) { result in
                    
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert(title: "Ошибка!", message: error.localizedDescription)
                        }
                    case .success(let profile):
                        if let profiles = profile.data {
                            for profile in profiles {
                                self.profile?.data?.append(profile)
                            }
                            
                            self.generalView.tableView.reloadData()
                            self.generalView.tableView.es.stopLoadingMore()
                        }
                    }
                }
            } else {
                self.generalView.tableView.es.noticeNoMoreData()
            }
        }
    }
    
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.page = 0
            self.profile = ProfileModel()
            
            let request = self.urlGenerator()
            
            Network.shared.fetchData(for: request, model: ProfileModel.self) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Ошибка!", message: error.localizedDescription)
                    }
                case .success(let profile):
                    self.profile = profile
                    self.generalView.tableView.es.stopPullToRefresh()
                    self.generalView.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(generalView)
        generalView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            generalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            generalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            generalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            generalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        
        generalView.tableView.delegate = self
        generalView.tableView.dataSource = self
        generalView.tableView.separatorStyle = .none
        generalView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
    }
}

// MARK: - Extension: UITableViewDelegate, UITableViewDataSource
extension GeneralViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! ProfileTableViewCell
        
        guard let profile = profile?.data?[indexPath.row] else { return UITableViewCell() }
        cell.configure(profile: profile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let first = profile?.data?[indexPath.row].firstName else { return }
        guard let last = profile?.data?[indexPath.row].lastName else { return }
        guard let pic = tableView.cellForRow(at: indexPath) as? ProfileTableViewCell else { return }
        let swiftUIController =
            UIHostingController(rootView: SwiftUIProfile(firstName: first, lastName: last, picture: pic.imagePicture))
        navigationController?.pushViewController(swiftUIController, animated: true)
    }
}
