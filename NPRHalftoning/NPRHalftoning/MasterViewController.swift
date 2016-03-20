//
//  MasterViewController.swift
//  NPRHalftoning
//
//  Created by d503 on 3/18/16.
//  Copyright © 2016 d503. All rights reserved.
//

import Cocoa
import Quartz

class MasterViewController: NSViewController {
    
    // MARK: Private Properties
    
    @IBOutlet private weak var bugsTableView: NSTableView!
    @IBOutlet private weak var bugTilteTextField: NSTextField!
    
    @IBOutlet private weak var bugImageView: NSImageView!
    @IBOutlet private weak var bugRating: EDStarRating!
    private var bugs: [ScaryBugDoc] = []
    
    // MARK: Lifecycle
    
    override func loadView() {
        super.loadView()
        
        setupRatingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSampleBugs()
    }    
}

// MARK: - Actions

extension MasterViewController {
    
    @IBAction func addButtonPressed(sender: NSButton) {
        // 1. Create a new ScaryBugDoc object with a default name
        let newDoc = ScaryBugDoc(title: "New Bug", rating: 0.0, thumbImage: nil, fullImage: nil)
        
        // 2. Add the new bug object to our model (insert into the array)
        bugs.append(newDoc)
        let newRowIndex = bugs.count - 1
        
        // 3. Insert new row in the table view
        bugsTableView.insertRowsAtIndexes(NSIndexSet(index: newRowIndex), withAnimation: NSTableViewAnimationOptions.EffectGap)
        
        // 4. Select the new bug and scroll to make sure it's visible
        bugsTableView.selectRowIndexes(NSIndexSet(index: newRowIndex), byExtendingSelection:false)
        bugsTableView.scrollRowToVisible(newRowIndex)
    }
    
    @IBAction func removeButtonPressed(sender: NSButton) {
        // 1. Get selected doc
        guard let _ = bugDocWithIndex(bugsTableView.selectedRow) else {
            return
        }
        
        // 2. Remove the bug from the model
        bugs.removeAtIndex(bugsTableView.selectedRow)
        
        // 3. Remove the selected row from the table view
        bugsTableView.removeRowsAtIndexes(NSIndexSet(index:bugsTableView.selectedRow),
            withAnimation: NSTableViewAnimationOptions.SlideRight)
        
        // 4. Clear detail info
        updateDetailInfoWithBugDoc(nil)
    }
    
    
    @IBAction func changePictureButtonPressed(sender: NSButton) {
        if let _ = bugDocWithIndex(bugsTableView.selectedRow) {
            IKPictureTaker().beginPictureTakerSheetForWindow(view.window,
                withDelegate: self,
                didEndSelector: "pictureTakerDidEnd:returnCode:contextInfo:",
                contextInfo: nil)
        }
    }
    
    @IBAction func bugTitleDidEndEdit(sender: NSTextField) {
        if let selectedDoc = bugDocWithIndex(bugsTableView.selectedRow) {
            selectedDoc.data.title = sender.stringValue
            reloadSelectedBugRow()
        }
    }
}

// MARK: - IKPictureTaker Delegate

extension MasterViewController {
    func pictureTakerDidEnd(picker: IKPictureTaker,
        returnCode: NSInteger,
        contextInfo: UnsafePointer<Void>) {
            
        let image = picker.outputImage()
        
        if image != nil && returnCode == NSModalResponseOK {
            bugImageView.image = image
            
            if let selectedDoc = bugDocWithIndex(bugsTableView.selectedRow) {
                selectedDoc.fullImage = image
                selectedDoc.thumbImage = image.imageByScalingAndCroppingForSize(CGSize(width: 44, height: 44))
                reloadSelectedBugRow()
            }
        }
    }
}

// MARK: - NSTableViewDataSource

extension MasterViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return bugs.count
    }
    
    func tableView(tableView: NSTableView,
        viewForTableColumn tableColumn: NSTableColumn?,
        row: Int) -> NSView? {
            // 1
            let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
            
            // 2
            if tableColumn!.identifier == "BugColumn" {
                // 3
                let bugDoc = bugs[row]
                cellView.imageView!.image = bugDoc.thumbImage
                cellView.textField!.stringValue = bugDoc.data.title
                return cellView
            }
            
            return cellView
    }
}

// MARK: - NSTableViewDelegate

extension MasterViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(notification: NSNotification) {
        let selectedDoc = bugDocWithIndex(bugsTableView.selectedRow)
        updateDetailInfoWithBugDoc(selectedDoc)
    }
}

// MARK: - EDStarRatingProtocol

extension MasterViewController: EDStarRatingProtocol {
    func starsSelectionChanged(control: EDStarRating!, rating: Float) {
        if let selectedDoc = bugDocWithIndex(bugsTableView.selectedRow) {
            selectedDoc.data.rating = Double(rating)
        }
    }
}

// MARK: - Supporting Methods

private extension MasterViewController {
    
    func setupRatingView() {
        bugRating.starHighlightedImage = NSImage(named: "shockedface2_full")
        bugRating.starImage = NSImage(named: "shockedface2_empty")
        
        bugRating.delegate = self
        
        bugRating.maxRating = 5
        bugRating.horizontalMargin = 12
        bugRating.editable = true
        bugRating.displayMode = UInt(EDStarRatingDisplayFull)
        
        bugRating.rating = Float(0.0)
    }
    
    func setupSampleBugs() {
        let bug1 = ScaryBugDoc(title: "Potato Bug", rating: 4.0,
            thumbImage:NSImage(named: "potatoBugThumb"), fullImage: NSImage(named: "potatoBug"))
        let bug2 = ScaryBugDoc(title: "House Centipede", rating: 3.0,
            thumbImage:NSImage(named: "centipedeThumb"), fullImage: NSImage(named: "centipede"))
        let bug3 = ScaryBugDoc(title: "Wolf Spider", rating: 5.0,
            thumbImage:NSImage(named: "wolfSpiderThumb"), fullImage: NSImage(named: "wolfSpider"))
        let bug4 = ScaryBugDoc(title: "Lady Bug", rating: 1.0,
            thumbImage:NSImage(named: "ladybugThumb"), fullImage: NSImage(named: "ladybug"))
        
        bugs = [bug1, bug2, bug3, bug4]
    }
    
    func bugDocWithIndex(index: Int) -> ScaryBugDoc? {
        guard index >= 0 && index < bugs.count else {
            return nil
        }
        
        return bugs[index]
    }
    
    func updateDetailInfoWithBugDoc(doc: ScaryBugDoc?) {
        var title = ""
        var image: NSImage? = nil
        var rating = 0.0
        
        if let scaryBugDoc = doc {
            title = scaryBugDoc.data.title
            image = scaryBugDoc.fullImage
            rating = scaryBugDoc.data.rating
        }
        
        bugTilteTextField.stringValue = title
        bugImageView.image = image
        bugRating.rating = Float(rating)
    }
    
    func reloadSelectedBugRow() {
        let indexSet = NSIndexSet(index: bugsTableView.selectedRow)
        let columnSet = NSIndexSet(index: 0)
        bugsTableView.reloadDataForRowIndexes(indexSet, columnIndexes: columnSet)
    }
}
