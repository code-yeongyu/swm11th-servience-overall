import React, { Component } from 'react'
import { Route } from 'react-router-dom'
import { Home, Moving, Setup, SelectMenu, ServingList } from 'pages'

class App extends Component {
    render() {
        return (
            <div>
                <Route path="/home" component={Home} />
                <Route path="/moving" component={Moving} />
                <Route path="/setup" component={Setup} />
                <Route path="/select_menu" component={SelectMenu} />
                <Route path="/serving_list" component={ServingList} />
            </div>
        )
    }
}

export default App