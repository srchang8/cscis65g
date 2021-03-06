//
//  GridView.swift
//  Assignment4
//
//  Created by stephen chang on 7/10/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

import UIKit

@IBDesignable//Let interface builder know that it should render the view directly in the canvas. Allows seeing how your custom views will appear without building and running your app after each change
class GridView: UIView {
    
    //everytime rows or cols changes grid array must reinitialize to all empty
    @IBInspectable var livingColor: UIColor = UIColor()
    @IBInspectable var emptyColor: UIColor = UIColor()
    @IBInspectable var bornColor: UIColor = UIColor()
    @IBInspectable var diedColor: UIColor = UIColor()
    @IBInspectable var gridColor: CGColor!
    
    @IBInspectable var gridWidth: CGFloat = 0
    
    
    
    //a 2D array of CellState values called grid which reinitialize to all .Empty values every time rows or cols changes using didSet keyword on the rows and cols values
    var grid = Grid(rows: 10, cols: 10) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    //start positions for on GridView if ever needed
    let xStart: CGFloat = 50//start position for x coordinate
    let yStart: CGFloat = 50// start position for y coordinate
    
    //MARK: Create before array Problem 6
    var numOfLivingCellsInBefore: Int = 0
    var numOfLivingCellsInAfter: Int = 0
    
    override func drawRect(rect: CGRect)
    {
        //MARK: draw cells
        var countRows: Int = 0
        var countColumns: Int = 0
        
        
        
        
        
        
        //cast rows and cols to CGFloat to be able to draw lines
        let gridRowsCGFloat = CGFloat(self.grid.rows)
        let gridColsCGFloat = CGFloat(self.grid.cols)
        
        //Draw rows
        for var y: CGFloat = yStart; y <= (gridRowsCGFloat*gridWidth)+(yStart); y+=gridWidth
        {
        
            
            drawRowLine(xStart, yCoord: y)
            
            countRows+=1
            
            if countRows > self.grid.rows
            {
                print("For Loop cannot run more than number of rows designated")
                print("number of rows before break \(countRows)")
                break
            }
            
            
        }
        
        //start from 50 50
        //draw 30(row) lines
        
        //draw columns
        for var x: CGFloat = xStart; x <= (gridColsCGFloat*gridWidth)+(yStart); x+=gridWidth
        {
            
            //draw line starting from this position
            drawColumnLine(x, yCoord: yStart)
            
            countColumns+=1
            
            
            if countColumns > self.grid.cols
            {
                print("For Loop cannot run more than number of columns designated")
                print("number of columns before break \(countColumns)")
                break
                
            }
            
            
            
        }
       
        
        /*
        //draw before array into the grid
        for y in 0..<self.grid.cols{
            for x in 0..<self.grid.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                switch self.grid[y, x] {
                case .Living, .Born:
                    fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                case .Empty, .Died:
                    emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
                
            }
        }
        */
        
        updateGrid()
        
 
        
        
    }//override rect function closing bracket
    
    
    
    func updateGrid(){
        
        //draw array grid into the grid
        for y in 0..<self.grid.cols{
            for x in 0..<self.grid.rows{
                
                //cast into to GCF
                let xFromIntToCGF = CGFloat(x)
                let yFromIntToCGF = CGFloat(y)
                
                
                switch self.grid[y, x] {
                case .Living, .Born:
                    fillCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                case .Empty, .Died:
                    emptyCell(xFromIntToCGF, yCoord: yFromIntToCGF)
                }
                
            }
        }
    }
    
    
    //MARK: functions
    
    //takes in CGFloat coordinates and fills the the respective cell
    func fillCell(xCoord: CGFloat, yCoord: CGFloat){
        
        //cast CGFloat to int
        let xCoordInt = Int(xCoord)
        let yCoordInt = Int(yCoord)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        let xCoordIn = xCoord*10 + xStart
        let yCoordIn = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoordIn, yCoordIn, 10, 10))
        
        
        
        //print("xCoordInt and yCoordInt inside Fill \(xCoordInt) \(yCoordInt)")
        
        switch grid[xCoordInt, yCoordInt] {
        case .Living, .Born:
            livingColor.setFill()
        case .Empty, .Died:
            emptyColor.setFill()
        }
        
        //fill the circle
        circlePath.fill()
        //gridView.setNeedsDisplay()
        
        
    }
    
    
    
    func emptyCell(xCoord: CGFloat, yCoord: CGFloat){
        
        //cast CGFloat to int
//        var xCoordInt = Int(xCoordIn)
//        var yCoordInt = Int(yCoordIn)
        
        
        //grid starts at (50, 50) or (xCoord, yCoord)
        let xCoordIn = xCoord*10 + xStart
        let yCoordIn = yCoord*10 + yStart
        
        
        //create circle context with at position (xCoord, yCoord) with size 10x10
        let circlePath = UIBezierPath(ovalInRect: CGRectMake(xCoordIn, yCoordIn, 10, 10))
        
        
        
        //set color to empty cell dark gray
        emptyColor.setFill()
        
        
        
        //fill the circle
        circlePath.fill()
        
        
        
    }
    
    
    
    //function that takes in coordinates and draws a horizontal line
    func drawRowLine(xCoord: CGFloat, yCoord: CGFloat)
    {
        
        let rowContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(rowContext, 1)
        CGContextSetStrokeColorWithColor(rowContext, gridColor)
    
        //cast so we can multiple rows by gridWidth to get length of line
        let gridRowsCGFloat = CGFloat(self.grid.rows)
        
        //length of each line
        let lengthOfLine: CGFloat = CGFloat(gridRowsCGFloat * gridWidth)
        
        
        CGContextMoveToPoint(rowContext, xCoord, yCoord)//start here
        
        let xCoordIn = xCoord + lengthOfLine//move right
        
        CGContextAddLineToPoint(rowContext, xCoordIn, yCoord)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(rowContext)
        
        
    }
    
    
    
    //takes in coordinates and draws vertical line
    func drawColumnLine(xCoord: CGFloat, yCoord: CGFloat)
    {
        let columnContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(columnContext, 1)
        CGContextSetStrokeColorWithColor(columnContext, gridColor)
        
        //cast so we can multiple cols by gridWidth to get length of line
        let gridColsCGFloat = CGFloat(self.grid.cols)
        
        //length of each line
        let lengthOfLine: CGFloat = CGFloat(gridColsCGFloat * gridWidth)
        
        CGContextMoveToPoint(columnContext, xCoord, yCoord)//start here
        
        let yCoordIn = yCoord + lengthOfLine//move down
        
        CGContextAddLineToPoint(columnContext, xCoord, yCoordIn)//end here
        
        
        //Actually draw the path
        CGContextStrokePath(columnContext)
        
    }
    
    
    
    
}//Last bracket




