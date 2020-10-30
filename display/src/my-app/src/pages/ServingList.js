import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { Row, Col, Button } from 'reactstrap'
import ServingElement from 'components/servingElement'
import { observer, inject } from 'mobx-react'
import './SelectMenu.css'

@inject('OrderStore')
@observer
class SelectMenu extends Component {
    _renderServingElements = orders => {
        let i = 0
        const { OrderStore } = this.props
        const servingComponents = orders.map(order => {
            return <Col key={i}><ServingElement tableNumber={order.table_id} name={order.orderer} menu={order.menu} onDelete={() => {
                OrderStore.removeServingQueue(i++)
            }} /></Col>
        });
        return servingComponents
    }

    render() {
        const isSetted = !!localStorage.getItem("robotID")
        const { OrderStore } = this.props
        
        if (!isSetted) {
            return <Redirect to="/setup" />
        }
        if (OrderStore.selectingOrder) {
            return <Redirect to="/select_order" />
        }

        return (
            <div className="select-menu">
                <Button id="exitButton" color="danger" size="lg" onClick={() => {this.props.history.push("/")}}>X</Button>
                <Row className="orders-wrapper">
                    <Row className="orders">
                        <Row xs={OrderStore.getOrders().length > 2 ? 3 : "auto"}>
                            {OrderStore.getOrders() ? this._renderServingElements(OrderStore.servingQueue) : null }
                        </Row>
                    </Row>
                </Row>
            </div>
        ) 
    }
}

export default SelectMenu