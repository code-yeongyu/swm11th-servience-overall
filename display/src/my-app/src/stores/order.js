import axios from 'axios'
import { observable, action } from 'mobx'
import baseURL from 'config/baseURL'

export default class OrderStore {
    @observable orders = []

    @action addOrder = (element) => {
        this.orders.push(element)
    }

    @action removeOrder = (element) => {
        this.orders.spilce(element)
    }

    @action syncOrders = () => {
        axios.get(baseURL + "/orders")
            .then((response) => {
            console.log(response)
        })
    }
}