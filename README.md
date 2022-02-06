# UI

UI is a DSL to make Auto Layout easy on iOS.

<br/>

### [Extensions](https://github.com/YangJinmo/UI/tree/main/UI/Sources/Extensions)

- [UIStoryboard](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIStoryboard.swift)
    - [UIViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)
        - [UINavigationController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)
        - [UIAlertController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIAlertController.swift)
            - [UIAlertAction](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIAlertAction.swift)
        - [Toast](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)
- [Identifiable](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Identifiable.swift) (identifier)
- [UITableView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UITableView.swift) (register, dequeueReusableCell)
- [UICollectionView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UICollectionView.swift) (register, dequeueReusableCell)
    - [FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Commons/FlowLayoutMetric.swift)
    - [UIEdgeInsets](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIEdgeInsets.swift)
- [UIView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIView.swift) (NSLayoutAnchor, NSLayoutConstraint, Visual Format Language)
- [UIImageView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIImageView.swift) (Asynchronously, Synchronously, Download, Retrieve Memory / Disk Cache)
- [UILabel](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UILabel.swift) (spaceBetweenTheLines)
- [UIColor](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIColor.swift) (rgb, white, random)
- [Optional](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Optional.swift) (isNilOrEmpty)
- [NSMutableAttributedString](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/NSMutableAttributedString.swift)



### [Commons](https://github.com/YangJinmo/UI/tree/main/UI/Sources/ViewControllers/Commons)

- [TabView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Views/Commons/TabView.swift)
- [TabBarController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/TabBarController.swift)
- [WebViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/WebViewController.swift)
- [ImagePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/ImagePresentViewController.swift)
- [MailComposeViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/MailComposeViewController.swift)



### [Bases](https://github.com/YangJinmo/UI/tree/main/UI/Sources/ViewControllers/Bases)

- [BaseViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseViewController.swift)
- [BasePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BasePresentViewController.swift)
- [BaseNavigationViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseNavigationViewController.swift)


<br/>

## Usage

### [UIStoryboard](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIStoryboard.swift)
```swift
let vc = MainViewController.instantiate()
```

```swift
class MainViewController: UIViewController {
    static func instantiate() -> Self {
        return Self.from(storyboardName: .home, bundle: Bundle.main)
    }
}
```

### [UIViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)

**[UINavigationController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)**

```swift
present(SearchViewController())
```

```swift
present(DelegateViewController(delegate: self))
```

```swift
present(
    UIAlertController
        .actionSheet(title: "title", message: "message")
        .action(title: "default", style: .default) { _ in
            "default".log()
        }
        .action(title: "destructive", style: .destructive) { _ in
            "destructive".log()
        }
        .action(title: "취소", style: .cancel) { _ in
            "cancel".log()
        }
) {
    "completion".log()
}
```

**[UIAlertController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIAlertController.swift)**

alert
  
```swift
alert(
    title: "실행 오류",
    message: "주소가 유효하지 않기 때문에\n해당 페이지를 열 수 없습니다."
) { _ in
    self.popViewController()
}
```
  
```swift
func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
    alert(message: message) { _ in
        completionHandler()
    }
}
```
  
alertOption
  
```swift
alertOption(
    title: "title",
    message: "message"
) { _ in
    "confirmHandler".log()
} cancelHandler: { _ in
    "cancelHandler".log()
} completion: {
    "completion".log()
}
```
```swift
func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    alertOption(
        message: message,
        confirmHandler: { _ in
            completionHandler(true)
        },
        cancelHandler: { _ in
            completionHandler(false)
        }
    )
}
```
actionSheet
  
```swift
actionSheet(
    title: "title",
    message: "message",
    actions:
    .default("default", { _ in
        "default".log()
    }),
    .destructive("destructive", { _ in
        "destructive".log()
    })
) { _ in
    "cancel".log()
} completion: {
    "completion".log()
}
```

### [Toast](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIViewController.swift)

```swift
toast("실행 오류\n\n이미지 주소가 유효하지 않기 때문에\n해당 이미지를 불러올 수 없습니다.")
```

```swift
toast("UI가 변경되었습니다.", bottom: true)
```

```swift
toast(error.localizedDescription)
```

### [Identifiable](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Identifiable.swift) (identifier)

