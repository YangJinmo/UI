//
//  TimerViewController.swift
//  UI
//
//  Created by Jmy on 2021/12/27.
//

import UIKit

final class TimerViewController: UIViewController {
    // MARK: - Constants

    private enum Color {
        static let running: UIColor = .systemGreen
        static let stopped: UIColor = .systemRed
    }

    private let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()

    // MARK: - Variables

    private var timer: Timer?
    private var timersActive = 0
    private var timers = [TimerModel](repeating: TimerModel(), count: 30)

    // MARK: - Views

    private lazy var floatingButton = FloatingButton(view: view, scrollView: tableView)

    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DividerTableViewCell.self)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        floatingButton.remove()
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
    }

    private func elapsedTimeSince(_ startTime: Date) -> String {
        let elapsed = -startTime.timeIntervalSinceNow
        return formatter.string(from: elapsed) ?? "0:00:00"
    }

    private func startTimer() {
        timersActive += 1

        guard timer == nil else {
            return
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] timer in
            guard let self = self, let indexPaths = self.tableView.indexPathsForVisibleRows else {
                return
            }

            for indexPath in indexPaths {
                let timer = self.timers[indexPath.row]

                if timer.isRunning {
                    guard let cell = self.tableView.cellForRow(at: indexPath) else {
                        return
                    }

                    cell.textLabel?.text = self.formatter.string(from: timer.elapsed) ?? "0:00:00"
                }
            }
        })
    }

    private func stopTimer() {
        timersActive -= 1

        guard timersActive == 0 else {
            return
        }

        timer?.invalidate()
        timer = nil
    }
}

// MARK: - UITableViewDataSource

extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DividerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let timer = timers[indexPath.row]

        cell.textLabel?.textColor = timer.isRunning ? Color.running : Color.stopped
        cell.textLabel?.text = formatter.string(from: timer.elapsed) ?? "0:00:00"

        return cell
    }
}

// MARK: - UITableViewDelegate

extension TimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timers[indexPath.row].isRunning.toggle()

        tableView.reloadRows(at: [indexPath], with: .none)

        if timers[indexPath.row].isRunning {
            startTimer()
        } else {
            stopTimer()
        }
    }
}

// MARK: - UIScrollViewDelegate

extension TimerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height - scrollView.frame.height

        if scrollView.contentOffset.y >= contentHeight {
//            if isLoaded && (hasMoreReviews || hasMoreRecommendReviews) {
//                loadMore()
//            }
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
        scrollView.contentOffset.y == 0 ? floatingButton.hide() : floatingButton.show()
    }
}
