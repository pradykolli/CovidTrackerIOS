//
//  CovidCollectionViewCell.swift
//  covidTracker
//
//  Created by pradeep Kolli on 3/27/20.
//  Copyright © 2020 pradeep Kolli. All rights reserved.
//

import UIKit

class CovidCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryNameLBL: UILabel!
    
    @IBOutlet weak var casesInTotalLBL: UILabel!
    @IBOutlet weak var newCasesLBL: UILabel!
    @IBOutlet weak var recoveredCasesLBL: UILabel!
    
    @IBOutlet weak var totalDeathLBL: UILabel!
    @IBOutlet weak var newDeathsLBL: UILabel!
}
