import React, { Component } from 'react'
import { observer, inject } from 'mobx-react'
import './Cup.css'

@inject('OrderStore')
@observer
class Cup extends Component {
    // cup status 반영하는 내용 짜기
    render() {
        const { OrderStore } = this.props;
        const cups = OrderStore.extractServingQueue()
        console.log(`${cups[0].menu}`)
        console.log(`${cups[1].menu}`)
        console.log(`${cups[2].menu}`)
        console.log(`${cups[3].menu}`)
        return (
            <div>
                <div className="outer">
                    <span class="circle">{cups[0].menu}</span>
                    <span class="circle">{cups[1].menu}</span>
                </div>
                <div className="outer">
                    <span class="circle">{cups[2].menu}</span>
                    <span class="circle">{cups[3].menu}</span>
                </div>
            </div>
        ) 
    }
}

export default Cup