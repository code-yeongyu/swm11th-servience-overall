import React, { Component } from 'react'
import { Route } from 'react-router-dom'
import {Moving, Setup} from 'pages'

class App extends Component {
    render() {
        return (
            <div>
                <Route path="/moving" component={Moving} />
                <Route path="/setup" component={Setup} />
            </div>
        )
    }
}

export default App