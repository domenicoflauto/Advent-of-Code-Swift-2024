import Algorithms

struct Day05: AdventDay {
  var data: String

  var entities: [[String]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { String($0) }
    }
  }
  
  func findRule(in rules: [[Int]], matching pagePair: [Int]) -> [Int]? {
    return rules.first { subarray in
      subarray == pagePair
    }
  }

  func part1() -> Any {
    var count = 0
    
    let pageOrderingRules = entities[0].map {
      $0.split(separator: "|").compactMap { Int($0) }
    }
    
    let pagesToProduce = entities[1].map {
      $0.split(separator: ",").compactMap { Int($0) }
    }
    
    func checkCorrectPageUpdates(in pageList: [Int]) -> Int {
      // Iterate over each page in the list
      for i in 0..<pageList.count {
       let currentPage = pageList[i]
        
        // Check against all following pages
        for k in (i+1)..<pageList.count {
          let followingPage = pageList[k]
          // Check if the rule exists for the current and following page
          if findRule(in: pageOrderingRules, matching: [currentPage, followingPage]) == nil {
            return 0
          }
        }
        
        // Check against all previous pages
        for j in 0..<i {
          let previousPage = pageList[j]
          if findRule(in: pageOrderingRules, matching: [previousPage, currentPage]) == nil {
            return 0
          }
        }
      }
      
      let middleIndex = pageList.count / 2
      let middlePage = pageList[middleIndex]
      
      print("Middle page: \(middlePage)")
      return middlePage
    }
    
    for pages in pagesToProduce {
      count += checkCorrectPageUpdates(in: pages)
    }
    print("Count: \(count)")
    return count
  }

  func part2() -> Any {
    var count = 0
    
    let pageOrderingRules = entities[0].map {
      $0.split(separator: "|").compactMap { Int($0) }
    }
    
    let pagesToProduce = entities[1].map {
      $0.split(separator: ",").compactMap { Int($0) }
    }
    
    func correctPageOrder(in pageList: [Int]) -> ([Int], Bool) {
      print("Page list: \(pageList)")
      var correctedPages = pageList
      var wasCorrected = false
            
            // Attempt to correct the order of pages
            for i in 0..<correctedPages.count {
                for j in (i + 1)..<correctedPages.count {
                    let currentPair = [correctedPages[i], correctedPages[j]]
                    if findRule(in: pageOrderingRules, matching: currentPair) == nil {
                        // Swap pages if the current order doesn't match any rule
                        correctedPages.swapAt(i, j)
                      wasCorrected = true

                    }
                }
            }
            
      if wasCorrected { print("Corrected pages: \(correctedPages)") }
            return (correctedPages, wasCorrected)
        }

    func checkCorrectPageUpdates(in pageList: [Int]) -> Int? {
            let (correctedPages, wasCorrected) = correctPageOrder(in: pageList)
            
            // Verify if the corrected pages comply with the rules
            for i in 0..<correctedPages.count {
                let currentPage = correctedPages[i]
                
                for k in (i + 1)..<correctedPages.count {
                    let followingPage = correctedPages[k]
                    if findRule(in: pageOrderingRules, matching: [currentPage, followingPage]) == nil {
                        return 0
                    }
                }
                
                for j in 0..<i {
                    let previousPage = correctedPages[j]
                    if findRule(in: pageOrderingRules, matching: [previousPage, currentPage]) == nil {
                        return 0
                    }
                }
            }
      
          if wasCorrected {
            let middleIndex = correctedPages.count / 2
            let middlePage = correctedPages[middleIndex]
            
            print("Middle page: \(middlePage)")
            return middlePage
          }
          
          return 0
        }

    for pages in pagesToProduce {
      if let middlePage = checkCorrectPageUpdates(in: pages) {
        count += middlePage
      }
    }

    print("Count: \(count)")
    return count
  }
}
