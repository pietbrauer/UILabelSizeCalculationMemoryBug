import UIKit

class DiffCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.addSubview(self.label)
        self.contentView.addSubview(scrollView)
        return scrollView
    }()

    var string: NSAttributedString? {
        didSet {
            if let string = string {
                label.attributedText = string
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var size = label.sizeThatFits(CGSizeMake(0, 0))
        size = CGSizeMake(ceil(size.width), ceil(size.height))
        label.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        scrollView.contentSize = size
        scrollView.frame = CGRect(x: 0.0, y: 0.0, width: contentView.frame.width, height: size.height)
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let bottom = scrollView.frame.height + scrollView.frame.origin.y
        return CGSizeMake(size.width, bottom)
    }

    static func heightForModel(string: NSAttributedString, constrainingWidth: CGFloat) -> CGFloat {
        let cell = DiffCell(style: .Default, reuseIdentifier: nil)
        cell.frame.size.width = constrainingWidth
        cell.string = string
        cell.sizeToFit()
        return cell.frame.height
    }
}
