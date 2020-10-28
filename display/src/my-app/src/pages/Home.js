import React, {Component} from 'react';
import './Home.css'
import { Row, Col, Button } from 'reactstrap'
import Order from 'components/order'
import { observer, inject } from 'mobx-react'

@inject('orderStore')
@observer
class Home extends Component {
    render() {
        const { orderStore } = this.props;
        return (
            <div className="home">
                <Row className="orders-wrapper">
                    <Row className="orders">
                        <Row xs="3">
                            <Col><Order /></Col>
                            <Col><Order /></Col>
                            <Col><Order /></Col>
                            <Col><Order /></Col>
                            <Col><Order /></Col>
                            <Col><Order /></Col>
                        </Row>
                    </Row>
                </Row>
                <Row className="buttons">
                    <Col xs="6"><Button color="primary" block>출발</Button></Col>
                    <Col xs="6"><Button color="secondary" block>예약된 서빙 목록</Button></Col>
                </Row>
            </div>
        )
    }
}

export default Home