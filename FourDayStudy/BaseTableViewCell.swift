

//
//  BaseTableViewCell.swift
//  FourDayStudy
//
//  Created by le tong on 2019/9/29.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
