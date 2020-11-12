import axios from 'axios'
import { observable, action, makeAutoObservable, computed } from 'mobx'
import baseURL from 'config/baseURL'

const emptyItem = {
    "menu": [],
    "serving_status": 0,
    "table_id": -1,
    "store_id": "",
    "orderer": "",
    "_id": ""
}

const defaultArrivedStatus = {
    isArrived: false,
    table_id: -1
}

class OrderStore {
    constructor(){
      makeAutoObservable(this)
    }

    @observable orders = []
    @observable cup = [{
        status: false,
        item: emptyItem
    }, {
        status: false,
        item: emptyItem
    }, {
        status: false,
        item: emptyItem
    }, {
        status: false,
        item: emptyItem
    }
    ]
    @observable selectingOrder = false
    @observable selectedCupID = -1
    @observable arrivedStatus = defaultArrivedStatus
    
    @computed extractCupFillingStatus = () => this.cup.map(cup => { return cup.status }) // returns list of cupStatus[i].isFilled
    @computed extractServingQueue = () => this.cup.map(cup => { return cup.item })
    @computed getItemIDs = () => this.cup.map(cup => cup.item._id)

    @action _handleOrder = () => {
        axios.get(baseURL + "/order")
            .then((response) => response.data)
            .then((data) => {
                this.orders = data.orders
            })
    }

    _getCupIDFromServingQueueByTableID = (tableID) => {
        const servingQueue = this.extractServingQueue()
        for (let i = 0; i < servingQueue.length; i++) {
            if (servingQueue[i].table_id === tableID) {
                return i
            }
        }
    }

    @action _handleCup = (data) => {
        const localCup = this.extractCupFillingStatus()
        const serverCup = data.content.status

        // add handling for when serving

        if (this.arrivedStatus.isArrived) {
            const targetCupID = this._getCupIDFromServingQueueByTableID(this.arrivedStatus.table_id)

            if (localCup[targetCupID] !== serverCup[targetCupID]) { // if changes had made in this index
                this.cup[targetCupID].status = data.content.status[targetCupID] // update the current cup status of local
                if (!this.cup[targetCupID].status) { // if cup ejected
                    axios.patch(baseURL+"/order/"+this.cup[targetCupID]._id)
                    this.cup[targetCupID].item = emptyItem
                    this.selectedCupID = -1
                    this.arrivedStatus = {
                        isArrived: false,
                        table_id: -1
                    }
                }
            }
            return
        }


        for (let i = 0; i < this.cup.length; i++) {
            if (localCup[i] !== serverCup[i]) { // if changes had made in this index
                this.cup[i].status = data.content.status[i] // update the current cup status of local
                if (this.cup[i].status) { // if cup inserted
                    this.selectingOrder = true
                    this.selectedCupID = i
                } else {  // if cup ejected
                    this.selectingOrder = false
                    //find one with the cup id from the servingque
                    this.cup[i].item = emptyItem
                    this.selectedCupID = -1
                }
                break
            }
        }
    }

    @action _handleServe = (data) => {
        const table_id = data.content.table_id
        this.arrivedStatus = {
            isArrived: true,
            table_id: table_id
        } // move to cup notifying page when this.isArrived is true
    }

    @action _websocketHandler = (event) => {
        let data = JSON.parse(event.data)
        if (data.target_object === "ORDER") {
            this._handleOrder()
        } else if (data.target_object === "CUP") {
            this._handleCup(data)
        } else if (data.target_object === "SERVE") { // when the robot has arrived to the destination
            this._handleServe(data)
        }
    }
    @computed getOrders = () => {
        const IDofServingQueue = this.extractServingQueue().map(order => {
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
        
        axios.patch(baseURL + "/cup/reset", {
            product_id: localStorage.getItem("robotID")
        })
        
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

    @action fillCup(cupPosition, order) {
        this.cup[cupPosition] = {
            ...this.cup[cupPosition],
            item: order
        }
    }
    @action clearCup(cupPosition) {
        this.cup[cupPosition] = {
            ...this.cup[cupPosition],
            item: emptyItem
        }
    }
}

const orderStore = new OrderStore();

export default orderStore;