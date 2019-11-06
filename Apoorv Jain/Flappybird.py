import neat
import pygame
from Pipe import *
import random as rand
from random import *
from Bird import *
import numpy as np
import os
GRAVITY=2
SCREENWIDTH, SCREENHEIGHT = 400,600
PIPE_VELOCITY,PIPE_HEIGHT,PIPE_WIDTH,PIPE_GAP = 1.5,200,30,150
PIPE_RANGE = 200
PIPES_DIST=200
BIRD_RADIUS,BIRD_TERMINAL_VELOCITY,BIRD_JUMP=10,7,5
BIRD_POSX=int(SCREENWIDTH/4)
BIRD_SIZE_BUFFER = 2
TOTAL_BIRDS =50
pygame.init()
FPS=30
GEN=0

pygame.font.init()
HIDDEN_LAYERS=20
myfont = pygame.font.SysFont('Comic Sans MS', 15)
clock=pygame.time.Clock()
SCREEN = pygame.display.set_mode((SCREENWIDTH, SCREENHEIGHT))
pygame.display.set_caption('Flappy Bird')
SCREEN.fill((135,206,235))
def closestPipe(pipes):
    min_dist=SCREENWIDTH
    nearest_pipe=None
    for pipe in pipes:
        if pipe.posx+PIPE_WIDTH/2-BIRD_POSX > 0 and pipe.posx+PIPE_WIDTH/2-BIRD_POSX < min_dist:
            min_dist=pipe.posx+PIPE_WIDTH/2-BIRD_POSX
            nearest_pipe=pipe
    return nearest_pipe
def eval_genomes(genomes, config):
    run=True
    pipes=[]
    birds=[]
    nets=[]
    ge=[]
    global GEN
    GEN+=1
    # savedBirds=[]
    Last_pipe = None
    pipes=reset(TOTAL_BIRDS)
    for _,g in genomes:
        net = neat.nn.FeedForwardNetwork.create(g, config)
        nets.append(net)
        bird=Bird(SCREEN,(BIRD_POSX, int(SCREENHEIGHT/2)),BIRD_RADIUS,BIRD_TERMINAL_VELOCITY,GRAVITY,BIRD_JUMP,BIRD_SIZE_BUFFER)
        birds.append(bird)
        g.fitness = 0
        ge.append(g)
    MAX_SCORE=0
    # Generations=1
    ACTUAL_MAX=0
    while run and len(birds) > 0 :
        clock.tick(FPS)
        for event in pygame.event.get():
            if event.type==pygame.QUIT:
                run=False


        if Last_pipe == None or Last_pipe.posx < SCREENWIDTH - PIPES_DIST:
            rand_pipe=int(rand.randrange(-1*PIPE_RANGE/2,PIPE_RANGE/2,1))+SCREENHEIGHT/2
            Last_pipe= Pipe(PIPE_WIDTH,SCREEN,(SCREENWIDTH-PIPE_WIDTH/2,rand_pipe),PIPE_VELOCITY,PIPE_GAP)
            pipes.append(Last_pipe)

            nextPipe=closestPipe(pipes)

        SCREEN.fill((135,206,235))
        # pipe2.draw()
        # pipe2.update()
        for pipe in pipes:
            pipe.draw()
            pipe.update()
            if pipe.out_of_screen():
                pipes.remove(pipe)

        # pygame.draw.rect(SCREEN,(0 , 255 , 0),[10,40,100,80])
        for x,bird in enumerate(birds):
            if bird.AI_SCORE>MAX_SCORE:
                MAX_SCORE=bird.AI_SCORE
            if bird.score > ACTUAL_MAX:
                ACTUAL_MAX=bird.score
            xs=(nextPipe.posx,
                (nextPipe.posy-(PIPE_GAP/2)),
                bird.posy,
                bird.velocity,
                (nextPipe.posy+(PIPE_GAP/2)))
            ge[x].fitness += 0.1
            prediction= nets[x].activate(xs)
            # print(prediction)
            # print(prediction[0] > prediction[1])
            if  prediction[0] > 0.5:
                bird.jump()
            bird.update(pipes)
            if (bird.ScoreCheck):
                ge[x].fitness +=5
            bird.draw()
            if bird.checkColiision(closestPipe(pipes)):

                ge[x].fitness -=2
                # savedBirds.append(bird)
                # print(bird.AI_SCORE)


                birds.remove(bird)
                nets.pop(x)
                ge.pop(x)
                # Last_pipe=None
                # print("collision")
                # print(len(birds))
                # pipes=reset()

        textsurface = myfont.render("Score:"+str(int(ACTUAL_MAX)), False, (0, 0, 0))
        SCREEN.blit(textsurface,(20,30))
        pygame.display.flip()
    clock.tick(FPS)
    # pygame.quit()
def reset(TOTAL_BIRDS):

    pipes=[]
    SCREEN.fill((135,206,235))
    Last_pipe = None
    return pipes
def run(config_file):
    config=neat.config.Config(neat.DefaultGenome, neat.DefaultReproduction,
                                neat.DefaultSpeciesSet, neat.DefaultStagnation,
                                config_file)
    p = neat.Population(config)
    p.add_reporter(neat.StdOutReporter(True))
    stats = neat.StatisticsReporter()
    p.add_reporter(stats)

    winner = p.run(eval_genomes,50)
    print('\nBest genome:\n{!s}'.format(winner))


if __name__ == '__main__':

    local_dir = os.path.dirname(__file__)
    config_path = os.path.join(local_dir, 'config-feedforward.txt')
    run(config_path)
