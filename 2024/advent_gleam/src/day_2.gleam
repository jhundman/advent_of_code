import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile as sf

pub fn solve() {
  io.println("--- Day 2: Red-Nosed Reports ---")

  let assert Ok(data) = read_file("./src/data/day_2.txt")

  part_1(data)
}

fn part_1(data: List(List(Int))) {
  todo
}

fn read_file(path: String) {
  io.println("READING FILE")
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
