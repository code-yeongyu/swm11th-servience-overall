import React from 'react'
import './SelectMenu.css'
import { Row, Col } from 'reactstrap'
import ServingElement from 'components/servingElement'

const SelectMenu = () => {
    return (
        <div className="select-menu">
            <Row className="orders-wrapper">
                <Row className="orders">
                    <Row xs="3">
                        <Col><ServingElement /></Col>
                        <Col><ServingElement /></Col>
                        <Col><ServingElement /></Col>
                        <Col><ServingElement /></Col>
                    </Row>
                </Row>
            </Row>
        </div>
    )
}

export default SelectMenu