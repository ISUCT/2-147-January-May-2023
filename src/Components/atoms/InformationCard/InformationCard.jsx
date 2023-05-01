import React from "react";
import { ItemCard } from "../ItemCard";

import document from '../../../Public/Img/document.png';
import megaphone from '../../../Public/Img/megaphone 1.png';
import chat from '../../../Public/Img/chat.png';

let Atrebute = {
    src: string,
    text: string,
    teme: string,
    like: string
  }
  
let CardProps = {
    arrs: Atrebute[]
}

export let InformationCard = ({CardProps}) =>{
    return(
        <div>
            <ItemCard src={arrs.src} text='Правила' teme='12 Тем' like='7 Отвтетов'></ItemCard>
            <ItemCard src={megaphone} text='Новости' teme='12 Тем' like='7 Отвтетов'></ItemCard>
            <ItemCard src={chat} text='Общение с разработчиком' teme='12 Тем' like='7 Отвтетов'></ItemCard>
        </div>
    );
} 
