import React from "react";
import cssForum from './Forum.module.css';
import { TemeConsturcrot } from "../../molecules/TemeConsturcrot/TemeConsturcrot";


export const Forum = () => {
    return (
        <div className={cssForum.Forum}>
            <div className={cssForum.informations}>
            <TemeConsturcrot teme = "Важные темы" news = "News"/>
            <TemeConsturcrot teme = "News" news = "News2"/>
            </div>
        </div>
    )
}
