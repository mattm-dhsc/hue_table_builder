
#' get_query_from_json
#'
#' NHSD have published a guide on how to access HES using DAE. This goes through
#' the process of how to export a query, which notes that the query is output in
#' JSON format, but does not tell you how to extract the plaintext of the query
#' you ran.
#' 
#' This function takes a JSON downloaded from DAE and extracts the query.
#' 
#' https://digital.nhs.uk/binaries/content/assets/website-assets/services/data-access-environment-dae/accessing-hes-with-dae.pdf
#'
#'
#' @param json_file path to JSON file as exported from DAE HUE 
#'
#' @return charachter vector with query text.
#' @export
#'
#' @examples
get_query_from_json <- function(json_file){
  
  require(jsonlite)
  
  # Parse the JSON file using jsonlite to get a nested list
  json_parsed <- jsonlite::read_json(path = json_file)
  
  # extract the data field where the queries are located
  json_data <- json_parsed[[1]]$fields$data
  
  # The data field comprises of a string, which is actually JSON itself, nested
  # within the top level JSON. So, again, we parse this to convert it to a list
  nested_json <- jsonlite::parse_json(json_data)
  
  # Now that its a list, we can extract the query:
  query <- nested_json$snippets[[1]]$statement_raw
  
  return(query)
}


