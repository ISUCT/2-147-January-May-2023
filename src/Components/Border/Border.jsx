import React from "react";
import cssBorder from './Border.module.css';
import LastTeme from "./LastTeme/LastTeme";
import TemeNews from "./TemeNews/TemeNews"


const Border = () => {
    return (
        <div className={cssBorder.border}>
            <div className={cssBorder.InsaidBorder}>
                <LastTeme />
                <TemeNews />
            </div>
        </div>
    )
}

export default Border;