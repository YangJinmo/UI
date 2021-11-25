//
//  TableViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: - Variables

    private var websites: [Website] = [] {
        didSet { setWebsites() }
    }

    // MARK: - Views

    private var activityIndicatorView = BaseActivityIndicatorView()
    private var refreshControl = BaseRefreshControl()

    private lazy var tableView: BaseTableView = {
        let tableView: BaseTableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DividerTableViewCell.self)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = self.refreshControl
        return tableView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        tabBarController?.delegate = self
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)

        getWebsites()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            subview: tableView,
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.bottomAnchor
        )

        tableView.add(
            subview: activityIndicatorView,
            center: tableView
        )
    }

    @objc private func refresh() {
        getWebsites()
    }

    private func setWebsites() {
        tableView.reloadData {
            self.activityIndicatorView.stopAnimating()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UITableViewDelegate

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let website: Website = websites[indexPath.row]
        pushViewController(
            WebViewController(
                urlString: website.urlString,
                titleText: website.title
            )
        )
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
        tabBarController.selectedIndex.description.log()
    }
}

// MARK: - API

extension TableViewController {
    private func getWebsites() {
        guard let path: String = Bundle.main.path(forResource: "Websites", ofType: "json") else { return }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let websites = try JSONDecoder().decode([Website].self, from: data)

            self.websites = websites
        } catch {
            error.localizedDescription.log()
        }
    }
}
