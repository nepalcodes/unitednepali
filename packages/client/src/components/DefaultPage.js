import React from "react";
import { Parallax, ParallaxLayer } from "react-spring/renderprops-addons";
import styles from "./DefaultPage.module.css";
import { Card } from "./Card";
import { useOrganizations } from "../hooks/useOrganizations";

const url = (name, wrap = false) =>
  `${
  wrap ? "url(" : ""
  }https://awv3node-homepage.surge.sh/build/assets/${name}.svg${
  wrap ? ")" : ""
  }`;

const Background = () => {
  return (
    <>
      <ParallaxLayer
        offset={1}
        speed={1}
        style={{ backgroundColor: "#ff5757AA" }}
      />
      <ParallaxLayer
        offset={2}
        speed={1}
        style={{ backgroundColor: "#87BCDE" }}
      />

      <ParallaxLayer
        offset={0}
        speed={0}
        factor={3}
        style={{
          backgroundImage: url("stars", true),
          backgroundSize: "cover"
        }}
      />

      <ParallaxLayer
        offset={1.3}
        speed={-0.3}
        style={{ pointerEvents: "none" }}
      >
        <img
          src={url("satellite4")}
          style={{ width: "15%", marginLeft: "70%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1} speed={0.8} style={{ opacity: 0.1 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "55%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "15%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1.75} speed={0.5} style={{ opacity: 0.1 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "70%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "40%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1} speed={0.2} style={{ opacity: 0.2 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "10%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "75%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={1.6} speed={-0.1} style={{ opacity: 0.4 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "60%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "25%", marginLeft: "30%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "10%", marginLeft: "80%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer offset={2.6} speed={0.4} style={{ opacity: 0.6 }}>
        <img
          src={url("cloud")}
          style={{ display: "block", width: "20%", marginLeft: "5%" }}
          alt=""
        />
        <img
          src={url("cloud")}
          style={{ display: "block", width: "15%", marginLeft: "75%" }}
          alt=""
        />
      </ParallaxLayer>

      <ParallaxLayer
        offset={2.5}
        speed={-0.4}
        style={{
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          pointerEvents: "none"
        }}
      >
        <img src={url("earth")} style={{ width: "60%" }} alt="" />
      </ParallaxLayer>
    </>
  );
};

export function DefaultPage() {
  const organizations = useOrganizations();

  return (
    <div className={styles.container}>
      <Parallax
        pages={3}
        scrolling={true}
        vertical
      >
        <Background />

        <ParallaxLayer offset={0} speed={0.5} className={styles.titleSection}>
          <div className={styles.logo}> </div>
          <h1> UNITED NEPALI</h1>
          <h2> सयौं थुँगा फूलका हामी, एउटै माला नेपाली </h2>
        </ParallaxLayer>

        <ParallaxLayer offset={1.1} speed={0.5}>
          <div className={styles.organizationSection}>
            {organizations.map(organization => (
              <Card
                key={organization.id}
                title={organization.name}
                description={organization.description}
                link={organization.id}
              />
            ))}
          </div>
        </ParallaxLayer>

        <ParallaxLayer offset={2.25} speed={0.5} className={styles.joinSection}>
          <div className={`${styles.button} ${styles.startButton}`}>
            Get Started!
          </div>
          <div className={`${styles.button} ${styles.joinButton}`}>
            Add your organization
          </div>
        </ParallaxLayer>


      </Parallax>
    </div>
  );
}
