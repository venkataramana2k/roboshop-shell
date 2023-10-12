location /api/catalogue/ { proxy_pass http://catalogue-dev.sadguru.shop:8080/; }
location /api/user/ { proxy_pass http://user-dev.sadguru.shop:8080/; }
location /api/cart/ { proxy_pass http://cart-dev.sadguru.shop:8080/; }
location /api/shipping/ { proxy_pass http://shipping-dev.sadguru.shop:8080/; }
location /api/payment/ { proxy_pass http://payment-dev.sadguru.shop:8080/; }