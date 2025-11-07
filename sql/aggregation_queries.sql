
//Average rating per BookID
let
    // Load the data from the 'data_cleaning' query
    Source = data_cleaning,

    // Group by 'book_id' and calculate the average rating for each book
    avg_rating_per_book_id = Table.Group(
        Source, 
        {"book_id"}, 
        {{"average_rating_per_book", each List.Average([rating]), type nullable number}}
    )

in
    avg_rating_per_book_id


//Number of reviews per BookID.
Table.Group(Source, {"book_id"}, {{"number_of_reviews", each Table.RowCount(_), Int64.Type}})

//Average rating per AuthorName
Table.Group(Source, {"author_name"}, {{"average_rating", each List.Average([rating]), type nullable number}})

//Word count statistics on reviews.
Table.Group(Source, {"book_id"}, {{"number_of_reviews", each Table.RowCount(_), type nullable number}})