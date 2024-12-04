import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/regex
import gleam/regexp
import gleam/result
import gleam/string
import simplifile as sf

pub fn solve() {
  io.println("--- Day 3: Mull It Over ---")

  let data = read_file("./src/data/day_3.txt")
  part_1(data)
  part_2(data)
}

fn part_1(data: String) {
  let assert Ok(re) = regexp.from_string("mul\\(\\d+,\\d+\\)")

  let ans =
    data
    |> regexp.scan(re, _)
    |> list.map(fn(x) {
      x.content
      |> string.replace("mul(", "")
      |> string.replace(")", "")
      |> string.split(",")
    })
    |> list.map(fn(x) {
      // Lazy but I know the regex should return only 2 vals
      let assert Ok(val_1) =
        x |> list.first() |> result.unwrap("0") |> int.parse()
      let assert Ok(val_2) =
        x |> list.last() |> result.unwrap("0") |> int.parse()
      val_1 * val_2
    })
    |> list.fold(0, int.add)
    |> int.to_string()
  io.println("Program Value Part 1 ⭐️: " <> ans)
}

fn part_2(data: String) {
  let assert Ok(re) =
    regexp.from_string("mul\\(\\d+,\\d+\\)|do\\(\\)|don't\\(\\)")

  let ans =
    data
    |> regexp.scan(re, _)
    |> list.map(fn(x) { x.content })
    |> helper(1, [])
    |> list.map(fn(x) {
      x
      |> string.replace("mul(", "")
      |> string.replace(")", "")
      |> string.split(",")
    })
    |> list.map(fn(x) {
      // Lazy but I know the regex should return only 2 vals
      let assert Ok(val_1) =
        x |> list.first() |> result.unwrap("0") |> int.parse()
      let assert Ok(val_2) =
        x |> list.last() |> result.unwrap("0") |> int.parse()
      val_1 * val_2
    })
    |> list.fold(0, int.add)
    |> int.to_string()
    |> io.debug()
  io.println("Program Value Part 2 ⭐️: " <> ans)
}

fn helper(vals: List(String), is_do: Int, ans: List(String)) {
  // Function to recursively iterate through list, and if a do() segment add to array
  case vals {
    [first, ..rest] -> {
      let is_do_new = case first {
        "do()" -> 1
        "don't()" -> -1
        _ -> is_do
      }
      case is_do, first {
        // We don't care about do() then do() or don't()
        1, "do()" -> helper(rest, is_do_new, ans)
        1, "don't()" -> helper(rest, is_do_new, ans)
        1, _ -> helper(rest, is_do_new, [first, ..ans])
        _, _ -> helper(rest, is_do_new, ans)
      }
    }
    _ -> ans
  }
}

fn read_file(path: String) {
  io.println("READING FILE")
  let assert Ok(file) = sf.read(from: path)

  file
  |> string.trim()
}
