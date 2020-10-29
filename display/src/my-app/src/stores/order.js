import axios from 'axios'
import { observable, action, makeAutoObservable } from 'mobx'
import baseURL from 'config/baseURL'

class OrderStore {
    constructor(){
      makeAutoObservable(this)
    }

    @observable orders = []
    @observable testNumber = 0

    @action increase = () => this.testNumber++

    @action decrease = () => this.testNumber--

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
                this.orders.length = 0
                this.orders += data.orders
            }
        )
    }
}

const orderStore = new OrderStore();

export default orderStore;