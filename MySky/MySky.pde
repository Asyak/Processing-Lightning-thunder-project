import controlP5.*; // importation des bibliothèques utilisés
import ddf.minim.*; 

/* Declaration des objets de la bibliothèque minim pour pouvoir utiliser les méthodes */
Minim minim; 
AudioPlayer play1;
AudioPlayer play2;
AudioPlayer play3;
AudioPlayer play4;
AudioPlayer play5;
AudioPlayer play6;

/* Fonction qui dessigne des ellipses qui colorent le ciel
Elle prend 4 parametres qui sont 3 couleurs RGB et la transparence 
Pour donner un aspect "naturel" à la coloration, la taille des ellipses 
et leur position au ciel a une certaine marge aléatoire(random)*/
void colorerCiel(int a, int b, int c, int d) {
  fill(a,b,c,d);
  noStroke();
  for(int i=0; i<700; i++) {
  float x=random(0,800);
  float y=random(0,230);
  float el = random(60, 100);
  ellipse(x,y,el,el);
  }
}

/*Foncion qui defini les couleurs qui composent la palette du ciel*/
void dessignerCiel(){
  this.colorerCiel(0,0,255,60); //bleu vif
  this.colorerCiel(65,105,225,30); // bleu claire
  this.colorerCiel(0,13,113,10); // bleu très foncé
  this.colorerCiel(153,204,255,35); // bleu vif très claire
  this.colorerCiel(9,0,151, 15); // bleu foncé
}

/* Ici definition de la fontion qui colore la route
D'abord on defini le nom de nos couleurs et puis  
chaque pixel de couleur "vert" entre deux lignes noires est modifié à couleur "terre". 
*/
color vert = color(0,165,155);
color terre= color(139,139,137);
color noir= color(0,0,0);

void floodfill(int x, int y) {
  color c = get(x,y);
  if (c==vert){
    set(x,y,terre);
    if(y>0)floodfill(x,y-1);
    if(y<283)floodfill(x,y+1);
    if(x>0) floodfill(x-1, y);
    if(x<800) floodfill(x+1,y);
  }
}

/* Declaration des variables de slider de la librairie ControlP5
La valeur de l'echelle est 100 */
ControlP5 cp5;
int sliderValue = 100;
int sliderTicks1 = 220;

/*herbes création des objets herbe (herbe est une classe, 
pour pouvoir "l'importer" il faut créer un objet herbe avce "new"
Le constructeur de l'herbe prend 4 parametres qui sont les coordonnées X et Y de la 
ligne de depart à partir delaquelle est construite l'herbe*/
herbe h1=new herbe(550, 550, 549, 555);
herbe h2=new herbe(730, 490, 729, 495);
herbe h3=new herbe(600,380, 599, 383);
herbe h4=new herbe(335, 430, 334, 434);


/* Fonction Setup dans la quelle nous mettons des variables et des fontions "fixes"*/
void setup() {
  size(800,600); // taille de la fenêtre
  smooth(); // alliasing

 /*creation de slider
On défini sa position, sa taille et l'échelle des marques */
  cp5 = new ControlP5(this);
  cp5.addSlider("CHARGE ELECTRIQUE DU CIEL")
     .setPosition(50,425)
     .setSize(20,120)
     .setRange(0,100)
     .setNumberOfTickMarks(6);
       
  /* Création de l'objet audio de la librairie mini qui nous 
  permettera écouter les fichiers mp3*/
  minim = new Minim(this);
}

