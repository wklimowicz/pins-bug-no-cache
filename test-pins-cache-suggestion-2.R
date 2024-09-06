library(pins)

board_network_drive <- function(path, versioned = FALSE, cache = NULL) {
    remove_drive_name <- function(path) paste(fs::path_split(path)[[1]][-1], collapse = "/")
    board_cache_path <- eval(parse(text = "pins:::board_cache_path"))
    new_board_v1 <- eval(parse(text = "pins:::new_board_v1"))

    fs::dir_create(path)
    path <- fs::path_norm(path)
    cache <- cache %||% board_cache_path(fs::path("network_drive", remove_drive_name(path)))

    new_board_v1("pins_board_folder",
                 cache = cache,
                 path = path,
                 versioned = versioned
    )
}

tmp <- tempdir()

board <- board_network_drive(tmp)

# Make iris big to make sure it's not about size limits
# 60MB
iris_big <- rep(iris, 10000)

board |>
  pin_write(iris_big, "iris_big")

irig_big <- board |>
  pin_read("iris_big")

irig_big <- board |>
  pin_read("iris_big")
