library(knitr)
themes <- knit_theme$get()

opening <- "
<<>>=
"

opening_no_echo <- "
<<echo=FALSE>>=
"

r_text <- "my_fn <- function(x) {
  print(\"Some text\")
  y * 2
}
"

closing <- "@\n"

preamble <- 
"\\documentclass[12pt]{article}
\\usepackage{url}
\\begin{document}

<<set-knitr-options, echo=FALSE>>=
library(knitr)
opts_chunk$set(dev = \"pdf\")
opts_knit$set(out.format = \"latex\")
themes <- knit_theme$get()
@
\\title{A demonstration of \\texttt{knitr} \\LaTeX\\ themes}
\\author{Sean C. Anderson\\\\ \\texttt{sean@seananderson.ca}}
\\maketitle
\\noindent
See \\url{https://gist.github.com/seananderson/6503371} for the 
R script to generate this file.
"

postamble <- "\\end{document}"

writeLines(preamble, con = "knitr-themes.Rnw")
sapply(themes, function(th) {
sink("knitr-themes.Rnw", append = TRUE)
  cat(opening_no_echo)
  cat(paste0("knit_theme$set(\"", th, "\")\n"))
  cat(closing)
  cat(opening)
  cat(paste0("# ", th, "\n"))
  cat(r_text)
  cat(closing)
sink()
})
sink("knitr-themes.Rnw", append = TRUE)
cat(postamble)
sink()

knit("knitr-themes.Rnw")
system("pdflatex knitr-themes.tex")
