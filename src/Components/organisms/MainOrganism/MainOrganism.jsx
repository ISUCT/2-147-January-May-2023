import React from "react";
import FlexContainer from "../../common/FlexContainer/FlexContainer";
import { Card } from "../../molecules/Card";
import { DialogCard } from "../../molecules/DialogCard";

import styles from "./MainOrganism.module.scss"

export let MainOrganism = () => {
    return(
        <div className={styles.Organism}>
        <Card />
        <DialogCard />
    </div>
    )
} 
