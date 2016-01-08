from PIL import Image, ImageTk, ImageFilter

# encode all of the image files
pic_set = ["Bear_icon.png","Beaver_icon.png","Bee_icon.png",
           "Bull_icon.png","Cat_icon.png","Chicken_icon.png",
           "Cow_icon.png","Crab_icon.png","Crocodile_icon.png",
           "Deer_icon.png","Dog_icon.png","Dolphin_icon.png",
           "Duck_icon.png","Eagle_icon.png","Elephant_icon.png",
           "Fish_icon.png","Frog_icon.png","Giraffe_icon.png",
           "Goat_icon.png","Gorilla_icon.png","Hippo_icon.png",
           "Horse_icon.png","Kangaroo_icon.png","Koala_icon.png",
           "Lion_icon.png","Lizard_icon.png","Lobster_icon.png",
           "Monkey_icon.png","Mouse_icon.png","Octopus_icon.png",
           "Owl_icon.png","Penguin_icon.png","Pig_icon.png",
           "Rabbit_icon.png","Raccoon_icon.png","Rat_icon.png",
           "Rhino_icon.png","Seal_icon.png","Shark_icon.png",
           "Sheep_icon.png","Snail_icon.png","Snake_icon.png",
           "Squirrel_icon.png","Swan_icon.png","Tiger_icon.png",
           "Tuna_icon.png","Turtle_icon.png","Whale_icon.png",
           "Wolf_icon.png"]

base_file_path = "Concentration\\images\\"

img_file = open("Concentration\\images.txt", "wb")
with Image.open(base_file_path + pic_set[0]) as img:
    encoded_img = img.tobytes()
    img_file.write(encoded_img)
                
for i in range(1, len(pic_set)):
    with Image.open(base_file_path + pic_set[i]) as img:
        encoded_img = img.tobytes()
        img_file.write(bytes("nextimage".encode()))
        img_file.write(encoded_img)
        
img_file.close()
    
# encode the default image
with Image.open("Concentration\\images\\face3.png") as image_file:
    encoded_string = image_file.tobytes()
    file = open("Concentration\\default.txt", "wb")
    file.write(encoded_string)
    file.close()
