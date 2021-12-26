//
//  TruckTableViewCell.swift
//  TruckDemo
//
//  Created by Aaditya Verma on 24/12/21.
//

import UIKit

class TruckTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var truckNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeDurationLabel: UILabel!
    @IBOutlet weak var dayMinsLabel: UILabel!
    @IBOutlet weak var mileageKmLabel: UILabel!
    @IBOutlet weak var mileageNumberLabel: UILabel!
    @IBOutlet weak var truckStatusImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UI

    func setupUI() {
        self.cellBackgroundView.layer.cornerRadius = 8
        self.cellBackgroundView.layer.masksToBounds = true

        self.shadowView.layer.masksToBounds = false
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.23
        self.shadowView.layer.shadowRadius = 4
    }
    
    // MARK: - Initialize Data
    
    func initialiseTruckData(with data:TruckData?) {
        let runningStatus = data?.lastRunningState?.truckRunningState == 0 ? "Stopped" : "Running"
        var intervalData = self.intervalSinceToday(timeStamp: data?.lastRunningState?.stopStartTime)
        
        self.statusLabel.text = "\(runningStatus) since last \(intervalData.intervalNumber ?? 0) \(intervalData.interval ?? "--")"
        
        if data?.lastWaypoint?.speed != 0 {
            self.mileageKmLabel.isHidden = false
            self.mileageNumberLabel.isHidden = false
            self.mileageNumberLabel.text = "\(Int(data?.lastWaypoint?.speed ?? 0.0))"
        } else {
            self.mileageKmLabel.isHidden = true
            self.mileageNumberLabel.isHidden = true
        }
        self.truckNameLabel.text = data?.truckNumber ?? ""
        intervalData = self.intervalSinceToday(timeStamp: data?.lastWaypoint?.createTime)
        self.timeDurationLabel.text = "\(intervalData.intervalNumber ?? 0)"
        self.dayMinsLabel.text = intervalData.interval ?? "--"
    }

    func intervalSinceToday(timeStamp:Int?) -> (interval:String?,intervalNumber:Int?) {
        var interval = ""
        var intervalNumber = 0
        guard let stopStartTime = timeStamp else {
            return (nil,nil)
        }
        let statusDate = NSDate(timeIntervalSince1970: TimeInterval(stopStartTime/1000))
        let dateNow = NSDate()

        let secondsBetween: TimeInterval = dateNow.timeIntervalSince(statusDate as Date)
        if secondsBetween >= 86400 {
            interval = secondsBetween > (86400*2) ? "days" : "day"
            intervalNumber = Int(secondsBetween / 86400)
        }
        else if secondsBetween < 86400 && secondsBetween >= 60 {
            interval = secondsBetween > (3600*2) ? "mins" : "min"
            intervalNumber = Int(secondsBetween / 3600)
        } else {
            interval = secondsBetween > 1 ? "secs" : "sec"
            intervalNumber = Int(secondsBetween)
        }
        return (interval,intervalNumber)
    }
}
