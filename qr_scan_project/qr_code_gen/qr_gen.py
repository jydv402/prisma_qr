import json
import qrcode
      
# color hex codes
colors = ["F79256","FBD1A2","7DCFB6","00B2CA","1D4E89"]

# Data to be written 
dictionary ={ 
  "color": "ffffff"
} 
      
for i in colors:
    dictionary["color"]=str(i)

    # Serializing json  
    json_object = json.dumps(dictionary) 
    
    qr = qrcode.QRCode()
    qr.add_data(json_object)
    qr.make(fit=True)
    img = qr.make_image(fill='black',back_color='white')
    img.save(f"{i}.png")

