import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property var database

    Component.onCompleted: {
        console.log("Initialized DAO")
        database = LocalStorage.openDatabaseSync("BooksDB", "1.0",
            "Database to store active books", 1000000);
        database.transaction(function(tx) {
            //tx.executeSql("DROP TABLE BooksDatabase;");
            //tx.executeSql("DROP TABLE FilesDatabase;");
            //tx.executeSql("DROP TABLE BooksPositions;");
            tx.executeSql("CREATE TABLE IF NOT EXISTS BooksDatabase(
                id INTEGER PRIMARY KEY, bookName TEXT, coverImage TEXT, playText TEXT,
                bookDir TEXT, duration INTEGER);");
//            tx.executeSql("INSERT INTO BooksDatabase(bookName, coverImage, playText,
//                bookDir, duration) VALUES('SuperBook sample', '', '', '/dev/null', 300);");
            tx.executeSql("CREATE TABLE IF NOT EXISTS FilesDatabase(
                 id INTEGER PRIMARY KEY, path TEXT, book_id INTEGER);");
            tx.executeSql("CREATE TABLE IF NOT EXISTS BooksPositions(
                 id INTEGER PRIMARY KEY, file_pos INTEGER, time_pos INTEGER, book_id INTEGER);");
        });
    }

    function addBook(bookName, bookDir, coverImage, playText, length, files) {
        database.transaction(function(tx) {
            tx.executeSql("INSERT INTO BooksDatabase(bookName, coverImage,
            playText, bookDir, duration) VALUES('"+bookName +"', '" + coverImage+"', '" +
            playText+"', '" +bookDir+"', " + length + ");");
        });
        var id = -1;
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksDatabase WHERE bookDir = '" + bookDir + "';")
            id = result.rows.item(0).id;
        });
        if (id > 0) {
            database.transaction(function(tx) {
                tx.executeSql("INSERT INTO BooksPositions(book_id, file_pos, time_pos) VALUES("+id +", -1, 0);");
                for (var i in files) {
//                    console.log("Adding " + files[i] + ' to book ' + id)
                    tx.executeSql("INSERT INTO FilesDatabase(book_id, path) VALUES(" + id + ", '" + files[i].replace("'", "\'") + "');");
                }
            });
        }
    }

    //+ @brief returns current file according to list
    function getFile(id) {
        var filepos = -1;
        var timepos = -1;
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksPositions WHERE book_id = '" + id + "';")
            if (result.rows.length > 0) {
                filepos = result.rows.item(0).file_pos;
                timepos = result.rows.item(0).time_pos;
            }
        });
        var curFile = ""
        var nextFile = ""
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM FilesDatabase WHERE book_id = '" + id + "';")
            if (result.rows.length > 0) {
                console.log("FOund " + result.rows.length + " files...")
                curFile = 0
                for (var i = 0; i < result.rows.length; i++)
                {
                    if(result.rows.item(i).id === filepos)
                        curfile = i
                }
                if (curFile + 1 < result.rows.length)
                    nextFile = result.rows.item(curFile + 1).path;
                else nextFile = result.rows.item(0).path;
                curFile = result.rows.item(curFile).path;
            }
        });
        if (timepos < 0) timepos = 0
        return [curFile, nextFile, timepos]
    }

    function updateBookName(id, str) {
        database.transaction(function(tx) {
            tx.executeSql("UPDATE BooksDatabase SET bookName = '"+str+"' WHERE id = " + id);
        });
    }

    function removeBook(id) {
        console.log("Removing book " + id)
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM BooksDatabase WHERE id = " + id);
        });
    }

    function retrieveAllBooks(callback) {
        bookList.clear()
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksDatabase");
            for(var i = 0; i < result.rows.length; i++) {
                var message = result.rows.item(i);
                bookList.append(message);
            }
        });
    }

    function clearBooks() {
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM BookDatabase");
        });
    }

    function getPosition(book_id) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksPositions");
            try {
              var sOut = result.rows.item(0);
            } catch(e) {
              return -1;
            }
            return sOut.time_pos;
        });
    }

    function getPlayableFile(book_id) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksDatabase");
            callback(result.rows);
        });
    }

    function savePosition(book_id, file, time) {

    }
}

