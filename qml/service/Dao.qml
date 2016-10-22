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

    function addBook(bookName, bookDir) {
        //~ TODO: load in C++ code?
        var coverImage = ""
        var playText = ""
        var length = 0
        database.transaction(function(tx) {
            tx.executeSql("INSERT INTO BooksDatabase(bookName, coverImage,
            playText, bookDir, duration) VALUES(?)", [bookName, coverImage,
            playText, length]);
        });
    }

    function retrieveAllBooks(callback) {
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

