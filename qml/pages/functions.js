.pragma library

function durationString(length) {
    var iMinutes = Math.floor(length / 60)
    var iSeconds = (length % 60)
    var iHours = Math.floor(length / 3600)

    var output

    if(iMinutes <= 99)
    {
        if (iMinutes.toString().length == 1)
            iMinutes = ("0" + iMinutes)

        if (iSeconds.toString().length == 1)
            iSeconds = ("0" + iSeconds)

        output = iMinutes + ":" + iSeconds
    }
    else
    {
        output = iHours + ":" + iMinutes + ":" + iSeconds
    }

    return output
}

function endsWith(s1, s2) {
    var str = s1 + ""
    return str.search(s2) === str.length - s2.length
}

function checkImages(path, fm) {
    fm.nameFilters = ["*.jpg", "*.png"]     //~ doesn't work
    fm.folder = path
    for (var i = 0; i < fm.count; i++) {
        var fn = fm.get(i, "fileName")
        if (endsWith(fn, ".jpg") || endsWith(fn, ".png"))
            return true
    }
    return false
}

function checkMusic(path, fm) {
    fm.folder = path
    fm.nameFilters = [ "*.mp3", "*.ogg", "*.aac"]
    for (var i = 0; i < fm.count; i++) {
        var fn = fm.get(i, "fileName")
        if (endsWith(fn, ".mp3") || endsWith(fn, ".ogg"))
            return true
    }
    //if (fm.count > 0) return true;
    //fm.folder = path
    var subdirs = []
    //console.log(fm.folder)
    for (i = 0; i < fm.count; i++) {
        subdirs.push(fm.get(i, "filePath"))
        console.log("Adding subfolder" + fm.get(i, "filePath"))
    }
    fm.showFiles = true
    fm.showDirs = false
    for (var s in subdirs)
    {
        console.log("Scanning" + subdirs[s])
        fm.folder = subdirs[s]
        console.log(fm.count + " books in subdirs of " + fm.folder)
        for (i = 0; i < fm.count; i++) {
            fn = fm.get(i, "fileName")
            if (endsWith(fn, ".mp3") || endsWith(fn, ".ogg"))
                return true
        }
    }

    return false
}   //+ checkMusic

function scanFolder(path, fm) {
  //~ for each folder that has music && cover -> addDB
}   //+ scanFolder
