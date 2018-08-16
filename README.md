# Convallaria

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix



## scaffold


```

## 数据模型

mix phx.gen.html Accounts User users nickname:string username:string mobile:string email:string encrypted_password:string last_login_at:utc_datetime is_admin:boolean is_active:boolean active_at:utc_datetime

mix phx.gen.html Accounts VerifyCode verify_codes code:string type:integer mobile:string 


mix phx.gen.html Iothubs Product products name:string key:string secret:string node_type:integer desc:string

mix phx.gen.html Iothubs Device devices product_key:string name:string secret:string iotid:string


### 共享
mix phx.gen.html Shares GoodKind good_kinds name:string desc:text --web Admin
mix phx.gen.html Shares GoodItem good_items name:string deposit:float deal_status:integer desc:text --web Admin
mix phx.gen.html Shares GoodDeal good_deals share_at:utc_datetime back_at:utc_datetime deal_status:integer --web Admin

## API

mix phx.gen.json Accounts User users nickname:string username:string mobile:string email:string encrypted_password:string last_login_at:utc_datetime is_admin:boolean is_active:boolean --web Api --no-schema

mix phx.gen.json Iothubs Product products name:string key:string secret:string node_type:integer desc:string --web Api --no-schema

mix phx.gen.json Iothubs Device devices product_key:string name:string secret:string iotid:string --web Api --no-schema

```


ecto数据库支持格式
```

array, binary, boolean, date, decimal, float, integer, map, naive_datetime,
references, string, text, time, utc_datetime, uuid

```

## API状态码

- 1001 用户不存在
- 1002 用户存在
- 1003 密码错误
- 1004 手机号不存在
- 1005 一分钟最多发送3条验证码
- 1006 用户注册成功
- 1007 验证码错误
- 1008 注册信息错误