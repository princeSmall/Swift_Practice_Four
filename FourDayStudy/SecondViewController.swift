//
//  SecondViewController.swift
//  FourDayStudy
//
//  Created by le tong on 2019/9/29.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var model = BaseModel(name: "", content: "", category: "")
    private var nameLabel = UILabel()
    private var contentLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = model.category
        setCurrentUI()
        // Do any additional setup after loading the view.
    }
    func setCurrentUI() -> Void {
        nameLabel = UILabel.init(frame: CGRect(x: view.frame.width / 2.0 - 100, y: 200, width: 200, height: 20))
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.text = model.name
        contentLabel = UILabel.init(frame: CGRect(x: view.frame.width / 2.0 - 150, y: 300, width: 300, height: 20))
        contentLabel.textAlignment = NSTextAlignment.center
        contentLabel.text = model.content
        view.addSubview(nameLabel)
        view.addSubview(contentLabel)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
