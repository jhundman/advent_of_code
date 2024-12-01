import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile as sf

pub fn solve_day_1() {
  io.println("--- Day 1: Historian Hysteria ---")

  let #(left_list, right_list) = read_lists("./src/data/day_1_part_1.txt")

  day_1_part_1(left_list, right_list)
  day_1_part_2(left_list, right_list)
}

pub fn day_1_part_2(left_list, right_list) {
  io.println("**Similarity Score**")

  let ans =
    calc_similarity(left_list, right_list)
    |> int.to_string()

  io.println("The simiparity in part 2 (correct btw 🌟): " <> ans)
}

pub fn calc_similarity(left_list: List(Int), right_list: List(Int)) {
  io.println("CALC SIMILARITY")
  let counts =
    left_list
    |> list.map(fn(x) { list.count(right_list, fn(y) { x == y }) })
  // |> io.debug()

  list.map2(left_list, counts, fn(x, y) { x * y })
  |> list.fold(0, int.add)
}

pub fn day_1_part_1(left_list, right_list) {
  io.println("**Location ID Distance**")

  let assert Ok(left_list_sorted) =
    left_list
    |> fn(x) { Ok(list.sort(x, int.compare)) }
  // |> io.debug()

  let assert Ok(right_list_sorted) =
    right_list
    |> fn(x) { Ok(list.sort(x, int.compare)) }
  // |> io.debug()

  let ans =
    subtract_lists(left_list_sorted, right_list_sorted, [])
    |> list.fold(0, int.add)
    |> int.to_string()

  io.println("The distance in part 1 (correct btw 🌟): " <> ans)
}

pub fn read_lists(file: String) {
  io.println("READING FILE")
  let assert Ok(file) = sf.read(from: file)

  let lists =
    file
    |> string.trim()
    |> string.split("\n")
    |> list.map(fn(x) { string.split(x, "   ") })
    |> list.transpose()

  // I should clean up
  let assert Ok(left_list) = lists |> list.first()

  let assert Ok(left_list) =
    left_list
    |> list.map(fn(x) { int.parse(x) })
    |> result.all()

  let assert Ok(right_list) = lists |> list.last()

  let assert Ok(right_list) =
    right_list
    |> list.map(fn(x) { int.parse(x) })
    |> result.all()

  #(left_list, right_list)
}

pub fn subtract_lists(
  left_list: List(Int),
  right_list: List(Int),
  end_list: List(Int),
) {
  case left_list, right_list {
    [first_l, ..rest_l], [first_r, ..rest_r] -> {
      let sub = { first_l - first_r } |> int.absolute_value()
      subtract_lists(rest_l, rest_r, [sub, ..end_list])
    }
    _, _ -> end_list
  }
}
