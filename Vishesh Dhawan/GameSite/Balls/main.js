// setup canvas

var cvs = document.querySelector('canvas');
var ctx = cvs.getContext('2d');

var width = cvs.width = window.innerWidth;
var height = cvs.height = window.innerHeight;
var str = document.getElementById('p');
var ballNum = 30;

// generate random number

function random(min, max) {
    var num = Math.floor(Math.random() * (max - min + 1)) + min;
    return num;
}


//defining shape
class Shape {
    constructor(x, y, velX, velY, exists) {
        this.x = x;
        this.y = y;
        this.velX = velX;
        this.velY = velY;
        this.exists = exists;
    }
}



//defining Ball
class Ball extends Shape {
    constructor(x, y, velX, velY, exists, color, size) {
        super(x, y, velX, velY, exists);

        this.color = color;
        this.size = size;
    }
    

    draw() {
        ctx.beginPath();
        ctx.fillStyle = this.color;
        ctx.arc(this.x, this.y, this.size, 0, 2 * Math.PI);
        ctx.fill();
    }
    

    update() {
        if ((this.x + this.size) >= width) {
            this.velX = -(this.velX);
        }

        if ((this.x - this.size) <= 0) {
            this.velX = -(this.velX);
        }

        if ((this.y + this.size) >= height) {
            this.velY = -(this.velY);
        }

        if ((this.y - this.size) <= 0) {
            this.velY = -(this.velY);
        }

        this.x += this.velX;
        this.y += this.velY;
    }
    

    collisionDetect() {
        for (var j = 0; j < balls.length; j++) {
            if (!(this === balls[j])) {
                var dx = this.x - balls[j].x;
                var dy = this.y - balls[j].y;
                var distance = Math.sqrt(dx * dx + dy * dy);

                if (distance < this.size + balls[j].size) {
                    balls[j].color = this.color = 'rgb(' + random(0, 255) + ',' + random(0, 255) + ',' + random(0, 255) + ')';
                }
            }
        }
    }
    
}



//filling balls

var balls = [];

while (balls.length < ballNum) {
    var size = random(10, 20);
    var ball = new Ball(
        random(0 + size, width - size),
        random(0 + size, height - size),
        random(-7, 7),
        random(-7, 7),
        true,
        'rgb(' + random(0, 255) + ',' + random(0, 255) + ',' + random(0, 255) + ')',
        size
    );

    balls.push(ball);
}





//creating EvilCircle

class EvilCircle extends Shape {
    constructor(x, y, velX, velY, exists) {
        super(x, y, 20, 20, exists);

        this.color = 'white';
        this.size = 10;
    }

    
    draw() {
        ctx.beginPath();
        ctx.lineWidth = 3;
        ctx.strokeStyle = this.color;
        ctx.arc(this.x, this.y, this.size, 0, 2 * Math.PI);
        ctx.stroke();
    }

    
    checkBounds() {
        if ((this.x + this.size) >= width) {
            this.x -= this.size;
        }

        if ((this.x - this.size) <= 0) {
            this.x += this.size;
        }

        if ((this.y + this.size) >= height) {
            this.y -= this.size;
        }

        if ((this.y - this.size) <= 0) {
            this.y += this.size;
        }
    }

    
    setControls() {
        var _this = this;
        window.onkeydown = function (e) {
            if (e.keyCode === 37) {
                _this.x -= _this.velX;
            } else if (e.keyCode === 39) {
                _this.x += _this.velX;
            } else if (e.keyCode === 38) {
                _this.y -= _this.velY;
            } else if (e.keyCode === 40) {
                _this.y += _this.velY;
            }
        }
    }

    
    collisionDetect() {
        for (var j = 0; j < balls.length; j++) {
            if (balls[j].exists) {
                var dx = this.x - balls[j].x;
                var dy = this.y - balls[j].y;
                var distance = Math.sqrt(dx * dx + dy * dy);

                if (distance < this.size + balls[j].size) {
                    balls[j].exists = false;
                    ballNum -= 1;
                    str.textContent = 'Ball Count: ' + ballNum.toString();
                }
            }
        }
    }
    
}


//creating EvilCircle Object

var circ = new EvilCircle(20, 50, 20, 20, true);
circ.setControls();



//starting Game

function loop() {
    ctx.fillStyle = 'rgba(0,0,0, 0.3)';
    ctx.fillRect(0, 0, width, height);

    for (var i = 0; i < balls.length; i++) {
        if (balls[i].exists) {
            balls[i].draw();
            balls[i].update();
            balls[i].collisionDetect();
            circ.draw();
            circ.checkBounds();
            circ.collisionDetect();
        } else {
            circ.draw();
        }
    }
    requestAnimationFrame(loop);
}

loop();