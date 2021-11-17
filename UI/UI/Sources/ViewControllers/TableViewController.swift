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
        view.addSubviews(tableView)

//        Constraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])

//        tableView.make(
//            top: view.safeAreaLayoutGuide.topAnchor,
//            left: view.safeAreaLayoutGuide.leftAnchor,
//            right: view.safeAreaLayoutGuide.rightAnchor,
//            bottom: view.bottomAnchor
//        )
        
//        let topConstraint = Constraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
//        view.addConstraint(topConstraint)
//        let leftConstraint = Constraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0)
//        view.addConstraint(leftConstraint)
//        let rightConstraint = Constraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0)
//        view.addConstraint(rightConstraint)
//        let bottomConstraint = Constraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
//        view.addConstraint(bottomConstraint)

//        let topConstraint = Constraint(item: view.safeAreaLayoutGuide, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1, constant: 0)
//        view.addConstraint(topConstraint)
//        let leftConstraint = Constraint(item: view.safeAreaLayoutGuide, attribute: .left, relatedBy: .equal, toItem: tableView, attribute: .left, multiplier: 1, constant: 0)
//        view.addConstraint(leftConstraint)
//        let rightConstraint = Constraint(item: view.safeAreaLayoutGuide, attribute: .right, relatedBy: .equal, toItem: tableView, attribute: .right, multiplier: 1, constant: 0)
//        view.addConstraint(rightConstraint)
//        let bottomConstraint = Constraint(item: view.safeAreaLayoutGuide, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 0)
//        view.addConstraint(bottomConstraint)
        
//        view.addConstraint(Constraint(item: view.safeAreaLayoutGuide, attribute: .top, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1, constant: 0))
//        view.addConstraint(Constraint(item: view.safeAreaLayoutGuide, attribute: .left, relatedBy: .equal, toItem: tableView, attribute: .left, multiplier: 1, constant: 0))
//        view.addConstraint(Constraint(item: view.safeAreaLayoutGuide, attribute: .right, relatedBy: .equal, toItem: tableView, attribute: .right, multiplier: 1, constant: 0))
//        view.addConstraint(Constraint(item: view.safeAreaLayoutGuide, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 0))
        
//        view.addConstraint(Constraint(view.safeAreaLayoutGuide, .top, tableView, .top))
//        view.addConstraint(Constraint(view.safeAreaLayoutGuide, .left, tableView, .left))
//        view.addConstraint(Constraint(view.safeAreaLayoutGuide, .right, tableView, .right))
//        view.addConstraint(Constraint(view.safeAreaLayoutGuide, .bottom, tableView, .bottom))
        
        view.make(tableView, .top, view.safeAreaLayoutGuide, .top)
        view.make(tableView, .left, view.safeAreaLayoutGuide, .left)
        view.make(tableView, .right, view.safeAreaLayoutGuide, .right)
        view.make(tableView, .bottom, view, .bottom)
        
//        tableView.height(40)
//        tableView.height(200)
        
//        print(view.constraints)
//
//        view.removeConstraint(attribute: .top)
//
//        print(view.constraints)
//
//        view.make(tableView, .top, view.safeAreaLayoutGuide, .top, constant: 20)
//
//        print(view.constraints)
        
        tableView.addSubviews(activityIndicatorView)

        // activityIndicatorView.center()
        activityIndicatorView.center(tableView)
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
