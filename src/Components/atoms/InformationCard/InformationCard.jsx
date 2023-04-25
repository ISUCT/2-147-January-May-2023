import React from "react";
import { ItemCard } from "../ItemCard";

import news from '../../../Public/Img/document.png'

export let InformationCard = () =>{
    return(
        <div>
            <ItemCard src={news} text='Правила' teme='12 Тем' like='7 Отвтетов'></ItemCard>
            <ItemCard src={news} text='Правила' teme='12 Тем' like='7 Отвтетов'></ItemCard>
            <ItemCard src={news} text='Правила' teme='12 Тем' like='7 Отвтетов'></ItemCard>
        </div>
    );
} 
