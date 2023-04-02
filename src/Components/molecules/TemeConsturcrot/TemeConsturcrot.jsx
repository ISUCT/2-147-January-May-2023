import React from "react";
import disign from "./TemeConsturcrot.module.css";
import {Teme, ImportantNews} from "../../atoms/index";



export const TemeConsturcrot = (props) => {
    return (
        <div className={disign.MainTeme}>
            <Teme head = {props.teme} />
            <ImportantNews ImportantNews = {props.news}/>
        </div>
    )
}
