import React from "react";
import disign from "./Teme.module.css"

export default function Teme(props) {
    return (
        <div className={disign.Teme}>
            <h1>{props.head}</h1>
        </div>
    )
}
