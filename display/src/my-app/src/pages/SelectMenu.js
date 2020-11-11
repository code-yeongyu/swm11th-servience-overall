import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { Row, Col } from 'reactstrap'
import Item from 'components/item'
import { observer, inject } from 'mobx-react'
import './SelectMenu.css'

// todo
// get id from the props and print the menus from the given id

@inject('OrderStore')
@observer
class SelectMenu extends Component {
    _renderItems = items => {
        const itemComponents = items.map((item, index) => (
            <Col key={index}><Item menu={item} onClick={() => { 
                
             }} /></Col>
        ))

        return itemComponents
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
        const cupPosition = this.props.match.params.cup_position
        const order = OrderStore.getOrders()[index]

        if (!order) {
            return (
                <Redirect to="/" />
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
        
        if (menu.length === 1) {
            order.position = cupPosition
            OrderStore.doneSelectOrder()
            OrderStore.fillCup(cupPosition, order, menu[1])
        }

        return (
            <div className="select-menu">
                <Row>
                    <h2 id="title">해당 메뉴를 선택해주세요</h2>
                </Row>
                <Row className="orders-wrapper">
                        <Row className="orders">
                            <Row xs={order.menu.length > 2 ? 3 : "auto"}>
                                { order.menu ? this._renderItems(order.menu) : null }
                            </Row>
                        </Row>
                </Row>
            </div>
        )
    }
}

export default SelectMenu