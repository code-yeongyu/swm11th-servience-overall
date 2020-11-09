import React, { Component } from 'react'
import { observer, inject } from 'mobx-react'
import {toJS} from 'mobx'
import './Cup.css'

@inject('OrderStore')
@observer
class Cup extends Component {
    // cup status 반영하는 내용 짜기
    render() {
        const cupPosition = parseInt(this.props.match.params.cup_position)
        const { OrderStore } = this.props
        const arrivedStatus = OrderStore.arrivedStatus.isArrived

        if (!arrivedStatus.isArrived) {
            return <Redirect to="/moving" />
        }

        const cups = OrderStore.extractServingQueue()
        const items = cups.map(cup => cup.menu+"")
        const filteredItems = items.map(filtered => {
            filtered = filtered.split(" ")
            filtered.splice(1, 0, <br />);
            return filtered
        })

        
        
        return (
            <div>
                <div className="outer">
                    <span className={cupPosition === 0 ? "circle-selected": "circle"}>{filteredItems[0].map(item => item)}</span>
                    <span className={cupPosition === 1 ? "circle-selected": "circle"}>{filteredItems[1].map(item => item)}</span>
                </div>
                <div className="outer">
                    <span className={cupPosition === 2 ? "circle-selected": "circle"}>{filteredItems[2].map(item => item)}</span>
                    <span className={cupPosition === 3 ? "circle-selected": "circle"}>{filteredItems[3].map(item => item)}</span>
                </div>
            </div>
        )
    }
}

export default Cup