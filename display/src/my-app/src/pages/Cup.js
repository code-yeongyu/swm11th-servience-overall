import React, { Component } from 'react'
import { observer, inject } from 'mobx-react'
import './Cup.css'

@inject('OrderStore')
@observer
class Cup extends Component {
    // cup status 반영하는 내용 짜기
    render() {
        const cupPosition = parseInt(this.props.match.params.cup_position)
        const { OrderStore } = this.props
        const cups = OrderStore.extractServingQueue()
        return (
            <div>
                <div className="outer">
                    <span class={cupPosition === 0 ? "circle-selected": "circle"}>{cups[0].menu}</span>
                    <span class={cupPosition === 1 ? "circle-selected": "circle"}>{cups[1].menu}</span>
                </div>
                <div className="outer">
                    <span class={cupPosition === 2 ? "circle-selected": "circle"}>{cups[2].menu}</span>
                    <span class={cupPosition === 3 ? "circle-selected": "circle"}>{cups[3].menu}</span>
                </div>
            </div>
        ) 
    }
}

export default Cup