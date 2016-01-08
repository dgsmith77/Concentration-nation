from tkinter import *
from PIL import Image, ImageTk, ImageFilter
from random import randint
from threading import *
import config

class Concentration(object):        
    def __init__(self, master):
        master.wm_title(config.TITLE)

        # constants
        self.INIT_MOVE_TEXT = config.INIT_MOVE_TEXT
        self.MOVE_TEXT = config.MOVE_TEXT
        self.MOVES_TEXT = config.MOVES_TEXT
        self.NEW_GAME_TEXT = config.NEW_GAME_TEXT
        self.IMG_PATH = config.IMG_PATH
        self.PAUSE = config.PAUSE
        self.DEFAULT = config.DEFAULT # default image as byte data
        self.PIC_SET = config.PIC_SET # pic set images as byte data
        self.READ_BINARY = config.READ_BINARY
        self.MODE = config.MODE
        self.DO_NOTHING = config.DO_NOTHING
        self.EMPTY_STRING = config.EMPTY_STRING
        self.UNUSED_INDEX = config.UNUSED_INDEX
        self.EXCEPTION_MSG = config.EXCEPTION_MSG
        self.TOTAL_IMAGES = config.TOTAL_IMAGES
        self.NEXT_IMG = config.NEXT_IMG
        # variables
        self.clicks = config.clicks
        self.moves = config.moves
        self.uncovered = config.uncovered
        self.showing = config.showing
        self.prev_index = config.prev_index
        # lists to keep track of images used for individual game
        self.selected_names = [self.UNUSED_INDEX for x in range(16)]
        self.scrambled_names = [self.UNUSED_INDEX for x in range(16)]

        pic_set_file = open(self.PIC_SET, self.READ_BINARY)
        pic_set_txt = pic_set_file.read()
        self.pics_to_display = pic_set_txt.split(bytes(self.NEXT_IMG.encode()))
        
        self.buttons = [Button] * 16
        self.game_images = [ImageTk.PhotoImage] * self.TOTAL_IMAGES

        default_file = open(self.DEFAULT, self.READ_BINARY)
        default_txt = default_file.read()
        default = Image.frombytes(self.MODE, (48, 48), default_txt)
        self.default_img = ImageTk.PhotoImage(default)
                
        self.lbl_moves = Label(master, text=self.INIT_MOVE_TEXT)
        self.lbl_moves.grid(row=0, column=0)

        self.gamebuttonframe = Frame(master)
        self.gamebuttonframe.grid(row=1, column=0)
        index = 0
        for i in range(0, 4):
            for j in range(0, 4):
                self.buttons[index] = Button(self.gamebuttonframe, image=self.default_img,
                                             command=lambda myIndex=index: self.game_button_click(myIndex))
                self.buttons[index].grid(row=i, column=j)   
                index += 1
        
        self.restartframe = Frame(master)
        self.restartframe.grid(row=5, column=0, columnspan=4)
        Button(self.restartframe, text=self.NEW_GAME_TEXT, command=self.new_game).grid(row=0, column=0)

        self.select_indices()

    # Game button click event
    def game_button_click(self, index):
        lock = Lock()
        with lock:
            self.show_image(index)

        t = Thread(target=self.check_for_match, args=(index,))
        t.start()

    # function to check for matches
    def check_for_match(self, index):
        self.clicks += 1
        if self.clicks % 2 == 0 and self.uncovered % 2 == 0:
            self.moves += 1
            moves = self.MOVE_TEXT if self.moves == 1 else self.MOVES_TEXT
            self.lbl_moves.config(text=str(self.moves) + moves)
            if self.scrambled_names[self.prev_index] == self.scrambled_names[index]:
                self.uncovered += 2
            else:
                self.do_pause()
                self.buttons[self.prev_index].config(image=self.default_img,
                    command=lambda myIndex=self.prev_index: self.game_button_click(myIndex))
                self.buttons[index].config(image=self.default_img,
                    command=lambda myIndex=index: self.game_button_click(myIndex))
        self.prev_index = index
        
    # function to start a new game
    def new_game(self):
        # re-initialize everything
        self.clicks = 0
        self.moves = 0
        self.lbl_moves.config(text=self.INIT_MOVE_TEXT)
        self.selected_names = [self.UNUSED_INDEX for x in range(16)]
        self.scrambled_names = [self.UNUSED_INDEX for x in range(16)]
        for i in range(0, 16):
            self.buttons[i].config(image=self.default_img,
                command=lambda myIndex=i: self.game_button_click(myIndex))
        # call function to select names
        self.select_indices()

    # function to select names from the pic set for game
    def select_indices(self):
        index = 0
        used_indices = [-1] * 8
        upper_limit = self.TOTAL_IMAGES - 1
        while True:
            tmp = randint(0, upper_limit)
            if self.selected_names[index] == self.UNUSED_INDEX and used_indices[index] == -1:
                if tmp not in used_indices:
                    used_indices[index] = tmp
                    self.selected_names[index] = tmp
                    self.selected_names[index+8] = tmp
                    index += 1
                    if index > 7:
                        break
        # call function to scramble the names
        self.scramble_indices()

    # function to scramble the names of the pictures in game
    def scramble_indices(self):
        index = 0
        upper_limit = len(self.scrambled_names) - 1
        while True:
            tmp = randint(0, upper_limit)
            if self.scrambled_names[tmp] == self.UNUSED_INDEX:
                self.scrambled_names[tmp] = self.selected_names[index]
                index += 1
                if index > 15:
                    break
        # create all of the images needed for game
        for i in range(0, len(self.scrambled_names)):
            new = Image.frombytes(self.MODE, (48, 48), self.pics_to_display[self.scrambled_names[i]])
            self.game_images[i] = ImageTk.PhotoImage(new)

    # function to reveal the hidden image
    def show_image(self, index):
        try:
            self.buttons[index].config(image=self.game_images[index], command=self.do_nothing)
        except:
            exception = sys.exc_info()[0]
            print(self.EXCEPTION_MSG % exception)
            
    # function to create pause
    def do_pause(self):
        event = Event()
        event.wait(timeout=self.PAUSE)

    # function to do nothing
    def do_nothing(self):
        print(self.DO_NOTHING)

root = Tk()
concentration = Concentration(root)
root.mainloop()
