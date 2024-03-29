//
//  AddBookView.swift
//  Bookworm
//
//  Created by Sonja Ek on 29.10.2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now

                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(validDetails(title: title, author: author) == false)
            }
            .navigationTitle("Add Book")
        }
    }
}

func validDetails(title: String, author: String) -> Bool {
    if title.trimmingCharacters(in: .whitespaces).isEmpty ||
        author.trimmingCharacters(in: .whitespaces).isEmpty {
        return false
    }
    return true
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
