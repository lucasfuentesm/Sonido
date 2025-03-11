import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int x = 0;
int y = 50;

float rad;
float level;

void setup() {
  size(800, 800);
  background(0);
  frameRate(800);
  drawStars(300); // Número de estrellas

  minim = new Minim(this);
  player = minim.loadFile("Interstellar.mp3", 1024);
  player.play();

  fft = new FFT(player.bufferSize(), player.sampleRate());
}

// Fondo estrellas, para una vibra del espacio exterior
void drawStars(int numStars) {
  for (int i = 0; i < numStars; i++) {
    float x = random(width);
    float y = random(height);
    float size = random(1, 4);
    fill(255);
    noStroke();
    ellipse(x, y, size, size);
  }
}

void draw() {
  fft.forward(player.mix);
  // Retornando la amplitud de la 10ma frecuencia
  level = fft.getBand(10);
  rad = (level * width / 20);

  float r = random(200, 255); // Rojo alto
  float g = random(50, 150); // Tono naranja/rojo)
  float b = random(0, 50);   //Azul bajo

  stroke(r, g, b);
  fill(255, 10);
  ellipse(x, y, rad, rad);
  x++;

  if (x > width) {
    x = 0;
    y += 80;
  }

  if (y > height) {
    y = 0;
    background(0);
  }
}
