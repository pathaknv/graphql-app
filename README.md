# GraphQL sample API only rails app

Following are some sample queries

### Query Types:
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
