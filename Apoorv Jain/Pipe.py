import pygame
class Pipe:
    global PIPE_VELOCITY,PIPE_WIDTH,PIPE_HEIGHT
    def __init__(self,width,surface,pos,velocity,gap):
        # self.height=height
        self.width=width
        self.posx=pos[0]
        self.posy=pos[1]
        self.surface=surface
        self.velocity=velocity
        self.gap=gap

    def draw(self):
        SCREENHEIGHT=self.surface.get_size()[1]
        pygame.draw.rect(self.surface,(0 , 255 , 0),[self.posx-self.width/2 , self.posy+self.gap/2 ,
                                                    self.width,SCREENHEIGHT-(self.posy+self.gap/2) ])
        pygame.draw.rect(self.surface,(0 , 0 , 0),[self.posx-self.width/2 , self.posy+self.gap/2 ,
                                                    self.width,SCREENHEIGHT-(self.posy+self.gap/2)] , 2)
        pygame.draw.rect(self.surface,(0 , 255 , 0),[self.posx-self.width/2 , 0 ,
                                                    self.width, self.posy-self.gap/2])
        pygame.draw.rect(self.surface,(0 , 0 , 0),[self.posx-self.width/2 , 0 ,
                                                    self.width, self.posy-self.gap/2] , 2)
    def update(self):
        self.posx-=self.velocity
    def out_of_screen(self):
        if self.posx<-40:
            return True
        else:
            return False
