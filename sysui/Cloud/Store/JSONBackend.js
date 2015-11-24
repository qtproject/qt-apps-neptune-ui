/****************************************************************************
**
** Copyright (C) 2015 Pelagicore AG
** Contact: http://www.qt.io/ or http://www.pelagicore.com/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL3-PELAGICORE$
** Commercial License Usage
** Licensees holding valid commercial Pelagicore Neptune IVI UI
** licenses may use this file in accordance with the commercial license
** agreement provided with the Software or, alternatively, in accordance
** with the terms contained in a written agreement between you and
** Pelagicore. For licensing terms and conditions, contact us at:
** http://www.pelagicore.com.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU General Public License version 3 requirements will be
** met: http://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

.pragma library

var request = new XMLHttpRequest()
var errorCounter = 0
var errorFunc = 0

//Will be called when the error is not responding after a few tries
function setErrorFunction(func) {
    errorFunc = func
}

function serverCall(url, data, dataReadyFunction, xhr) {
    var i = 0
    for (var key in data)
    {
        if (i === 0) {
            url += "?" + key + "=" + data[key];
        } else {
            url += "&" + key+ "=" + data[key];
        }
        i++
    }

    //when no xhr is defined use the global one and reuse it
    if (xhr == undefined) {
        xhr = new XMLHttpRequest()
    }

    console.log("HTTP GET to " + url);
    if (xhr.readyState != 0) {
        xhr.abort();
    }
    xhr.open("GET", url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            //print(xhr.responseText);

            if (xhr.responseText !== "") {
                errorCounter = 0
                var data = JSON.parse(xhr.responseText);
                return dataReadyFunction(data)
            } else {
                print("JSONBackend: " + xhr.status + xhr.statusText)
                errorCounter++
                if (errorCounter >= 3 && errorFunc) {
                    errorFunc()
                }

                return dataReadyFunction(0)
            }
        }
    }
    xhr.send();
}

function abortableServerCall(url, data, dataReadyFunction) {
    serverCall(url,data,dataReadyFunction,request)
}
