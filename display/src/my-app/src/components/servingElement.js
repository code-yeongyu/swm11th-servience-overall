import React from 'react'
import { Card, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap'

const ServingElement = () => {
    return (
        <div className="order-card">
            <Card>
                <CardBody>
                    <CardTitle><h1>1번 테이블 - 김성수</h1></CardTitle>
                    <br/>
                    <CardSubtitle><h2>아메리카노, 카페라떼</h2></CardSubtitle>
                    <Button color="danger" size="lg">삭제</Button>
                </CardBody>
            </Card>
        </div>
    )
}

export default ServingElement