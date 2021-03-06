//
//  UndoDeletedKeyCell.swift
//  ArisenReferenceAuthenticator
//
//  Created by Serguei Vinnitskii on 2/8/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import UIKit
import ArisenSwiftVault

class UndoDeletedKeyCell: UITableViewCell {

    @IBOutlet weak var keyName: UILabel!

    func setupCell(withKey key: ArisenVault.VaultKey?) {
        let key = key?.metadata["name"] ?? "Unknown Key"
        keyName.text = "\(key) auth deleted"
    }
}
