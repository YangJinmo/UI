//
//  TableViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: - Constants

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

    override func loadView() {
        super.loadView()

        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.delegate = self

        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
        
        getWebsites()
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

        tableView.addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
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
