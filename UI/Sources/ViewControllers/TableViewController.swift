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

    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var refreshControl: BaseRefreshControl = {
        let refreshControl = BaseRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private lazy var tableView: BaseTableView = {
        // let tableView = BaseTableView(style: .grouped)
        let tableView = BaseTableView()
        tableView.refreshControl = refreshControl
        tableView.tableHeaderView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        // tableView.optimalSizeTableHeaderView = TableHeaderView()
        tableView.register(TableSectionHeaderView.self)
        tableView.register(DividerTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        // tableView.contentInsetAdjustmentBehavior = .never

        return tableView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        getWebsites()
    }

    // MARK: - Methods

    private func setupViews() {
        view.add(
            tableView,
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.bottomAnchor
        )

        tableView.add(
            activityIndicatorView,
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
                urlString: website.urlString ?? "",
                title: website.title ?? ""
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TableSectionHeaderView = tableView.dequeueReusableHeaderFooterView()
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableSectionHeaderView.itemHeight
    }
}

// MARK: - API

extension TableViewController {
    private func getWebsites() {
        guard let path = Bundle.main.path(forResource: "Websites", ofType: "json") else {
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            // let websites: [Website] = try JSONDecoder().decode([Website].self, from: data)
            let websites = try data.decoded() as [Website]

            self.websites = websites
        } catch {
            error.localizedDescription.log()
        }
    }
}
