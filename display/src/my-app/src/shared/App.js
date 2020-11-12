import React, { Component } from 'react'
import { Route } from 'react-router-dom'
import { Home, Moving, Setup, SelectMenu, SelectOrder, ServingList, Cup } from 'pages'

class App extends Component {
    render() {
        return (
            <div>
                <Route exact path="/" component={Home} />
                <Route path="/moving" component={Moving} />
                <Route path="/setup" component={Setup} />
                <Route path="/select_order/:cup_position" component={SelectOrder} />
                <Route path="/select_menu/:cup_position/:index" component={SelectMenu} />
                <Route path="/serving_list" component={ServingList} />
                <Route path="/cup/:cup_position" component={Cup} />
            </div>
        )
    }
}

export default App