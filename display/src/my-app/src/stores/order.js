import axios from 'axios'
import { observable, action, makeAutoObservable } from 'mobx'
import baseURL from 'config/baseURL'

class OrderStore {
    constructor(){
      makeAutoObservable(this)
    }

    @observable orders = []
    isWebsocketEnabled = false

    

    @action
    addOrder = (element) => {
        this.orders.push(element)
    }

    @action
    removeOrder = (element) => {
        this.orders.spilce(element)
    }

    @action
    syncOrders = () => {
        axios.get(baseURL + "/order")
            .then((response) => response.data)
            .then((data) => {
                this.orders = data.orders
            }
        )
    }

    @action
    activateWebsocket() {
        if (this.isWebsocketEnabled)
            return
        this.isWebsocketEnabled = true

        let websocket = new WebSocket("ws://3.35.95.187:3000/display")

        websocket.onopen = function (evt) { 
            console.log("Connection established")
            let robotID = localStorage.getItem("robotID")
            websocket.send(JSON.stringify({
                "flag": "auth",
                "id": robotID ? robotID : "default"
            }))
         }
        websocket.onmessage = this.syncOrders
    }

    getOrders = () => {
        return this.orders
    }
}

const orderStore = new OrderStore();

export default orderStore;