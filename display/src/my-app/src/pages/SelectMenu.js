import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { Row, Col } from 'reactstrap'
import Order from 'components/order'
import { observer, inject } from 'mobx-react'
import './SelectMenu.css'

// todo
// get id from the props and print the menus from the given id

@inject('OrderStore')
@observer
class SelectMenu extends Component {
    _renderOrders = orders => {
        let i = 0
        const orderComponents = orders.map(order => {
            return <Col key={i++}><Order tableNumber={order.table_id} name={order.orderer} menu={order.menu} /></Col>
        });
        return orderComponents
    }

    constructor(props) {
        super(props)
        const { OrderStore } = props
        OrderStore.syncOrders()
        OrderStore.activateWebsocket()
    }

    render() {
        const isSetted = !!localStorage.getItem("robotID")
        const { OrderStore } = this.props
        const index = this.props.match.params.index
        const orders = OrderStore.getOrders()
        const order = orders[index]

        if (!order) {
            return (
                <Redirect to="/setup" />
            )
        }

        const menu = order.menu

        if (!isSetted) {
            return (
                <Redirect to="/setup" />
            )
        }
        if (!OrderStore.selectingOrder) {
            return <Redirect to="/" />
        }
        
        if (menu.length === 0) {
            return <Redirect to="/" />
        }

        if (menu.length === 1) {
            order.position = OrderStore.selectedCupID
            OrderStore.doneSelectOrder()
            OrderStore.addServingQueue(order)
        }

        return (
            <div className="select-menu">
                <Row>
                    <h2 id="title">해당 메뉴를 선택해주세요</h2>
                </Row>
                <Row className="orders-wrapper">
                        <Row className="orders">
                            <Row xs={OrderStore.getOrders().length > 2 ? 3 : "auto"}>
                                { OrderStore.getOrders() ? this._renderOrders(OrderStore.getOrders()) : null }
                            </Row>
                        </Row>
                </Row>
            </div>
        )
    }
}

export default SelectMenu