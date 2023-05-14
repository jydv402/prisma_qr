import json
import qrcode
      
# color hex codes
var = ["a","b","c","d","e","f","g","h","i","j"]

# Data to be written 
dictionary ={ 
  "var": "a"
} 
      
for i in var:
    dictionary["var"]=str(i)

    # Serializing json  
    json_object = json.dumps(dictionary) 
    
    qr = qrcode.QRCode()
    qr.add_data(json_object)
    qr.make(fit=True)
    img = qr.make_image(fill='black',back_color='white')
    img.save(f"{i}.png")

