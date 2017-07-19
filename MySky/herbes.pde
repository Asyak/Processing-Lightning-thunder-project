class herbe {
/*Idem, pour éviter des répetions, j'ai preferé de créer l'herbe dans une class à part.*/ 

/*Declaration des variables utilisés qui sont poin de depart des lignes d'herbe*/ 
  int x, y, v, w;
  
/*Constructeur prend en parametres le positionnement de premier bin d'herbe */
  herbe(int a, int b, int c, int d){
    x=a; y=b; v=c; w=d;
  }

/*Fontion qui dessine plusieurs herbes en fonction du premier brin */
  void dessinerHerbe() {
    stroke(0,100,100);
    strokeWeight(2);
    smooth();
    line(x+5,y,v+5,w);
    line(x+10,y,v+10,w);
    line(x+15,y,v+15,w);
    line(x+23,y,v+20,w);
    line(x-8,y,v-5,w);
  }
  
}