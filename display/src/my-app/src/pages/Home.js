import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { Row, Col, Button } from 'reactstrap'
import axios from 'axios'
import { observer, inject } from 'mobx-react'
import './Home.css'
import Order from 'components/order'
import baseURL from 'config/baseURL'


@inject('OrderStore')
@observer
class Home extends Component {
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

    requestServe = () => {
        const { OrderStore } = this.props
        const IDs = OrderStore.getItemIDs()
        const body = {
            order_ids: IDs
        }
        axios.post(baseURL + "/serve", body)
        this.props.history.push('/moving')
    }

    moveToServingList = () => {
        this.props.history.push('/serving_list')
    }
    

    render() {
        const isSetted = !!localStorage.getItem("robotID")
        const { OrderStore } = this.props
        
        if (!isSetted) {
            return <Redirect to="/setup" />
        }
        if (OrderStore.selectingOrder) {
            return <Redirect to={"/select_order/"+OrderStore.selectedCupID} />
        }
        
        return (
            <div className="home">
                <Row className="orders-wrapper">
                    <Row className="orders">
                        <Row xs={OrderStore.getOrders().length > 2 ? 3 : "auto"}>
                            { OrderStore.getOrders() ? this._renderOrders(OrderStore.getOrders()) : null }
                        </Row>
                    </Row>
                </Row>
                <Row className="buttons">
                    <Col xs="6"><Button color="primary" block onClick={this.requestServe}>출발</Button></Col>
                    <Col xs="6"><Button color="secondary" block onClick={this.moveToServingList}>예약된 서빙 목록</Button></Col>
                </Row>
            </div>
        )
    }
}

export default Home