/* La Fonction qui dessine et qui execute nos fonctions crées plus haut*/
void draw(){
  background(220); // la couleur de fond de la fenêtre
  
/*ici on dessine notre grand rectangle vert qui sympolise le champs d'herbes */
  fill(0,165,155); // le vert d'herbe
  noStroke(); // pas de contour
  smooth(); // alliasing
  rect (0,283, 800, 350); // taille de l'herbe
  
  fill(255,247,223); //la couleur blanche d'horizon
  rect(0,283, 800,3); // la taille de l'horizon

/* Deux coubes de bezier dessnent la route 
On defini d'abord les point de contrôle dans des tablaux d'entires */
  int []x = {650,500,120,70};
  int[]y = {286,320,600,800};

  int []v = {660,550,420,370};
  int[]w = {286,320,600,800};

  stroke(noir); // couleur de la ligne
  strokeWeight(0.5); // epaisseur de la ligne
  noFill(); // pas de remplissage du creux de la courbe
  bezier(x[0],y[0],x[1],y[1],x[2],y[2],x[3],y[3]); // les fonctions qui permet construire la ligne
  bezier(v[0],w[0],v[1],w[1],v[2],w[2],v[3],w[3]); // on leur passe nos points de contrôle depuis la table des points
  
  /*Ici on fait appel à la fonction pour dessigner les ciel. En debut du code elle etait juste crée,
  elle n'executait pas */
  dessignerCiel(); 
  
  /*Pour travailer avec slider on defini quand la souris est dans la zone du slider en termes de axe X */
  boolean xok= false;
  if((mouseX>=50)&&(mouseX<=70)){
    xok=true;
  }
  
  /* Ici on declanche la foudre et le coup de tonerre 
  Si la souris a été presse et si elle se trouve à un certain endroit 
  du slider (les coordonnées Y correspondent à des niveau de slider) 
  alors nous declenchons la foudre par création d'un objet foudre et par utilisation de fonction
  qui dessine la foudre. De cette manère il est possible declencher la foude
  autant de fois que l'on veut. On declenche plusieurs foudres en fonctiond 
  de la charge electrique du ciel */
  if((mousePressed==true)&&(mouseY>=425)&&(mouseY<445)&&(xok==true)) {
      foudre f1 = new foudre();
      foudre f2 = new foudre();
      foudre f3 = new foudre();
      foudre f4 = new foudre();
      foudre f5 = new foudre();
      foudre f6 = new foudre();
      
      f1.dessinerFoudre(3);
      f2.dessinerFoudre(3);
      f3.dessinerFoudre(2);
      f4.dessinerFoudre(3);
      f5.dessinerFoudre(1);
      f6.dessinerFoudre(1);
      
      this.colorerCiel(255,255,255,20); // On crée un effect lumineux qui provoque la foudre
      
 /* Ici on ouvre le fichier sonore à l'aide des fonctions de la bibliothèque minim
 et on le lit*/
      play1= minim.loadFile("3082.mp3");
      if(play1.isPlaying()==false) {        
        play1.play(); // fort
      }
            
  } else if ((mousePressed==true)&&(mouseY>=445)&&(mouseY<465)&&(xok==true)) {
      foudre f7 = new foudre();
      foudre f8 = new foudre();
      foudre f9 = new foudre();
      foudre f18 = new foudre();
      
      f7.dessinerFoudre(3);
      f8.dessinerFoudre(2);
      f9.dessinerFoudre(2);
      f18.dessinerFoudre(1);
      
      this.colorerCiel(255,255,255,20);
      

      play2= minim.loadFile("3083.mp3"); 
      if(play2.isPlaying()==false) {
        play2.play(); // fort
      }
      
  } else if ((mousePressed==true)&&(mouseY>=465)&&(mouseY<485)&&(xok==true)) {
      foudre f10 = new foudre();
      foudre f11 = new foudre();
      foudre f17 = new foudre();
   
      f10.dessinerFoudre(3);
      f11.dessinerFoudre(1);
      f17.dessinerFoudre(1);
      
       this.colorerCiel(255,255,255,20);
       
      play3= minim.loadFile("3084.mp3");
      if(play3.isPlaying()==false) {
        play3.play(); // moyen
      }
      
  } else if ((mousePressed==true)&&(mouseY>=485)&&(mouseY<505)&&(xok==true)) {
      foudre f12 = new foudre();
      foudre f16 = new foudre();
      
      f12.dessinerFoudre(2);
      f16.dessinerFoudre(1);
      
      this.colorerCiel(255,255,255,20);
      
      play4= minim.loadFile("3085.mp3"); 
      if(play4.isPlaying()==false) {
        play4.play(); // moyen
      }
   
      
  } else if ((mousePressed==true)&&(mouseY>=405)&&(mouseY<525)&&(xok==true)) {
      foudre f13 = new foudre();
      foudre f14 = new foudre();
      
      f13.dessinerFoudre(1);
      f14.dessinerFoudre(1);
      
       this.colorerCiel(255,255,255,20);

      play5= minim.loadFile("3086.mp3");
      if(play5.isPlaying()==false) {
        play5.play(); // leger
      }
      
  } else if ((mousePressed==true)&&(mouseY>=525)&&(mouseY<=545)&&(xok==true)) {
      foudre f15 = new foudre();
      f15.dessinerFoudre(1);
      this.colorerCiel(255,255,255,20);
      
      play6= minim.loadFile("3087.mp3"); 
      if(play6.isPlaying()==false) {
        play6.play();
      }
  }
  
/* Text explicatif du phenomène */
  textSize(11); // taille du text
  fill(255); // couleur du text
  String s = "La foudre est un phénomène de décharge électrostatique qui se produit lorsque l'électricité statique s'accumule entre des nuages d'orage, ou entre un tel nuage et la terre. \n Augmentez la charge électrique du ciel à l'aide du curseur pour déclencher une foudre. ";
  text(s, 40, 310, 350, 100 ); // text dans une boite de text et la taille de la boite

/* On fait appel à la fonction crée en debut du code pour colorer la route */
  floodfill(380,599);
  
/* On appel la fonction qui dessine l'herbe sur objet herbe crée plus haut */
 h1.dessinerHerbe();
 h2.dessinerHerbe();
 h3.dessinerHerbe();
 h4.dessinerHerbe();

} // fin draw

// arrêt de fichier audio et quit minim
void stop() {
  play1.close();
  play2.close();
  play3.close();
  play4.close();
  play5.close();
  play6.close();
  minim.stop();
  super.stop();
}