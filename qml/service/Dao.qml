import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property var database

    Component.onCompleted: {
        database = LocalStorage.openDatabaseSync("BooksDatabase", "1.0",
            "Database to store active books", 1000000);
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS BooksDatabase(
                 id INTEGER PRIMARY KEY, file_pos INTEGER, time_pos INTEGER,
                  TEXT)");
        });
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS BooksPositions(
                 id INTEGER PRIMARY KEY, file_pos INTEGER, time_pos INTEGER,
                  TEXT)");
        });
    }

    function addBook(book) {
        database.transaction(function(tx) {
            tx.executeSql("INSERT INTO BooksDatabase(book) VALUES(?)", [book]);
        });
    }

    function retrieveAllBooks(callback) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM BooksDatabase");
            callback(result.rows);
        });
    }

    function clearBooks() {
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM BookDatabase");
        });
    }
}

