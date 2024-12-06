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
//    Goal: Identify which updates are already in the right order
    
//    Page number is correct if there are rules that put each other page after/before it.
//    For example:
//    47|53
//    97|13
//    97|61
//    97|47
//    75|29
//    61|13
//    75|53
//    29|13
//    97|29
//    53|29
//    61|53
//    97|53
//    61|29
//    47|13
//    75|47
//    97|75
//    47|61
//    75|61
//    47|29
//    75|13
//    53|13
//
//    75,47,61,53,29
//    97,61,53,29,13
//    75,29,13
//    75,97,47,61,53
//    61,13,29
//    97,13,75,29,47
    
//    In the above example, the first update (75,47,61,53,29) is in the right order:
//
//    75 is correctly first because there are rules that put each other page after it: 75|47, 75|61, 75|53, and 75|29.
//    47 is correctly second because 75 must be before it (75|47) and every other page must be after it according to 47|61, 47|53, and 47|29.
//    61 is correctly in the middle because 75 and 47 are before it (75|61 and 47|61) and 53 and 29 are after it (61|53 and 61|29).
//    53 is correctly fourth because it is before page number 29 (53|29).
//    29 is the only page left and so is correctly last.
    
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
