var map;                            
$(document).ready(function(){       
  map = new GMaps({                 
    el: '#map',                     
    lat: 49.591694,                 
    lng: 31.975276                  
  });                               
  map.addMarker({                   
    lat: 49.591694,                 
    lng: 31.975276,                 
    title: 'База УООР "Коробовка"', 
    click: function(e){             
      if(console.log)               
        console.log(e);             
    },                              
    mouseover: function(e){         
      if(console.log)               
        console.log(e);             
    }                               
  });                               
});                                 
