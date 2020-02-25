# GraphQL sample API only rails app

Following are some sample queries

### Query Types:
```
query fetchUser {
  user(id: 9) {
    id
    name
    email
  }
}
```

```
query fetchUsers {
  users {
    id
    name
    email
    booksCount
    books {
      id
      title
    }
  }
}
```

```
query fetchLimitedBooksOfUsers {
  users {
    id
    name
    email
    booksCount
    books(limit: 2) {
      id
      title
    }
  }
}
```

```
query fetchLimitedUsers {
  users(page: 2, limit: 3) {
    id
    name
    email
    booksCount
    books {
      id
      title
    }
  }
}
```

```
query fetchBook {
  book(id: 1) {
    id
    title
    userName
  }
}
```

```
query fetchBooks {
  books {
    id
    title
    userName
  }
}
```

```
query fetchLimitedBooks {
  books(page: 2, limit: 4) {
    id
    title
    userName
  }
}
```


### Mutations:

```
mutation createUser {
  createUser(input: { name: "Nikhil Pathak", email: "nikhil@gmail.com" }) {
    user {
      id
      name
      email
    }
    errors
  }
}
```

```
mutation updateUser {
  updateUser(input: { id: 9, email: "nikhil.pathak@gmail.com" }) {
    user {
      id
      name
      email
    }
    errors
  }
}
```

```
mutation deleteUser {
  deleteUser(input: { id: 9 }) {
    message
  }
}
```

```
mutation createBook {
  createBook(input: { userId: 7, title: "Harry Potter - Part 1" }) {
    book {
      id
      title
      userName
    }
    errors
  }
}
```

```
mutation updateBook {
  updateBook(input: { id: 23, title: "Harry Potter - Philosopher Stone" }) {
    book {
      id
      title
      userName
    }
    errors
  }
}
```

```
mutation deleteBook {
  deleteBook(input: { id: 23 }) {
    message
  }
}
```