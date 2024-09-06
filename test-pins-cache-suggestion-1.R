library(pins)

# Original suggestion in https://github.com/rstudio/pins-r/issues/669
board_folder <- function(path, versioned = FALSE, cache = NULL) {
  fs::dir_create(path)
  path <- fs::path_norm(path)
  cache <- cache %||% pins:::board_cache_path(paste0("folder", path))

  pins:::new_board_v1("pins_board_folder",
    cache = cache,
    path = path,
    versioned = versioned
  )
}

tmp <- tempdir()

board <- board_folder(tmp)

# Make iris big to make sure it's not about size limits
# 60MB
iris_big <- rep(iris, 10000)

board |>
  pin_write(iris_big, "iris_big")

irig_big <- board |>
  pin_read("iris_big")
