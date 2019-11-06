import pygame
class Bird:
    def __init__(self,surface,pos,radius,terminal,gravity,jump_velocity,size_buffer):
        self.initialposy=pos[1]
        self.posx=pos[0]
        self.posy=pos[1]
        self.radius=radius
        self.velocity=0
        self.gravity=gravity
        self.surface=surface
        self.terminal=terminal
        self.jump_velocity=jump_velocity
        self.size_buffer=size_buffer
        self.score = 0
        self.brain=None
        # self.fitness=0
        self.AI_SCORE=1

    def draw(self):
         pygame.draw.circle(self.surface,(255,255,0),(self.posx,self.posy),self.radius)
         pygame.draw.circle(self.surface,(0,0,0),(self.posx,self.posy),self.radius,2)
    def update(self,pipes):
        self.AI_SCORE+=0.1
        self.posy+=self.velocity
        self.velocity+=self.gravity
        if self.posy > self.surface.get_size()[1]:
            self.posy=self.surface.get_size()[1]
        if self.posy < 0 + self.radius:
            self.posy= self.radius
        if self.velocity > self.terminal:
            self.velocity=self.terminal
        self.ScoreCheck(pipes)
    def jump(self):
        self.velocity -=self.jump_velocity
    def checkColiision(self,closestPipe):
        if abs(self.posx - closestPipe.posx) < closestPipe.width/2 + self.radius +self.size_buffer :
            if abs(self.posy - closestPipe.posy) < closestPipe.gap/2 -self.radius :
                return False
            else :
                return True
        elif self.posy >= self.surface.get_size()[1]:
            return True
        else:
            return False
    def reset(self):
        # print(clock)

        # print(self.score)
        self.score=0
        self.AI_SCORE=0
        self.posy=self.initialposy
    def ScoreCheck(self,pipes):
        for pipe in pipes:
                if pipe.posx+pipe.width == self.posx :
                    self.score+=1
                    self.AI_SCORE+=10
                    return True
        return False
    def Make_Brain(self,inputnodes,hiddenodes,outputnodes):
        self.brain=Brain(inputnodes, hiddenodes , outputnodes)
    def CopyBrain(self,brain):
        self.brain=Brain.copy(brain)
