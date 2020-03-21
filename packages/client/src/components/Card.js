import React from "react";
import styles from "./Card.module.css";

export function Card({ title, description, link }) {
  return (
    <div
      className={styles.container}>
      <h1>{title}</h1>
      {description}
      <a href={link}>link</a>
    </div>
  );
}
