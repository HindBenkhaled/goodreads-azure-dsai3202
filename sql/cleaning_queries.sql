Table.AddColumn(DeltaTable, "noZone", each let
    split_date = Text.Split([date_added], " "),  // Split by space
    date_time = Text.Combine(List.FirstN(split_date, 4), " "),  // Take first 4 elements (Day Month Day Time)
    year = List.Last(split_date)  // Take last element (Year)
in
    date_time & " " & year)


    Table.AddColumn(#"Added custom", "date_part", each let
    // Extract the date part and time from noZone, preserving the full year
    date_part = Text.Middle([noZone], 4, Text.Length([noZone]) - 8)  // Correct extraction of 'Jun 15 17:49:56'
in
    date_part)



    let
    year = Text.End([date_added], 4)  // Extracts '2008'
in
    year


    let
    // Extract year and date part
    year = [year],
    date_part = [date_part],

    // Map month name to number
    month_name = Text.Start(date_part, 3),
    month_number = 
        if month_name = "Jan" then "01" 
        else if month_name = "Feb" then "02" 
        else if month_name = "Mar" then "03" 
        else if month_name = "Apr" then "04" 
        else if month_name = "May" then "05" 
        else if month_name = "Jun" then "06" 
        else if month_name = "Jul" then "07" 
        else if month_name = "Aug" then "08" 
        else if month_name = "Sep" then "09" 
        else if month_name = "Oct" then "10" 
        else if month_name = "Nov" then "11" 
        else if month_name = "Dec" then "12" 
        else "Unknown",  

    formatted_date = year & "-" & month_number & "-" & Text.Middle(date_part, 4, 2) & " " & Text.End(date_part, 8)
in
    formatted_date


Table.TransformColumnTypes(#"Added custom 3", {{"formatted_date", type datetime}, {"n_votes", Int64.Type}})


Table.SelectRows(#"Changed column type", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))



Table.SelectRows(#"Removed blank rows", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))


Table.SelectRows(#"Removed blank rows 1", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))

let
    review_length = Text.Length([review_text])
in
    review_length


Table.SelectRows(#"Added custom 4", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))


Table.SelectRows(#"Removed blank rows 3", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null})))


Table.SelectRows(#"Removed blank rows 4", each [review_length] > 10)

Table.SelectRows(#"Filtered rows", each [formatted_date] < #datetime(2025, 11, 7, 0, 0, 0))

Table.ReplaceValue(#"Filtered rows 1", null, 0, Replacer.ReplaceValue, {"n_votes"})


Table.ReplaceValue(#"Replaced value", null, "Unknown", Replacer.ReplaceValue, {"language_code"})

Table.TransformColumns(#"Replaced value 1", {{"title", each Text.Trim(_), type nullable text}})


Table.TransformColumns(#"Trimmed text", {{"author_name", each Text.Trim(_), type nullable text}})


Table.TransformColumns(#"Trimmed text 1", {{"review_text", each Text.Trim(_), type nullable text}})

Table.TransformColumns(#"Trimmed text 2", {{"title", each Text.Proper(_), type nullable text}})



Table.TransformColumns(#"Capitalized each word", {{"author_name", each Text.Proper(_), type nullable text}})

