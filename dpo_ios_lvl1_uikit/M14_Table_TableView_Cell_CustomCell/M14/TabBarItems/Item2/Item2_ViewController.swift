//
//  Item2_ViewController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit


// Вкладка 2 - Задание 2

class Item2_ViewController: UIViewController {
    
    let cellId = "00_07"
    var sortedSections: [SectionModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableHeaderView = tableHeader
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var tableHeader: UILabel = {
        let header = UILabel(frame: CGRect(x: 9, y: 9, width: 100, height: 50))
        header.text = "Последние новости"
        header.font = .boldSystemFont(ofSize: CGFloat(24))
        return header
    }()
    
    private lazy var cell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Задание 2"
        
        initializeTable()
        setupConstraints()
        
        // convert models
        let withDateModels = Constants.News.Models.map( { convertModelToDate(model: $0) })
        let newDict = convertArrayToDictionary(arr: withDateModels)
        let sectionModels = newDict.map({ SectionModel(date: $0.key, news: $0.value) })
        self.sortedSections = sectionModels.sorted(by: { $0.date > $1.date })

    }
    
    private func initializeTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
        tableHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableHeader.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 10).isActive = true
    }
    
    private func convertArrayToDictionary(arr: [NewsRecordModelDate]) -> [Date : [NewsRecordModelDate]] {
        let newDict = Dictionary(grouping: arr, by: \.publishedAt)
        return newDict
    }
    
    private func convertModelToDate(model: NewsRecordModel) -> NewsRecordModelDate {
        let formatterReader = DateFormatter()
        formatterReader.locale = Locale.current
        formatterReader.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        
        guard let readDate = formatterReader.date(from: model.publishedAt) else {
            print("Couldn't convert date string to Date 1")
            return NewsRecordModelDate(title: "Date Convertation Error 1", publishedAt: Date())
        }
        let formatterPrinter = DateFormatter()
        formatterPrinter.timeZone = TimeZone(abbreviation: "UTC")
        formatterPrinter.dateFormat = "dd-MM-yyyy"
        
        guard let newDate = formatterPrinter.date(from: formatterPrinter.string(from: readDate)) else {
            print("Couldn't convert date string to Date 2")
            return NewsRecordModelDate(title: "Date Convertation Error 2", publishedAt: Date())
        }
        let newRecordModel = NewsRecordModelDate(title: model.title, publishedAt: newDate)
        return newRecordModel
    }
    
}


extension Item2_ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedSections.count
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection sectionNum: Int) -> String? {
        let sectionDate = self.sortedSections[sectionNum].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: sectionDate)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = self.sortedSections[section].news.count
        return rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)

        cell?.textLabel?.text = self.sortedSections[indexPath.section].news[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}

extension Item2_ViewController: UITableViewDelegate {}
