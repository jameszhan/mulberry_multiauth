Multiple authentications with omniauth and support User icon upload and crop.

##Setup your App

> rails g mulberry:multiauth


Go to file config/multiauth_config.yml then modify the following omniauth configs.

~~~yaml

base: &common
  github:
    id: <Your GitHub id>
    secret: <Your Secret id>
  weibo:
    id: <Your Weibo id>
    secret: <Your Secret id>
  qq_connect:
    id: <Your QQ_Connect id>
    token: <Your Secret id>
  taobao:
    id: <Your Taobao id>
    secret: <Your Secret id>
 
development:
  <<: *common
production:
  <<: *common
test:
  <<: *common
~~~
