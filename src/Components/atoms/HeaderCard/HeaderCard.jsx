import React from "react";
import style from "./HeaderCard.module.scss"
import { InformationCard } from "../InformationCard";

export let HeaderCard = (props) =>{
    return(
        <div className={style.CardHeader}>
            <div className={style.lable}>
                <sapn>Важные темы</sapn>          
            </div>
            <div className={style.line}/>
            <div className={style.info}>
                <InformationCard />
            </div>
        </div>
    );
} 
