import gleam/int
import gleam/io
import gleam/list
import gleam/regex
import gleam/regexp
import gleam/result
import gleam/string
import simplifile as sf

pub fn solve() {
  io.println("--- Day 4: Ceres Search ---")

  let data = read_file("./src/data/day_4.txt")
  part_1(data)
  // part_2(data)
}

fn part_1(data: List(String)) {
  let assert Ok(data_1) = data |> list.first()
  // Horizontal
  // let h =
  //   data_1
  //   |> count_xmas()

  // Vertical
  // data
  // |> transpose_vertical()
  // |> count_xmas()
  // |> io.debug()

  // Diagonal
  // data
  // |> transpose_diagonal()
  // |> io.debug()
}

fn transpose_vertical(data: List(String)) {
  data
  |> list.map(fn(x) {
    x
    |> string.to_graphemes()
  })
  |> list.transpose()
  |> list.map(fn(x) { x |> string.concat() })
}

// Hmm this seems tricky lol
fn transpose_diagonal(data: List(String)) {
  todo
  // data
  // |> list.index_map(fn(x, i) {
  //   #(i, x |> string.to_graphemes() |> list.index_map(fn(x, i) { #(i, x) }))
  // })
}

fn count_xmas(text: String) {
  let assert Ok(xmas) = regexp.from_string("XMAS|SAMX")

  text
  |> regexp.scan(xmas, _)
  |> list.map(fn(x) { x.content })
  |> list.length()
}

// fn part_2(data: String) {
//   todo
// }

fn read_file(path: String) {
  let assert Ok(file) = sf.read(from: path)

  file
  |> string.trim()
  |> string.split("\n")
}
