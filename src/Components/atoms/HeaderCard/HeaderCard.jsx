import React from "react";
import style from "./HeaderCard.module.scss"
import { InformationCard } from "../InformationCard";
import { string } from "prop-types";

import document from '../../../Public/Img/document.png';
import megaphone from '../../../Public/Img/megaphone 1.png';
import chat from '../../../Public/Img/chat.png';

let Atrebute = {
    src: string,
    text: string,
    teme: string,
    like: string
  }

const Arrs: Atrebute[] = [
    { src: {document}, text: 'Правила', teme: '12 Тем', like: '7 Отвтетов' },
    { src: {megaphone}, text: 'Новости', teme: '12 Тем', like: '7 Отвтетов' },
    { src: {chat}, text: 'Общение с разработчиком', teme: '12 Тем', like: '7 Отвтетов' },
]

export let HeaderCard = (props) =>{
    return(
        <div className={style.CardHeader}>
            <div className={style.lable}>
                <sapn>Обсуждения</sapn>          
            </div>
            <div className={style.line}/>
            <div className={style.info}>
                <InformationCard Arrs={Arrs} />
            </div>
        </div>
    );
} 
