import React from "react";
import disign from "./ImportantNews.module.css"

export default function ImportantNews(props) {
    return (
        <div className={disign.ImportantNews}>
            <p>{props.ImportantNews}</p>
        </div>
    )
}
