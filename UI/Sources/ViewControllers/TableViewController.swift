//
//  TableViewController.swift
//  UI
//
//  Created by Jmy on 2021/10/24.
//

import UIKit

final class TableViewController: UIViewController {
    // MARK: - Variables

    private var hasShown = false
    private var websites: [Website] = [] {
        didSet { setWebsites() }
    }

    // MARK: - Views

    private lazy var floatingButton = FloatingButton.scrollToTop(view: view, scrollView: tableView)
    private lazy var activityIndicatorView = BaseActivityIndicatorView()
    private lazy var refreshControl: BaseRefreshControl = {
        let refreshControl = BaseRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView() // BaseTableView(style: .grouped)
        tableView.configure()
        tableView.refreshControl = refreshControl
        tableView.tableHeaderView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        // tableView.optimalSizeTableHeaderView = TableHeaderView()
        tableView.register(TableSectionHeaderView.self)
        tableView.register(DividerTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44 // UITableView.automaticDimension
        // tableView.estimatedRowHeight = 44
        // tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()

    private let actionSheet = ActionSheet.shared

    // MARK: - Managing the view

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
//        getWebsites()

//        getWebsites { (result: Result<[Website], Error>) in
//            switch result {
//            case let .success(websites):
//                self.websites = websites
//                break
//
//            case let .failure(message):
//                print(message)
//                break
//            }
//        }

        fetchWebsites { (result: Result<[Website], Error>) in
            switch result {
            case let .success(websites):
                self.websites = websites
                break

            case let .failure(message):
                print(message)
                break
            }
        }
    }

    // MARK: - Responding to view-related events

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        floatingButton.create()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        floatingButton.remove()
        actionSheet.dismiss()
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
            "Error: Path".log()
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            // let websites: [Website] = try JSONDecoder().decode([Website].self, from: data)
            let websites = try data.decodeJSON() as [Website]

            self.websites = websites
        } catch {
            error.localizedDescription.log()
        }
    }

    private func getWebsites<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "Websites", ofType: "json") else {
            "Error: Path".log()
            return
        }

        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url, options: .mappedIfSafe)

            let result = try data.decodeJSON() as [T]

            DispatchQueue.main.async {
                completion(.success(result))
            }

        } catch {
            completion(.failure(error))
        }
    }

    private func fetchWebsites<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "Websites", ofType: "json") else {
            "Error: Path".log()
            return
        }

        let url = URL(fileURLWithPath: path)

        url.toData { (result: Result<Data, Error>) in
            switch result {
            case let .success(data):
                data.decodeJSONArray(completion: completion)
                break

            case let .failure(message):
                print(message)
                break
            }
        }
    }
}

// MARK: - UIScrollViewDelegate

extension TableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = tableView.contentSize.height - tableView.frame.height

        if scrollView.contentOffset.y >= contentHeight {
            if !hasShown {
                hasShown = true

                actionSheet.show()
                actionSheet.confirmButtonTouch = { [weak self] in
                    "actionSheet".log()

                    if let website: Website = self?.websites.first {
                        self?.pushViewController(
                            WebViewController(
                                urlString: website.urlString ?? "",
                                title: website.title ?? ""
                            )
                        )
                    }
                }
            }
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startScrolling()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        startScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stoppedScrolling(scrollView: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stoppedScrolling(scrollView: scrollView)
    }

    private func startScrolling() {
        view.endEditing(true)
        floatingButton.hide()
    }

    private func stoppedScrolling(scrollView: UIScrollView) {
        scrollView.contentOffset.y == 0
            ? floatingButton.hide()
            : floatingButton.show()
    }
}
