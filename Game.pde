class NewGame{
  float life = 20;
  float energy = 0;
  PVector[] enemy_position = new PVector[5];
  PVector[] direction = new PVector[5];
  int flag = 0;
  int stage = 0;
  int count;
  float time = 0;
  float lasting = 0;
  int max = 3;
  int level = 1;

  void enemy_coordinate() {
    for (int i = 0; i < 5; i++ )
    {  
      enemy_position[i] = new PVector(random(0, 600), 20);
      direction[i] = new PVector(0, 2);
    }
  }

  void stage0() {
    if (stage == 0) {
      start_text();
    }
  }

  void stage1() {
    if (stage == 1) {
      if (lasting == 1) {
        stage = 5;
      }
      level();
      upper_right_text();
      if (life <= 0) stage = 2;

      for (int i = 0; i < 5; i++) {
        if (direction[i].y < max)
          direction[i].y *= 1.001;
      }
      upper_left_energy_life_rect(0.6);
      player_ball();
      player_harm_judge();
      {
        enemy_ball();
        enemy_harm_judge();
      }
    }
  }

  void stage2() {
    if (stage == 2) {
      failure_text();
    }
  }

  void stage3() {
    if (stage == 3) {
      upper_right_text();
      upper_left_energy_life_rect(0.0);
      rule_text();
    }
  }




  //text
  void start_text() {
    fill(227, 227, 227);
    textAlign(CENTER);
    textSize(44);
    fill(255, 0, 0);
    text("START", 0.5 * width, 0.5 *  height);
  }

  void upper_right_text() {
    background(0);
    textAlign(CENTER);
    text("KILLED: "+count, 450, 50);
    text("TIME: "+time, 450, 20);
    text("LEVEL: "+level, 450, 80);
    textSize(20);
    rect(10, 50, 60, 20);
    fill(238, 44, 44);
  }

  void failure_text() {
    background(0);
    fill(227,227,227);
    textAlign(CENTER);
    textSize(24);
    fill(238,106,167);
    text("SORRY  FAILED", 0.5 * width, 0.3 *  height);
    text("SURVIVED "+time+" seconds", 0.5 * width, 0.5 *  height);
    text("KILLED "+count+" enemy", 0.5 * width, 0.7 *  height);
    fill(227,227,227);
  }

  void rule_text() {
    fill(153,50,204);
    fill(248,248,255);
    fill(227,227,227);
    ellipse(mouseX, 580, 30, 30);
    textAlign(CENTER);
    textSize(14);
    fill(238,106,167);
    stroke(238,106,167);
    text("THIS IS YOU THE AMOUNT OF BULLET", 250, 30);
    text("THIS IS YOU THE AMOUNT OF POWER", 250, 70);
    line(120, 20, 60, 30);
    line(120, 60, 60, 70);
    textSize(22);

    text("RULE", 300, 150);
    textAlign(LEFT);
    text("1. you can use your mouse to control the plane", 10, 190);
    text("2. you can press the mouse to fire ", 10, 230);
    text("3, if you come across the enemy , you are harmed", 10, 270);
    text("4. if your power is less than 0 , you falied", 10, 310);
    text("5. while playing , you can press s to stop", 10, 350);
    textAlign(CENTER);
    text("PLAY NOW CLICKHERE", 300, 450);
    stroke(238,106,167);
    fill(227,227,227);
  }





  //display()
  void upper_left_energy_life_rect(float resume) {
    if (energy < 200 && flag == 0)
      energy += resume;
    if (life >= 0)
    rect(10, 50, 30 * 0.1 * life, 20);
    fill(227, 227, 227);
    rect(10, 20, 60, 20);

    if (energy >= 150) {
      fill(238, 44, 44);
      rect(10, 20, 30 * 0.01 * energy, 20);
    }
    if (energy >= 100 &&energy < 150 )
    {
      fill(255, 215, 0);
      rect(10, 20, 30 * 0.01 * energy, 20);
    } else {
      if (energy < 100) {
        fill(209, 238, 238);
        rect(10, 20, 30 * 0.01 * energy, 20);
      }
    }
    fill(153, 50, 204);
    fill(248, 248, 255);
  }

  void player_ball() {
    fill(227, 227, 227);
    ellipse(mouseX, 580, 30, 30);
  }

  void enemy_ball() {
    fill(248,248,255);
    for (int i = 0; i < 5; i++)
      ellipse(enemy_position[i].x, enemy_position[i].y, 10, 10);
    fill(248,248,255);
    for (int i = 0; i < 5; i++)
      enemy_position[i].y += direction[i].y;
    for (int i = 0; i < 5; i++)
    {
      if (enemy_position[i].y >= 580 )
      {
        enemy_position[i].y = 10;
        enemy_position[i].x = random(100, 500);
      }
    }
  }





  //judge()
  void level() {
    if (count <= 15) {
      max = 3; 
      level = 1;
    }
    if (count <= 30  && count > 15) { 
      max = 5; 
      level = 2;
    }
    if (count <= 45  && count > 30 ) {
      max = 7; 
      level = 3;
    }
    if (count  > 45  ) {
      max = 15 + (int)time * 10; 
      level = 4;
    }
    time += 0.01;
  }

  void player_harm_judge() {
    for (int i = 0; i < 5; i++) {
      float dis = sqrt((mouseX - enemy_position[i].x)*(mouseX - enemy_position[i].x)+(580 - enemy_position[i].y)*(580 - enemy_position[i].y));
      if (dis <= 30) {
        life-= 2;
        ellipse(mouseX, 580, 70, 70);
        enemy_position[i].y = 10;
        enemy_position[i].x = random(100, 500);
      }
    }
  }

  void enemy_harm_judge() {
    if (mousePressed)
    {   
      if (energy > 0) {
        flag = 1;
        stroke(248,248,255);
        line(mouseX, 580, mouseX, 0);

        for (int i = 0; i < 5; i++)
        {
          if (enemy_position[i].x - mouseX <= 10 && enemy_position[i].x - mouseX >= -10)
          {
            ellipse(enemy_position[i].x, enemy_position[i].y, 30, 30 );
            count++;
            enemy_position[i].y = 10;
            enemy_position[i].x = random(0, 600);
          }
        }
        energy -= 2.5;
        if (energy <= 0) flag = 0;
      }
    }
  }

  void stage_change(int a, int b) {
    if (stage == 3) {
      if (a >= 200 && a <= 500 && b >= 400 && b <= 500)
        stage = 1 ;
    }
    if (stage == 0 ) {
      if (a >= 200 && a <= 400 && b >= 200 && b <= 400)
        stage = 3 ;
    }
  }

  void timeout() {
    if (key == 's') {
      lasting = 1 - lasting;
      if (lasting == 0)
        stage = 1;
    }
  }
}


NewGame player;

void setup() {
  size(600, 600);
  background(0);
  player = new NewGame();
  player.enemy_coordinate();
}

void draw() {
  player.stage0();
  player.stage1();
  player.stage2();
  player.stage3();
}

void mousePressed() {
  player.stage_change(mouseX, mouseY);
}

void keyPressed() {
  player.timeout();
}
