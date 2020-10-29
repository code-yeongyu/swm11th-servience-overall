import React, { Component } from 'react';
import { Row, Col, Button } from 'reactstrap'
import { observer, inject } from 'mobx-react'
import './Home.css'
import Order from 'components/order'

@inject('OrderStore')
@observer
class Home extends Component {
    _renderOrders = orders => {
        let i = 0
        const orderComponents = orders.map(order => {
            return <Col key={++i}><Order tableNumber={order.table_id} name={order.orderer} menu={order.menu} /></Col>
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
        const { OrderStore } = this.props
        return (
            <div className="home">
                <Row className="orders-wrapper">
                    <Row className="orders">
                        <Row xs={OrderStore.orders.length > 2 ? 3 : "auto"}>
                            { OrderStore.orders ? this._renderOrders(OrderStore.orders) : null }
                        </Row>
                    </Row>
                </Row>
                <Row className="buttons">
                    <Col xs="6"><Button color="primary" block>출발</Button></Col>
                    <Col xs="6"><Button color="secondary" block>예약된 서빙 목록</Button></Col>
                </Row>
            </div>
        )
    }
}

export default Home