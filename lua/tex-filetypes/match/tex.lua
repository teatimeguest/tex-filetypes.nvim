return {
  ---@type [string, string, string?][]
  match_words = {
    {
      [[\\begin\s*{frame}]],
      [[\\\%(frame\|page\)break\>]],
      [[\\end\s*{frame}]],
    },
    {
      [[\\begin\s*{mathpar}]],
      [[\\\%(and\>\|\\\)]],
      [[\\end\s*{mathpar}]],
    },
    {
      [[\\begin\s*{tcolorbox}]],
      [[\\tcbl\%(ower\|ine\)\>]],
      [[\\end\s*{tcolorbox}]],
    },
    {
      [[\\begin\s*{\(tcb\%(oxed\)\?itemize\)}]],
      [[\\tcbitem\>]],
      [[\\end\s*{\1}]],
    },
  },
}
