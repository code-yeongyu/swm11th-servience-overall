import React from 'react'
import { Card, CardBody, CardSubtitle } from 'reactstrap'
import "./order.css"

const Item = (props) => {
    return (
        <div className="order-card" onClick={props.onClick}>
            <Card>
                <CardBody>
                    <CardSubtitle><h4>{props.menu}</h4></CardSubtitle>
                </CardBody>
            </Card>
        </div>
    )
}

export default Item