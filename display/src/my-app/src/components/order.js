import React from 'react'
import { Card, CardBody, CardTitle, CardSubtitle } from 'reactstrap'
import "./order.css"

const Order = (props) => {
    return (
        <div className="order-card">
            <Card>
                <CardBody>
                    <CardTitle><h2>테이블 {props.tableNumber} - {props.name}</h2></CardTitle>
                    <br/>
                    <CardSubtitle><h4>{props.menu}</h4></CardSubtitle>
                </CardBody>
            </Card>
        </div>
    )
}

export default Order