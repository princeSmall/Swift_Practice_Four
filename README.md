# Swift_Practice_Four

#### 数据model对象

```
class BaseModel: NSObject {
     let name: String
     let content: String
    let category: String
    
    
    init(name: String, content: String, category: String) {
        self.name = name
        self.content = content
        self.category = category
    }
}
```

#### cell

```
 private var nameLabel = UILabel()
    private var contentLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel = UILabel.init(frame: CGRect(x: 40, y: 20, width: 200, height: 20))
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        contentLable = UILabel.init(frame: CGRect(x: 40, y: 40, width: 300, height: 20))
        contentLable.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLable)
    }
    func updateCurrentUI(baseModel:BaseModel) -> Void {
        nameLabel.text = baseModel.name
        contentLable.text = baseModel.content
    }

```

#### viewController

```
    
    
    var searchBar = UISearchBar()
    var baseTableView = UITableView()
    var modelArray: [BaseModel] = []
    <!--声明一个空数组用于筛选-->
    var currentArray: [BaseModel] = []
    let searchBarController = UISearchController(searchResultsController: nil)
    
    let identifier = "identifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "城市名";
//        setSearchBar()
        setSearchBarViewController()
        setCurrentModel()
        setBaseTableView()
        // Do any additional setup after loading the view.
    }
    <!--添加searchbar，要去更改tableview的origin-->
    func setSearchBar() -> Void {
        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        searchBar.showsCancelButton = true
        searchBar.showsSearchResultsButton = true
        searchBar.placeholder = "名称搜索"
        searchBar.barTintColor = UIColor.green
//        searchBar.barStyle = UIBarStyle.black
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    <!--是加在navbar的位置，需要添加navbar-->
    func setSearchBarViewController() -> Void {
        searchBarController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchBarController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchBarController.searchBar.scopeButtonTitles = ["All", "Dog", "Cat", "Other"]
        searchBarController.searchBar.delegate = self
        if #available(iOS 11, *) {
            self.navigationItem.searchController = searchBarController
            self.navigationItem.searchController?.isActive = true
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            baseTableView.tableHeaderView = searchBarController.searchBar
        }
    }
    <!--用于显示数据的tableview-->
    func setBaseTableView() -> Void {
        baseTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: UITableView.Style.plain)
        baseTableView.delegate = self
        baseTableView.dataSource = self
        baseTableView.register(BaseTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        view.addSubview(baseTableView)
    }
    <!--数据mock-->
    func setCurrentModel() -> Void {
        modelArray = [BaseModel.init(name: "Chocolate Bar", content: "Chocolate Bar Detail Content", category: "Dog"),
                      BaseModel.init(name: "Chocolate Chip", content: "Chocolate Chip Detail Content", category: "Cat"),
                      BaseModel.init(name: "Dark Chocolate", content: "Dark Chocolate Detail Content", category: "Dog"),
                      BaseModel.init(name: "Lollipop", content: "Lollipop Detail Content", category: "Cat"),
                      BaseModel.init(name: "Candy Cane", content: "Candy Cane Detail Content", category: "Dog"),
                      BaseModel.init(name: "Jaw Breaker", content: "aw Breaker Detail Content", category: "Dargon"),
                      BaseModel.init(name: "Caramel", content: "Caramel Detail Content", category: "Cat"),
                      BaseModel.init(name: "Sour Chew", content: "Sour Chew Detail Content", category: "Dargon"),
                      BaseModel.init(name: "Gummi Bear", content: "Gummi Bear Detail Content", category: "Tiger"),
                      BaseModel.init(name: "ACandy name", content: "ACandy name Detail Content", category: "Dog"),
                      BaseModel.init(name: "ABSource Bear", content: "ABSource Bear Detail Content", category: "Elephant")
        ]
        currentArray = modelArray;
    }
    <!--delagete / datasource-->
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let s = SecondViewController()
        s.model = self.currentArray[indexPath.row]
        self.navigationController?.pushViewController(s, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseTableViewCell
        cell.updateCurrentUI(baseModel: currentArray[indexPath.row])
        return cell
    }
    
    <!--取消按钮-->
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        currentArray = modelArray
        baseTableView.reloadData()
    }
    
/***** Coding Style 有说filter比append添加规范
     // PREFERRED
     let stringOfInts = [1, 2, 3].flatMap { String($0) }
     // ["1", "2", "3"]
     
     // NOT PREFERRED
     var stringOfInts: [String] = []
     for integer in [1, 2, 3] {
     stringOfInts.append(String(integer))
     }
     
     // PREFERRED
     let evenNumbers = [4, 8, 15, 16, 23, 42].filter { $0 % 2 == 0 }
     // [4, 8, 16, 42]
     
     // NOT PREFERRED
     var evenNumbers: [Int] = []
     for integer in [4, 8, 15, 16, 23, 42] {
     if integer % 2 == 0 {
     evenNumbers.append(integer)
     }
     }
     *****/
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            currentArray.removeAll()
            currentArray = modelArray.filter({ (bm) -> Bool in
                if bm.name.lowercased().contains(searchText.lowercased()) || searchText == ""{
                    return true
                }else{
                    return false
                }
            })
        baseTableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        currentArray.removeAll()
        let category = searchBar.scopeButtonTitles?[selectedScope]
        currentArray = modelArray.filter({ (bm) -> Bool in
            if bm.category == category || category == "All" || (bm.category != "Cat" && bm.category != "Dog" && category == "Other") {
                return true
            }else{
                return false
            }
        })
        baseTableView.reloadData()
    }
    

```