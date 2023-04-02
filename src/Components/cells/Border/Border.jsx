import React from "react";
import cssBorder from './Border.module.css';

import LastTeme from '../../atoms/LastTeme/LastTeme'
import TemeNews from '../../atoms/TemeNews/TemeNews'

export const Border = () => {
    return (
        <div className={cssBorder.border}>
            <div className={cssBorder.InsaidBorder}>
                <LastTeme />
                <TemeNews />
            </div>
        </div>
    )
}
