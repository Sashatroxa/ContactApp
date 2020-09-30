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

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainView = GeneralView()
    private let reuseIdentifierTableView = "CellTableView"
    var apiData: AllData?
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        getApiData()
        setupPullToRefresh()
    }
    
    // Mark: WorkWithPagination
    
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
        request.setValue("5f673807c6cba67fb8284491", forHTTPHeaderField: "app-id")
        
        return request
    }
    
    private func setupPullToRefresh() {
        mainView.tableView.es.addInfiniteScrolling { [unowned self] in
            self.loadMore()
        }
        
        mainView.tableView.es.addPullToRefresh { [unowned self] in
            self.refresh()
        }
        
        refresh()
    }
    
    private func loadMore() {
        guard let apiData = apiData else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.page += 1
            if self.page <= apiData.total {
                
                let request = self.urlGenerator()
                
                fetchData(for: request, model: AllData.self) { article in
                    if let articles = article, let allData = articles.data {
                        for forArticle in allData {
                            self.apiData?.data?.append(forArticle)
                        }
                        
                        self.mainView.tableView.reloadData()
                        self.mainView.tableView.es.stopLoadingMore()
                    }
                }
            } else {
                self.mainView.tableView.es.noticeNoMoreData()
            }
        }
    }
    
    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.page = 0
            self.apiData = AllData()
            
            let request = self.urlGenerator()
            
            fetchData(for: request, model: AllData.self) { article in
                if let articles = article {
                    self.apiData = articles
                    self.mainView.tableView.es.stopPullToRefresh()
                    self.mainView.tableView.reloadData()
                }
            }
        }
    }
    
    //Mark: Config View
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.mainView.tableView.delegate = self
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.separatorStyle = .none
        self.mainView.tableView.register(TableCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
    }
    
    // Mark: Work with TableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiData?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! TableCell
        let pictureUrl = URL(string: self.apiData?.data?[indexPath.row].picture ?? "")
        cell.imagePicture.load(url:pictureUrl!)
        cell.firstName.text = self.apiData?.data?[indexPath.row].firstName
        cell.lastName.text = self.apiData?.data?[indexPath.row].lastName
        cell.selectionStyle = .none
        cell.imagePicture.layer.cornerRadius = 50
        cell.imagePicture.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let first = apiData?.data?[indexPath.row].firstName else {return}
        guard let last = apiData?.data?[indexPath.row].lastName else {return}
        guard let pic = apiData?.data?[indexPath.row].picture else {return}
        let swiftUIController =
            UIHostingController(rootView: SwiftUIView(firstName: first, lastName: last, picture: pic))
        navigationController?.pushViewController(swiftUIController, animated: true)
    }
    
    //Mark: Work with API
    
    func getApiData() {
        getAllData() { (result) in
            switch result {
            case .success(let data):
                self.apiData = data
                self.mainView.tableView.reloadData()
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

