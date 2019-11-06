var cvs = document.querySelector(".canvas");
var ctx = cvs.getContext("2d");

//game status
//var status = true;

var snakedia = 30;
var snakerad = snakedia/2;

var score = 0;
document.querySelector('.score-count').textContent = score;

var chW = document.querySelector('.canvas-holder').offsetWidth;
var chH = document.querySelector('.canvas-holder').offsetHeight;

cvs.width = chW - (chW % snakedia);
cvs.height = chH - (chH % snakedia);

var dir = "down";

//centering canvas
padpx = Math.floor((chW % snakedia) - 1);
var canv = document.querySelector('.canvas-holder');
canv.style.paddingLeft = padpx.toString() + "px";

function renderSnake(x, y) {
    ctx.beginPath();
    ctx.fillStyle = "green";
    ctx.arc((2*x - 1) * snakerad, y * snakedia + snakerad, snakerad, 0, 2 * Math.PI);
    ctx.fill();
}


//initial snake
var len = 4;
var snake = [];

for (var i = len; i > 0; --i) {
    snake.push({x: i, y: 0});
}


//direction control
document.addEventListener('keydown', direction);

function direction(e) {
    if (e.keyCode == 37 && dir != 'right')
        dir = "left";

    if (e.keyCode == 38 && dir != 'down')
        dir = "up";

    if (e.keyCode == 39 && dir != 'left')
        dir = "right";

    if (e.keyCode == 40 && dir != 'up')
        dir = "down";
}


var food = {
    x: Math.round(Math.random() * ((cvs.width / snakedia) - 2) + 1),
    y: Math.round(Math.random() * ((cvs.height / snakedia) - 2) + 1)
}


function renderFood(x, y) {
    ctx.beginPath();
    ctx.fillStyle = "red";
    ctx.arc((2*x-1)*snakerad, y * snakedia + snakerad, snakerad, 0, 2 * Math.PI);
    ctx.fill();
}


//start game ?
var ans, difficulty, snakespeed;
ans = prompt('Start Game? \n Y\\N');
if(ans === 'Y' || ans === 'y' ) {
    difficulty = prompt('Enter difficulty \n Easy: 1 \n Medium: 2 \n Hard: 3');
    
    if(difficulty == '1')
        snakespeed = 700;
    else if(difficulty == '2')
        snakespeed = 200;
    else if(difficulty == '3')
        snakespeed = 100;
    else
        snakespeed = 1000000;
    
    
    startGame();
} else {
    alert('Maybe next Time ;)');
}

//render method
function render() {

    ctx.clearRect(0, 0, cvs.width, cvs.height);

    for (var i = 0; i < snake.length; i++) {
        renderSnake(snake[i].x, snake[i].y);
    }

    renderFood(this.food.x, this.food.y);


    var snakeX = snake[0].x;
    var snakeY = snake[0].y;

    if (snakeX-1 < 0 || snakeY < 0 || snakeX-1 >= cvs.width / snakedia || snakeY >= cvs.height / snakedia) {
//        this.status = !this.status;
//        console.log(status);
        alert('game Over');
    }

    if (dir == "right") {
        snakeX++;
    } else if (dir == "left") {
        snakeX--;
    } else if (dir == "up") {
        snakeY--;
    } else {
        snakeY++;
    }
    
    //snake body collision detection
//    console.log(snake);
    
    
    //    collision with food check
    if (snakeX == this.food.x && snakeY == this.food.y) {

        this.food = {
            x: Math.round(Math.random() * ((cvs.width / snakedia) - 2) + 1),
            y: Math.round(Math.random() * ((cvs.height / snakedia) - 2) + 1)
        }

        var nHead = {
            x: snakeX,
            y: snakeY
        }
        snake.unshift(nHead);
        
        score+=1;
        document.querySelector('.score-count').textContent = score;

    } else {
        snake.pop();

        var nHead = {
            x: snakeX,
            y: snakeY
        }
        snake.unshift(nHead);
    }

}


function startGame() {
    setInterval(render, snakespeed);
}

//function startGame() {
//    var inter = setInterval(function() {
//        if(status) {
//            draw();
//            console.log(status);
//            console.log('here');
//        } else {
//            clearInterval(inter);
//            console.log('not here');
//        }
//    }, 250);
//}