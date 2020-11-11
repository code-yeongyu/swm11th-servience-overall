import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import { observer, inject } from 'mobx-react'
import './Moving.css'

@inject('OrderStore')
@observer
class Moving extends Component {
    isIDEmpty = (IDs) => {
        for (let i = 0; i < IDs.length; i++) {
            const id = IDs
            if (id !== "")
                return false
        }
        return true
    }

    render() {
        const { OrderStore } = this.props
        const arrivedStatus = OrderStore.arrivedStatus.isArrived
        if (arrivedStatus.isArrived) {
            return <Redirect to={"/cup/"+arrivedStatus.table_id} />
        }
        
        const servingQueue = OrderStore.extractServingQueue()
        const IDs = servingQueue.map(queue => queue._id)
        
        if (this.isIDEmpty(IDs)) {
            return <Redirect to="/" />
        }

        return (
            <div className="moving full-center">
                <p>커피가</p>
                <p>배송중이에요</p>
            </div>
        )
    }
}

export default Moving