```swift
class CollectionViewController: UIViewController {
    lazy var collectionView: BaseCollectionView = {
        let collectionView = BaseCollectionView(layout: flowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchTitleCell.self)
        collectionView.register(SearchTermCell.self)
        return collectionView
    }()
}
```
  
```swift
extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: T.identifier)
    }
}
```
  
### [UITableView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UITableView.swift) (register, dequeueReusableCell)

  ```swift
  class ViewController: UIViewController {
      let items: [Item] = ["1", "2", "3"]
  
      lazy var tableView: UITableView = {
          let tableView = UITableView()
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
  
  
  
### [UICollectionView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UICollectionView.swift) (register, dequeueReusableCell)

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
      let collectionView = BaseCollectionView(layout: flowLayout())
      collectionView.dataSource = self
      collectionView.delegate = self
      collectionView.register(SearchTitleCell.self)
      collectionView.register(SearchTermCell.self)
      return collectionView
  }()
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
  
```
  
### [FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Commons/FlowLayoutMetric.swift)

[flowLayout](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Commons/FlowLayoutMetric.swift)

```swift
private lazy var collectionView: BaseCollectionView = {
    let collectionView = BaseCollectionView(layout: flowLayout())
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(SearchTitleCell.self)
    collectionView.register(SearchTermCell.self)
    return collectionView
}()
```

[itemSize](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Commons/FlowLayoutMetric.swift)

```swift
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
```

[FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Commons/FlowLayoutMetric.swift) (protocol), 
[UIEdgeInsets](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIEdgeInsets.swift) (uniform)

```swift
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
  

### [UIView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIView.swift)

  ```swift
  class ViewController: UIViewController {
      lazy var pushButton = UIButton()
  
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

### [UILabel](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UILabel.swift)
spaceBetweenTheLines
```swift
let toastLabel = UILabel()
toastLabel.text = text
toastLabel.font = .systemFont(ofSize: 16, weight: .bold)
toastLabel.lineBreakMode = .byWordWrapping
toastLabel.numberOfLines = 0
toastLabel.spaceBetweenTheLines()
```

### [UIColor](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIColor.swift)
rgb, white, random
```swift
let highlight = UIColor.rgb(r: 179, g: 236, b: 230)
```
```swift
let gray250 = UIColor.white(250)
```
```swift
view.backgroundColor = .random()
```

### [Optional](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Optional.swift)
isNilOrEmpty
```swift
func toast(_ text: String?) {
    guard !text.isNilOrEmpty else { return }
    print(text)
}
```
### [NSMutableAttributedString](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/NSMutableAttributedString.swift)
```swift
lazy var explainLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.attributedText = NSMutableAttributedString()
            .light("안녕하세요!\n", size: 22)
            .medium("감사합니다!", size: 22)
    return label
}
```
    
### [TabView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Views/Commons/TabView.swift)
  
```swift
class ScrollableStackViewController: UIViewController {
    lazy var tabView = TabView(titleText: vcName)
    lazy var titleLabel = UILabel.makeForText(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )
    lazy var subtitleLabel = UILabel.makeForText(
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    )
    lazy var presentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func loadView() {
        presentButton.height(44)
        presentButton.addTarget(self, action: #selector(presentButtonTouched(_:)), for: .touchUpInside)

        tabView.setupScrollableStackView(
            titleLabel,
            subtitleLabel,
            presentButton,
            margin: 20
        )

        view = tabView
    }
}
```

[TabBarController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/TabBarController.swift)

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = TabBarController()
    window?.makeKeyAndVisible()
}
```

[WebViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/WebViewController.swift)

```swift
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let website: Website = websites[indexPath.row]
        pushViewController(
            WebViewController(
                urlString: website.urlString ?? "",
                titleText: website.title ?? ""
            )
        )
    }
}
```

[ImagePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/ImagePresentViewController.swift)

```swift
present(ImagePresentViewController(imageUrl: url))
```

[MailComposeViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/MailComposeViewController.swift)

```swift
pushViewController(MailComposeViewController())
```

### [Bases](https://github.com/YangJinmo/UI/tree/main/UI/Sources/ViewControllers/Bases)

[BaseViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseViewController.swift)

```swift
class MyViewController: BaseViewController {
}
```

[BasePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BasePresentViewController.swift)

```swift
class ImagePresentViewController: BasePresentViewController {
}
```

[BaseNavigationViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseNavigationViewController.swift)

```swift
class WebViewController: BaseNavigationViewController {
}
```