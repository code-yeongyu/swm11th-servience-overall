import axios from 'axios'
import { observable, action, makeAutoObservable, toJS, computed } from 'mobx'
import baseURL from 'config/baseURL'

class OrderStore {
    constructor(){
      makeAutoObservable(this)
    }

    @observable orders = []
    @observable cup = [false, false, false, false]
    @observable selectingOrder = false
    @observable selectedCupID = -1
    @observable servingQueue = []
    isWebsocketEnabled = false
    

    @action _websocketHandler = (event) => {
        let data = JSON.parse(event.data)
        if (data.target_object === "ORDER") {
            return axios.get(baseURL + "/order")
                .then((response) => response.data)
                .then((data) => {
                    this.orders = data.orders
                })
        } else if (data.target_object === "CUP") {
            for (let i = 0; i < this.cup.length; i++) {
                if (this.cup[i] !== data.content.status[i]) { // if changes had made in this index
                    this.cup[i] = data.content.status[i]
                    if (this.cup[i]) { // if cup inserted
                        this.selectingOrder = true
                        this.selectedCupID = i
                    } else {  // if cup ejected
                        this.selectingOrder = false
                        //find one with the cup id from the servingque
                        for (let i = 0; i < this.servingQueue.length; i++) {
                            const element = this.servingQueue[i]
                            if (element.position === this.selectedCupID) {
                                this.servingQueue.splice(i, 1)
                                break
                            }
                        }

                        this.selectedCupID = -1
                    }
                    break
                }
            }
        }
    }
    @computed getOrders = () => {
        const IDofServingQueue = this.servingQueue.map(order => {
            return order._id
        })
        const waitingOrders = []
        for (let i = 0; i < this.orders.length; i++) {
            const order = this.orders[i]
            if (!IDofServingQueue.includes(order._id)) {
                waitingOrders.push(order)
            }
        }
        return waitingOrders
    }

    @action addOrder = (element) => {
        this.orders.push(element)
    }
    @action removeOrder = (element) => {
        this.orders.spilce(element)
    }
    @action syncOrders = () => {
        axios.get(baseURL + "/order")
            .then((response) => response.data)
            .then((data) => {
                this.orders = data.orders
            }
        )
    }
    @action activateWebsocket() {
        if (this.isWebsocketEnabled)
            return
        this.isWebsocketEnabled = true

        let websocket = new WebSocket("ws://3.35.95.187:3000/display")

        websocket.onopen = function (evt) { 
            let robotID = localStorage.getItem("robotID")
            websocket.send(JSON.stringify({
                "flag": "auth",
                "id": robotID ? robotID : "default"
            }))
         }
        websocket.onmessage = this._websocketHandler
        websocket.onerror = () => setTimeout(() => window.location.reload(), 5000)
        websocket.onclose = () => setTimeout(() => window.location.reload(), 5000)
    }

    @action doneSelectOrder = () => {
        this.selectingOrder = false
    }

    @action addServingQueue(element) {
        this.servingQueue.push(element)
    }
    @action removeServingQueue(index) {
        this.servingQueue.splice(index, 1)
    }
    @action clearServingQueue(element) {
        this.servingQueue = []
    }
}

const orderStore = new OrderStore();

export default orderStore;