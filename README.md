# UI

UI is a DSL to make Auto Layout easy on iOS.

<br/>

## [Extensions](https://github.com/YangJinmo/UI/tree/main/UI/Sources/Extensions)

### [UIKit](https://github.com/YangJinmo/UI/tree/main/UI/Sources/Extensions/UIKit)
- [UIStoryboard](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/s/UIStoryboard.swift)
- [UIViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)
    - [UINavigationController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)
    - [Toast](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)
- [UIAlertController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIAlertController.swift)
    - [UIAlertAction](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIAlertAction.swift)

- [Identifiable](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/Identifiable.swift) (identifier)
- [UITableView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UITableView.swift) (register, dequeueReusableCell)
- [UICollectionView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UICollectionView.swift) (register, dequeueReusableCell)
    - [FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Defines/FlowLayoutMetric.swift)
    - [UIEdgeInsets](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIEdgeInsets.swift)
- [UIView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIView.swift) (NSLayoutAnchor, NSLayoutConstraint, Visual Format Language)
- [UIImageView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIImageView.swift) (Asynchronously, Synchronously, Download, Retrieve Memory / Disk Cache)
- [UILabel](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UILabel.swift) (spaceBetweenTheLines)
- [UIColor](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIColor.swift) (rgb, white, random)
### [Foundation](https://github.com/YangJinmo/UI/tree/main/UI/Sources/Extensions/Foundation)
- [Optional](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Foundation/Optional.swift) (isNilOrEmpty)
- [NSMutableAttributedString](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/Foundation/NSMutableAttributedString.swift)



## [Commons](https://github.com/YangJinmo/UI/tree/main/UI/Sources/ViewControllers/Commons)

- [FloatingButton](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Views/Commons/FloatingButton.swift)
- [TabView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Views/Commons/TabView.swift)
- [TabBarController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/TabBarController.swift)
- [WebViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/WebViewController.swift)
- [ImagePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/ImagePresentViewController.swift)
- [MailComposeViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Commons/MailComposeViewController.swift)



## [Bases](https://github.com/YangJinmo/UI/tree/main/UI/Sources/ViewControllers/Bases)

- [BaseViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseViewController.swift)
- [BasePresentViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BasePresentViewController.swift)
- [BaseNavigationViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/ViewControllers/Bases/BaseNavigationViewController.swift)


<br/>

## Usage

### [UIStoryboard](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIStoryboard.swift)
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

### [UIViewController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)

**[UINavigationController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)**

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
        .action(title: "??????", style: .cancel) { _ in
            "cancel".log()
        }
) {
    "completion".log()
}
```

**[UIAlertController](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIAlertController.swift)**

alert
  
```swift
alert(
    title: "?????? ??????",
    message: "????????? ???????????? ?????? ?????????\n?????? ???????????? ??? ??? ????????????."
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

### [Toast](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIViewController.swift)

```swift
toast("?????? ??????\n\n????????? ????????? ???????????? ?????? ?????????\n?????? ???????????? ????????? ??? ????????????.")
```

```swift
toast("UI??? ?????????????????????.", bottom: true)
```

```swift
toast(error.localizedDescription)
```

### [Identifiable](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/Identifiable.swift) (identifier)

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
  
### [UITableView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UITableView.swift) (register, dequeueReusableCell)

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
  
  
  
### [UICollectionView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UICollectionView.swift) (register, dequeueReusableCell)

```swift
class ViewController: UIViewController {
  var searches: [Search] = [
      Search(
          isExpand: false,
          title: "?????? ??????",
          terms: ["??????", "??????", "?????????", "?????????", "?????????"]
      ),
      Search(
          isExpand: false,
          title: "?????? ??????",
          terms: ["?????????", "?????????", "?????????", "?????????", "?????????"]
      ),
      Search(
          isExpand: false,
          title: "?????? ??????",
          terms: ["?????????", "?????????", "?????????", "????????????", "????????????"]
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
  
### [FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Defines/FlowLayoutMetric.swift)

[flowLayout](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Defines/FlowLayoutMetric.swift)

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

[itemSize](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Defines/FlowLayoutMetric.swift)

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

[FlowLayoutMetric](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Defines/FlowLayoutMetric.swift) (protocol), 
[UIEdgeInsets](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIEdgeInsets.swift) (uniform)

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
  

### [UIView](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIView.swift)

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

### [UILabel](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UILabel.swift)
spaceBetweenTheLines
```swift
let toastLabel = UILabel()
toastLabel.text = text
toastLabel.font = .systemFont(ofSize: 16, weight: .bold)
toastLabel.lineBreakMode = .byWordWrapping
toastLabel.numberOfLines = 0
toastLabel.spaceBetweenTheLines()
```

### [UIColor](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/UIColor.swift)
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

### [Optional](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/Optional.swift)
isNilOrEmpty
```swift
func toast(_ text: String?) {
    guard !text.isNilOrEmpty else { return }
    print(text)
}
```
### [NSMutableAttributedString](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Extensions/UIKit/NSMutableAttributedString.swift)
```swift
lazy var explainLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.attributedText = NSMutableAttributedString()
            .light("???????????????!\n", size: 22)
            .medium("???????????????!", size: 22)
    return label
}
```

### [FloatingButton](https://github.com/YangJinmo/UI/blob/main/UI/Sources/Views/Commons/FloatingButton.swift)
  
```swift
final class ViewController: UIViewController {
    // MARK: - Properties

    private var floatingButton: FloatingButton?
    
    // MARK: - View Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        createFloatingButton()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        removeFloatingButton()
    }
    
    // MARK: - Methods

    private func removeFloatingButton() {
        floatingButton?.remove()
        floatingButton = nil
    }

    private func createFloatingButton() {
        floatingButton = FloatingButton()

        guard let floatingButton = floatingButton else {
            return
        }

        view.addSubview(floatingButton)

        Constraint.activate([
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])

        floatingButton.floatingButtonTouch = floatingButtonTouched
    }

    @objc private func floatingButtonTouched() {
        UIView.animate(withDuration: 0) {
            self.scrollView.setContentOffset(.zero, animated: true)
        } completion: { _ in
            self.floatingButton?.hide()
        }
    }
}
```
```swift
extension ViewController: UIScrollViewDelegate {
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
        floatingButton?.hide()
    }

    private func stoppedScrolling(scrollView: UIScrollView) {
        scrollView.contentOffset.y == 0 ? floatingButton?.hide() : floatingButton?.show()
    }
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