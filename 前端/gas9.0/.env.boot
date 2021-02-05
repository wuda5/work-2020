NODE_ENV = production

# just a flag
ENV = 'boot'
VUE_APP_PROJECT_NAME = 'gmis-ui'

# 开发环境请求域名前缀， 该变量仅仅开发环境需要设置
VUE_APP_DEV_REQUEST_DOMAIN_PREFIX = 'http://172.16.92.108:8081'

# 请求域名前缀， 该变量仅仅生产环境需要设置
VUE_APP_PROD_REQUEST_DOMAIN_PREFIX = 'http://172.16.92.108:8081'

# 是否启用多租户
VUE_APP_IS_MULTI_TENANT = true

# 是否启用验证码
VUE_APP_IS_CAPTCHA = true

# 客户端秘钥
VUE_APP_CLIENT_ID=gmis_ui
VUE_APP_CLIENT_SECRET=gmis_ui_secret

# base api
VUE_APP_BASE_API = '/api'

