import React from "react";
import ImportantNews from "./ImportantNews/ImportantNews";
import Teme from "./Temes/Teme";
import disign from "./TemeConsturcrot.module.css"

export const TemeConsturcrot = (props) => {
    return (
        <div className={disign.MainTeme}>
            <Teme head = {props.teme} />
            <ImportantNews ImportantNews = {props.news}/>
        </div>
    )
}