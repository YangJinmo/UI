//
//  TableViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: - Constants
    
    private let websites: [Website] = [
        Website(
            title: "GitHub",
            urlString: "https://github.com/YangJinmo"
        ),
        Website(
            title: "Notion",
            urlString: "https://www.notion.so/zzimss/zzimss-085677b5dff74118b3cbafd68adee38b"
        ),
        Website(
            title: "Naver",
            urlString: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=동탄호수공원"
        ),
        Website(
            title: "NaverMap",
            urlString: "https://m.map.naver.com/search2/search.naver?query=동탄호수공원&sm=hty&style=v5"
        ),
        Website(
            title: "",
            urlString: ""
        ),
        Website(
            title: "abc",
            urlString: "abc"
        ),
    ]

    // MARK: - Views

    private lazy var tableView: BaseTableView = {
        let tableView: BaseTableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DividerTableViewCell.self)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()

        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.delegate = self
    }

    // MARK: - Methods

    private func setupViews() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let website: Website = websites[indexPath.row]
        let vc = WebViewController(urlString: website.urlString, titleText: website.title)
        pushViewController(vc)
    }
}

// MARK: - UITableViewDataSource

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DividerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = websites[indexPath.row].title
        return cell
    }
}

// MARK: - UITabBarControllerDelegate

extension TableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
    }
}
