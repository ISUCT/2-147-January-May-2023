import React from "react";
import student from "../../../Public/Img/Student.png"
import styles from './Header.module.scss'
import { HeaderBar } from "../../atoms/HeaderBar";
import { HeaderFooter } from "../../atoms/HeaderFooter/HeaderFooter";

export let Header = (props) =>{
    return(
        <div className={styles.Header}>
            <HeaderBar />
            <HeaderFooter />
            <img src={student} />
        </div>
    );
} 
