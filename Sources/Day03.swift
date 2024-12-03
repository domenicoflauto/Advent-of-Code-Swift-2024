import Algorithms
import RegexBuilder

struct Day03: AdventDay {
  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  func part1() -> Int {
    let pattern = /mul\(([0-9]{1,3}),([0-9]{1,3})\)/
    
    let solution = entities.reduce(into: 0) { result, line in
      let matches = line.matches(of: pattern)
      result += matches.reduce(into: 0) { partial, match in
        if let n1 = Int(match.output.1), let n2 = Int(match.output.2) {
          partial += n1 * n2
        }
      }
    }
    
    return solution
  }

  func part2() -> Int {
    let pattern = /mul\(([0-9]{1,3}),([0-9]{1,3})\)|do\(\)|don't\(\)/
    
    var enabled = true
    
    let solution = entities.reduce(into: 0) { result, line in
      let matches = line.matches(of: pattern)
      result += matches.reduce(into: 0) { partial, match in
        if match.output.0 == "do()" {
          enabled = true
        } else if match.output.0 == "don't()" {
          enabled = false
        }
        
        else if enabled,
           let s1 = match.output.1,
           let s2 = match.output.2,
           let n1 = Int(s1),
           let n2 = Int(s2) {
          partial += n1 * n2
        }
      }
    }
    
    return solution
  }
}
