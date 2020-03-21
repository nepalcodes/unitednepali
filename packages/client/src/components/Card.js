import React from "react";
import styles from "./DefaultPage.module.css";

export function Card({ title, description, link }) {
  return (
    <div
      className={styles.card}>
      <h1>{title}</h1>
      {description}
      <a href={link}>link</a>
    </div>
  );
}
