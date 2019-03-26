

### Define function to determine file path of executing script

Source: <https://stackoverflow.com/a/36777602/7196903>

```{r purl = FALSE}
get_executing_script_path <- function()
{
  cmd_args <- commandArgs(trailingOnly = FALSE)
  needle <- "--file="
  match <- grep(x = cmd_args, pattern = needle)
  
  if ( length(match) > 0 )
  {
    # Rscript
    return(normalizePath(sub(needle, "", cmd_args[match])))
    
  } else
  {
    if ( !is.null(sys.frames()[[1]]$ofile) )
    {
      # `source()`d via R console
      return(normalizePath(sys.frames()[[1]]$ofile))
      
    } else
    {
      # RStudio Run Selection
      # http://stackoverflow.com/a/35842176/2292993  
      return(normalizePath(rstudioapi::getActiveDocumentContext()$path))
    }
  }
}
```

