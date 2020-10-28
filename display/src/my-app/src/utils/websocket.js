let websocket = new WebSocket("3.35.95.187:3000/display")
websocket.onopen = (event) => {
    websocket.send(JSON.stringify({
        "flag": "auth",
        "id": localStorage.getItem("robotID")
    }))
}

websocket.onmesage = (event) => {
    let data = JSON.parse(event.data)
    if (data.target_object === "ORDER") {
        if (data.type === "ADD") {
            // add order
        } else if (data.type === "UPDATE") {
            // serving done
        }
    } else if (data.target_object === "CUP") {
        // update cup
    }
}