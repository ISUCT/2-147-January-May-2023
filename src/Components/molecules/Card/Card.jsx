import React from "react";
import { HeaderCard } from "../../atoms/HeaderCard";
import styles from './Card.module.scss'
import { InformationCard } from "../../atoms/InformationCard";

export let Card = () =>{
    return(
        <div className={styles.Card}>
            <HeaderCard></HeaderCard>
        </div>
    );
} 
