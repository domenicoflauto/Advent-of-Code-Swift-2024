import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: "   ").compactMap { Int($0) }
    }
  }
  
  func extractColumns(from entities: [[Int]]) -> ([Int], [Int]) {
    let leftList = entities.map { $0[0] }
    let rightList = entities.map { $0[1] }
    return (leftList, rightList)
  }


  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    // Calculate the sum of the first set of input data
    var (leftList, rightList) = extractColumns(from: entities)
    leftList.sort()
    rightList.sort()
    
    let solution = zip(leftList, rightList).reduce(0) { sum, pair in
      sum + abs(pair.0 - pair.1)
    }
    
    return solution
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let (leftList, rightList) = extractColumns(from: entities)
    
    func countSimilarities(of number: Int, in array: [Int]) -> Int {
      let occurrences = array.filter { $0 == number }.count
      return max(0, occurrences)
    }
    
    func sumOfSimilarities(from array1: [Int], in array2: [Int]) -> Int {
      var similarityScore = 0
      
      for number in array1 {
        similarityScore += (number * countSimilarities(of: number, in: array2))
      }
      return similarityScore
    }
    
    return sumOfSimilarities(from: leftList, in: rightList)
  }
}
