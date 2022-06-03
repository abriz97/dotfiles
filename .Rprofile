# warn on partial matches
options(warnPartialMatchAttr=TRUE,
        warnPartialMatchDollar=TRUE,
        warnPartialMatchArgs=TRUE)

# enable autocompletions for package names
# in `require()`, `library()`
utils::rc.settings(ipck=TRUE)

# warnings are errors
# options(warn=2)

# fancy quotes are annoying and lead to
# `copy + paste` bugs/frustrations
# options(useFancyQuotes=FALSE)

# Limit the number of elements printed in
# lists (and other?)
options(max.print = 100)

# Code from bruno rodrigues to better view datatables and plots
# https://gist.github.com/b-rodrigues/948156d09607e5e8e66b80e5b318a854

init <- function()
{
        httpgd::hgd()
        options(reactable.theme = reactable::reactableTheme(
                  color = "hsl(233, 9%, 87%)",
                  backgroundColor = "#002b36",
                  borderColor = "#eee8d5",
                  stripedColor = "#586e75",
                  highlightColor = "#6c71c4",
                  inputStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                  selectStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                  pageButtonHoverStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                  pageButtonActiveStyle = list(backgroundColor = "hsl(233, 9%, 28%)")
                ))

        view <<- function(.data){
          if(interactive()) {
            reactable::reactable(.data,
                      filterable = TRUE,
                      searchable = TRUE,
                      showPageSizeOptions = TRUE,
                      striped = TRUE,
                      highlight = TRUE,
                      compact = TRUE,
                      defaultPageSize = 30)
          }
        }

        view_xl <<- function(.data){
          if(interactive()){
            tmp <- tempfile(fileext = ".csv")
            data.table::fwrite(.data, tmp)
            browseURL(tmp, browser = "gnumeric")
          }
        }
}
