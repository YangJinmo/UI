# UI

UI is a DSL to make Auto Layout easy on iOS.



### Extensions

- UIView (NSLayoutAnchor, NSLayoutConstraint, Visual Format Language)
- UITableView (ReusableView)
- UICollectionView (UICollectionReusableView, FlowLayoutMetric, SupplementaryViewKind)
- UIAlertController (UIAlertAction)



### Commons

- TabBarController
- WebViewController
- ImagePresentViewController



### Bases

- BaseViewController
- BasePresentViewController
- BaseNavigationViewController



### Usage

- UIView

  ```swift
  class ViewController: UIViewController {
      let pushButton = UIButton()
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          view.add(
              pushButton,
              heightConstant: 44,
              center: view
          )
      }
  }
  ```
  
  ```swift
  class ViewController: UIViewController {
      lazy var tableView = UITableView()
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          view.add(
              tableView,
              top: view.safeAreaLayoutGuide.topAnchor,
              left: view.safeAreaLayoutGuide.leftAnchor,
              right: view.safeAreaLayoutGuide.rightAnchor,
              bottom: view.bottomAnchor
          )
      }
  }
  ```
  
  ```swift
  class ViewController: UIViewController {
      lazy var collectionView = UICollectionView()
  
      override func viewDidLoad() {
          super.viewDidLoad()
  
          view.add(
              collectionView,
              edges: view
          )
      }
  }
  ```
  
  
  
- UITableView

  ```swift
  class ViewController: UIViewController {
      let items: [Item] = ["1", "2", "3"]
  
      lazy var tableView: UITableView = {
          let tableView: UITableView = UITableView()
          tableView.dataSource = self
          tableView.delegate = self
          tableView.register(TableViewCell.self)
          return tableView
      }()
  }
  
  extension TableViewController: UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return items.count
      }
  
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
          cell.textLabel?.text = items[indexPath.row]
          return cell
      }
  }
  ```
  
  
  
- UICollectionView

  ```swift
  class ViewController: UIViewController {
      var searches: [Search] = [
          Search(
              isExpand: false,
              title: "인기 검색",
              terms: ["캠핑", "가방", "고양이", "건전지", "오미자"]
          ),
          Search(
              isExpand: false,
              title: "최근 검색",
              terms: ["충전기", "강아지", "개구리", "두꺼비", "아이유"]
          ),
          Search(
              isExpand: false,
              title: "연관 검색",
              terms: ["보충제", "고구마", "헬스장", "런닝머신", "다이어트"]
          ),
      ]
  
      lazy var collectionView: BaseCollectionView = {
          let collectionView: BaseCollectionView = BaseCollectionView(layout: flowLayout())
          collectionView.dataSource = self
          collectionView.delegate = self
          collectionView.register(SearchTitleCell.self)
          collectionView.register(SearchTermCell.self)
          return collectionView
      }()
  
      override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
          super.viewWillTransition(to: size, with: coordinator)
  
          guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
              return
          }
          flowLayout.invalidateLayout()
      }
  }
  
  extension CollectionViewController: UICollectionViewDataSource {
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return searches.count
      }
  
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if searches[section].isExpand == true {
              return searches[section].terms.count + 1
          } else {
              return 1
          }
      }
  
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          switch indexPath.item {
          case 0:
              let cell: SearchTitleCell = collectionView.dequeueReusableCell(for: indexPath)
              cell.bind(data: searches[indexPath.section])
              return cell
          default:
              let cell: SearchTermCell = collectionView.dequeueReusableCell(for: indexPath)
              cell.bind(
                  rank: indexPath.item,
                  term: searches[indexPath.section].terms[indexPath.item - 1]
              )
              return cell
          }
      }
  }
  
  extension CollectionViewController: UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          switch indexPath.item {
          case 0:
              return itemSize(width: collectionView, height: SearchTitleCell.itemHeight)
          default:
              return itemSize(width: collectionView, height: SearchTermCell.itemHeight)
          }
      }
  }
  
  extension CollectionViewController: FlowLayoutMetric {
      var numberOfItemForRow: CGFloat {
          1
      }
  
      var sectionInset: UIEdgeInsets {
          .uniform(size: 0)
      }
  
      var minimumLineSpacing: CGFloat {
          1
      }
  
      var minimumInteritemSpacing: CGFloat {
          0
      }
  }
  ```
  
- UIAlertController

  ```swift
    alertController(
        style: .actionSheet,
        title: "제목",
        message: "메세지",
        actions:
        [
            UIAlertAction("옵션 1", { _ in
                "옵션 1".log()
            }),
            UIAlertAction("옵션 2", { _ in
                "옵션 2".log()
            }),
        ]
    )
  ```
