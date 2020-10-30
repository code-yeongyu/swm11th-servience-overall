import React from 'react'
import { Card, CardBody, CardTitle, CardSubtitle } from 'reactstrap'
import "./order.css"

const Order = (props) => {
    let i = 0
    const menuItems = props.menu.map(menu => {
        return <p key={i++}>{menu}</p>
    });
    return (
        <div className="order-card">
            <Card>
                <CardBody>
                    <CardTitle><h2>테이블 {props.tableNumber} - {props.name}</h2></CardTitle>
                    <br/>
                    <CardSubtitle><h4>{menuItems}</h4></CardSubtitle>
                </CardBody>
            </Card>
        </div>
    )
}

export default Order