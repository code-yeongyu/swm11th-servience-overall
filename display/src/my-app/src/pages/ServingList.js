import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { Col, Button } from 'reactstrap'
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
            return <Redirect to={"/select_order/"+OrderStore.selectedCupID} />
        }

        const cups = OrderStore.extractServingQueue()
        const items = cups.map(cup => cup.menu+"")
        const filteredItems = items.map(filtered => {
            filtered = filtered.split(" ")
            filtered.splice(1, 0, <br />);
            return filtered
        })
        
        return (
            <div>
                <Button id="exitButton" color="danger" size="lg" onClick={() => {this.props.history.push("/")}}>X</Button>
                <div className="outer">
                    <span className="circle">{filteredItems[0].map(item => item)}</span>
                    <span className="circle">{filteredItems[1].map(item => item)}</span>
                </div>
                <div className="outer">
                    <span className="circle">{filteredItems[3].map(item => item)}</span>
                    <span className="circle">{filteredItems[2].map(item => item)}</span>
                </div>
            </div>
        ) 
    }
}

export default SelectMenu