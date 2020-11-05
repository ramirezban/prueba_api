require 'uri'
require 'net/http'
require 'json'
require 'openssl'

#link de la pagina de la nasa y su api_key
#se agrego &page=1 en la url (25 elementos)
url ="https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=1&api_key="
api_key = 'zDHUpskY7qfXPhlMfQKD80GqF4bfX3djzuKDzODZ'

#metodo request url y api_key
def request(url ,api_key)
  data=url+api_key
  url = URI(data)
  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.read_body)
end

#hash con los resultados variable aswers
aswers=request(url, api_key)


#definimos el head estructura html
def head()
  head =   '<!DOCTYPE html>
  <html lang="es">
  <head>
  <meta charset="UTF-8">
  <meta name="author" content="Esteban Ramirez" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="trabajo Api Esteban" />
  <title>Fotos de Marte</title>

  <!--CSS bootstrap 4.5.2-->

  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
</head>
  <body>

  <div class="container" >

  '
end
#method build_web_page recibe respuesta
#obtener respuesta y construir pagina (listas con fotos de marte)

def build_web_page(aswers)
  content=''
  aswers.each do |k,v|
    v.each do |photos|
      content += "
      <div class='card mx-auto mt-3 mb-3' style='width: 35rem;'>
          <ul style='list-style-type: none;padding-left: 0px;'': none;' class='mx-auto my-auto'>
            <li><img src='#{photos["img_src"]}' style='width:500px;height:400px' class='card-img-top 'alt='marte'></li>
        </ul>
      </div>
      "
    end
  end
  content
end
#cerrando etiquetas html
def closing()
  finish_body='
    </div>
  </body>
</html>'
end
#output concatenacion de los metodos que construyen la pagina
output= head + build_web_page(aswers)+closing

#Escribimos en un formato html
File.write('index_api.html', output)
