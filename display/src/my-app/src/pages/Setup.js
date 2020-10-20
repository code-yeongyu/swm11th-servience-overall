import React from 'react'
import {Input, Button, Form, FormGroup, Label} from 'reactstrap'
import './Setup.css'

const Setup = () => {
    return (
        <div className="setup">
            <Form>
                <FormGroup>
                    <Label for="robotID" size="lg">로봇 본체에 붙어있는 id를 입력해주세요.</Label>
                    <Input id="robotID" placeholder="Robot ID" size="lg"/>
                </FormGroup>
                <Button color="primary" size="lg">등록</Button>
            </Form>
        </div>
    )
}

export default Setup