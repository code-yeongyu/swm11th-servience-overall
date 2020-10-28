import React from 'react'
import './SelectMenu.css'
import { Row, Col } from 'reactstrap'
import Order from 'components/order'

const SelectMenu = () => {
    return (
        <div className="select-menu">
            <Row className="orders-wrapper">
                <Row className="orders">
                    <Row xs="3">
                        <Col><Order /></Col>
                        <Col><Order /></Col>
                        <Col><Order /></Col>
                        <Col><Order /></Col>
                        <Col><Order /></Col>
                    </Row>
                </Row>
            </Row>
        </div>
    )
}

export default SelectMenu