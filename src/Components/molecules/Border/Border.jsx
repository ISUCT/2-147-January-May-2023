import React from "react";
import cssBorder from './Border.module.css';
import LastTeme from "../../atoms/BorderAtoms/LastTeme/LastTeme";
import TemeNews from "../../atoms/BorderAtoms/TemeNews/TemeNews";


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