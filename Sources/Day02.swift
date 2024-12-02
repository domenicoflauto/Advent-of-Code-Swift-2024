import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }
  
  func isDiffWithinRange(_ a: Int, _ b: Int) -> Bool {
    return abs(a - b) >= 1 && abs(a - b) <= 3
  }
  
  // check if array is either increasing or decreasing and within range
  func isLineSafe(_ array: [Int]) -> Bool {
    for i in 0..<array.count - 1 {
      if !isDiffWithinRange(array[i], array[i + 1]) {
        return false
      }
    }
    return true
  }
  
  func isSorted(_ array: [Int]) -> Bool {
    let isIncreasing = zip(array, array.dropFirst()).allSatisfy { $0 <= $1 }
    let isDecreasing = zip(array, array.dropFirst()).allSatisfy { $0 >= $1 }
    return isIncreasing || isDecreasing
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    
    var safeLines = 0
    
    for line in entities {
      if (isSorted(line) && isLineSafe(line)) {
        safeLines += 1
      }
    }
    
    return safeLines
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var safeLines = 0
    
    for line in entities {
      if (isSorted(line) && isLineSafe(line)) {
        safeLines += 1
      } else {
        for i in 0..<line.count {
          var lineCopy = line
          lineCopy.remove(at: i)
          if (isSorted(lineCopy) && isLineSafe(lineCopy)) {
            safeLines += 1
            break
          }
        }
      }
    }
    return safeLines
  }
}
