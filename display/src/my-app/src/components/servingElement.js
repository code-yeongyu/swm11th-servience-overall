import React from 'react'
import { Card, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap'
import "./order.css"

const ServingElement = (props) => {
    let i = 0
    const menuItems = props.menu.map(menu => {
        return <p key={i++}>{menu}</p>
    });
    return (
        <div className="order-card">
            <Card>
                <CardBody>
                    <CardTitle><h1>테이블 {props.tableNumber} - {props.name}</h1></CardTitle>
                    <br/>
                    <CardSubtitle><h2>{menuItems}</h2></CardSubtitle>
                    <Button color="danger" size="lg" onClick={props.onDelete}>삭제</Button>
                </CardBody>
            </Card>
        </div>
    )
}

export default ServingElement