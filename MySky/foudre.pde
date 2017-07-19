class foudre { 
/* Etant donnée que nous déclenchos la foudre plusieurs fois et à plusieurs endroit il 
est plus facile de la distanguer dans une class apart que de repeter le code plusieurs fois. */

  float currX, currY, nextX, nextY; // Déclaration des variables 
  float  end=random(350,600); // variable fin de foudre qui varie en taille
  
 /*Constructeur*/
  foudre() {
    currX = random(150,650);
    currY=random(80,250);
  }

/*Fonction qiu dessine la foudre par succession de lignes
avec une inclinaison aleatoires dans certaine mésure et tant que la fin de la foudre n'est pas atteinte*/
  void dessinerFoudre(int sw){
    stroke(255);
    strokeWeight(sw);
    
    while (currY<end) {
      nextX=currX+random(-13,+13);
      nextY=currY+random(0,+13);
      line(currX,currY,nextX,nextY);
      currX=nextX;
      currY=nextY;
    }
  }
   
}