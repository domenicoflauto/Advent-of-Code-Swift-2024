import Algorithms
import Foundation

struct Day04: AdventDay {
    var data: String

    var grid: [[Character]] {
      data.split(separator: "\n").map { Array($0) }
    }
  
    let directions = [
      (0, 1),
      (0, -1),
      (1, 0),
      (-1, 0),
      (1, 1),
      (-1, -1),
      (1, -1),
      (-1, 1)
    ]
  

    func part1() -> Int {
      let word = Array("XMAS")
      let rows = grid.count
      let cols = grid[0].count
      var count = 0
      
      func isValidPosition(_ x: Int, _ y: Int) -> Bool {
          return x >= 0 && x < rows && y >= 0 && y < cols
      }
      
      func checkWord(from x: Int, _ y: Int, direction: (Int, Int)) -> Bool {
              for i in 0..<word.count {
                  let newX = x + i * direction.0
                  let newY = y + i * direction.1
                  if !isValidPosition(newX, newY) || grid[newX][newY] != word[i] {
                      return false
                  }
              }
              return true
          }

      for x in 0..<rows {
              for y in 0..<cols {
                  for direction in directions {
                      if checkWord(from: x, y, direction: direction) {
                          count += 1
                      }
                  }
              }
          }
        
      return count
    }

    func part2() -> Int {
      let rows = grid.count
      let cols = grid[0].count
      var count = 0
      
          func isXMASPattern(at x: Int, _ y: Int) -> Bool {
              // Ensure the pattern fits within the grid boundaries
              guard x > 0, x < rows - 1, y > 0, y < cols - 1 else {
                  return false
              }
              
              let pattern1 =
                grid[x][y] == "A" &&
                grid[x - 1][y - 1] == "M" &&
                grid[x - 1][y + 1] == "S" &&
                grid[x + 1][y - 1] == "M" &&
                grid[x + 1][y + 1] == "S"
            
              let pattern2 =
                grid[x][y] == "A" &&
                grid[x - 1][y - 1] == "S" &&
                grid[x - 1][y + 1] == "M" &&
                grid[x + 1][y - 1] == "S" &&
                grid[x + 1][y + 1] == "M"
            
              let pattern3 =
                grid[x][y] == "A" &&
                grid[x - 1][y - 1] == "S" &&
                grid[x - 1][y + 1] == "S" &&
                grid[x + 1][y - 1] == "M" &&
                grid[x + 1][y + 1] == "M"
            
            let pattern4 =
                grid[x][y] == "A" &&
                grid[x - 1][y - 1] == "M" &&
                grid[x - 1][y + 1] == "M" &&
                grid[x + 1][y - 1] == "S" &&
                grid[x + 1][y + 1] == "S"
            
              return pattern1 || pattern2 || pattern3 || pattern4
          }

      for x in 1..<rows-1 {
              for y in 1..<cols-1 {
                  if isXMASPattern(at: x, y) {
                      count += 1
                  }
              }
          }
      
      return count
    }
}
