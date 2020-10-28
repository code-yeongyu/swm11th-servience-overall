import React from 'react'
import { Card, CardBody, CardTitle, CardSubtitle } from 'reactstrap'
import "./order.css"

const Order = () => {
    return (
        <div className="order-card">
            <Card>
                <CardBody>
                    <CardTitle><h2>1번 테이블 - 김성수</h2></CardTitle>
                    <br/>
                    <CardSubtitle><h4>아메리카노, 카페라떼</h4></CardSubtitle>
                </CardBody>
            </Card>
        </div>
    )
}

export default Order