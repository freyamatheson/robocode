package freyamatheson;

import robocode.ScannedRobotEvent;
import robocode.Robot;

import robocode.HitByBulletEvent;
import robocode.HitRobotEvent;
import robocode.HitWallEvent;


public class freyamatheson extends Robot {
    //main robot strategy: keep moving forward and detecting enemies
    //fire hard directly at them then move backwards
    //robot avoids ramming, focuses on firing at enemy and recovering while
    //health is high
    //retreats in event of a ramming attack IF health is high,
    //stays in center; avoids being backed into 
    //a wall
    //rams when health is low
    
    final double lowHealth = 40;

    public void run(){
        setBodyColor(java.awt.Color.pink);
        setGunColor(java.awt.Color.pink);
        setRadarColor(java.awt.Color.pink);
        setScanColor(java.awt.Color.pink);
        setBulletColor(java.awt.Color.pink);

        while(true) {
            if (getEnergy() < lowHealth){
                ram();
            }
            else{
            // move forward
            ahead(100);
    
            // Turn radar to scan for enemies
            turnRadarRight(360);
            }
        }

}

public void onScannedRobot(ScannedRobotEvent e) {

    if(getEnergy()>lowHealth){
    // when an enemy is scanned turn the gun to aim at the enemy
    turnGunRight(getHeading() - getGunHeading() + e.getBearing());

    // fire at the enemy with high power
    fire(15);
    }
    else{
        ram();
    }


}



public void onHitByBullet(HitByBulletEvent e){
//run away, retreat from enemy and change direction

turnLeft(45);
back(100);
}

public void onHitRobot(HitRobotEvent e){
    
    if(getEnergy()>lowHealth){
    turnRight(90);
    back(200);

    //fire extra hard afterwards
    turnGunRight(getHeading() - getGunHeading() + e.getBearing());
    fire(12);
    }
    else{
        ram();
    }

}

public void onHitWall(HitWallEvent e){
    //get away from wall!! don't get backed into a corner
    back(200);
    turnRight(90);

}
public void ram() {
    // turn gun and radar towards the enemy
    turnGunRight(getHeading() - getGunHeading());
    turnRadarRight(360);

    // charge towards the enemy
    ahead(100);

    //fire at low power
    fire(1);

}

}
