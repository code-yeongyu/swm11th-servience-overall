import React, {useState} from 'react';
import { Input, Button, Form, FormGroup, Label } from 'reactstrap'
import './Setup.css'

const Setup = () => {
    const [id, setID] = useState("")
    const handleChange = ({ target: { value } }) => setID(value)
    const handleSubmit = (event) => {
        event.preventDefault()
        localStorage.setItem("robotID", id)
        window.location.href = "/home"
    }

    return (
        <div className="setup">
            <Form autocomplete="off" onSubmit={handleSubmit}>
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