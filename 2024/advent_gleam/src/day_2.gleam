import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string
import simplifile as sf

pub fn solve() {
  io.println("--- Day 2: Red-Nosed Reports ---")

  let assert Ok(data) = read_file("./src/data/day_2.txt")

  part_1(data)
  part_2(data)
}

fn part_1(data: List(List(Int))) {
  let ans =
    data
    |> list.map(fn(x) { safe(x) })
    |> list.count(fn(x) { x })
    |> int.to_string()

  io.println("Safe Count Part 1 ⭐️: " <> ans)
}

fn safe(arr: List(Int)) {
  arr
  |> list.window_by_2()
  |> list.map(fn(x) { pair.first(x) - pair.second(x) })
  |> fn(y) {
    list.all(y, fn(x) { x >= 1 && x <= 3 })
    || list.all(y, fn(x) { x <= -1 && x >= -3 })
  }
}

fn part_2(data: List(List(Int))) {
  let ans =
    data
    |> list.count(fn(r) {
      r
      |> list.index_map(fn(_, idx) {
        list.append(list.take(r, idx), list.drop(r, idx + 1))
      })
      |> list.any(safe)
    })
    |> int.to_string()
  io.println("Safe Count Part 2 ⭐️: " <> ans)
}

fn read_file(path: String) {
  // io.println("READING FILE")
  let assert Ok(file) = sf.read(from: path)

  file
  |> string.trim()
  |> string.split("\n")
  |> list.map(fn(x) {
    string.split(x, " ")
    |> list.map(fn(x) { int.parse(x) })
    |> result.all()
  })
  |> result.all()
}
