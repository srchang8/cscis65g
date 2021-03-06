//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by stephen chang on 6/28/16.
//  Copyright © 2016 Stephen Chang. All rights reserved.
//

//import Foundation

import UIKit

class Problem4ViewController: UIViewController {
    
    @IBOutlet weak var textViewProblem4: UITextView!
    
    
    @IBAction func runButtonProblem4(sender: UIButton) {
    //textViewProblem4.text = "runButtonProblem4 was pressed \(neighbors())"
    
    var numOfLivingCellsInBefore: Int = 0
        var numOfLivingCellsInAfter: Int = 0
    let NumColumns: Int = 10
    let NumRows: Int = 10
    var before = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
    var afterStep = Array(count:NumColumns, repeatedValue: Array(count:NumRows, repeatedValue:false))
        
        
        //set a random true or false value for each cell in the before array
        for y in 0..<NumColumns{//iterate 0-9
            for x in 0..<NumRows{//iterate 0-9
                
                // if arc4random_uniform generates 1, then it will set cell to true
                if arc4random_uniform(3) == 1 {
                    before[y][x] = true
                    numOfLivingCellsInBefore+=1
                    
                }
                //print(before[y][x]) //print entire array to see if random variables generated correctly
            }
            
        }
        
        
        for x in 0..<step2(before).count{//iterate 0-size of input array
            for y in 0..<afterStep[x].count{//iterate 0-9
                
                if step(before)[x][y] == true{
                    numOfLivingCellsInAfter+=1
                }
                
            }
            
        }
       
        textViewProblem4.text="Run button pressed \nLiving cells in Before: \(numOfLivingCellsInBefore) \nLiving cells in After: \(numOfLivingCellsInAfter)"
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        self.title = "Problem 4"
        
    }
    
    
}

