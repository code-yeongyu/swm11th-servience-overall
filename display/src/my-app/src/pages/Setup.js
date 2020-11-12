import React, { useState } from 'react'
import { Redirect, useHistory } from 'react-router-dom'
import { Input, Button, Form, FormGroup, Label } from 'reactstrap'
import './Setup.css'

const Setup = () => {
    const [id, setID] = useState("")
    const history = useHistory()
    const handleChange = ({ target: { value } }) => setID(value)
    const handleSubmit = (event) => {
        event.preventDefault()
        localStorage.setItem("robotID", id)
        history.push("/setup")
    }

    const isSetted = !!localStorage.getItem("robotID")
    if (isSetted) {
        return (
            <Redirect to="/" />
        )
    }

    return (
        <div className="setup">
            <Form autoComplete="off" onSubmit={handleSubmit}>
                <FormGroup>
                    <Label for="robotID" size="lg">로봇 본체에 붙어있는 id를 입력해주세요.</Label>
                    <Input id="robotID" onChange={handleChange} placeholder="Robot ID" size="lg" type/>
                </FormGroup>
                <Button type="submit" color="primary" size="lg">등록</Button>
            </Form>
        </div>
    )
}

export default Setup