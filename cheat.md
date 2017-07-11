# api Endpoints

list latest min_version:

```bash
curl localhost:3000/ws/v1/min_app_version

http :3000/ws/v1/min_app_version
``` 

---

read min version 1:

```bash
curl localhost:3000/ws/v1/min_app_versions/1 -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ5MjkyNTl9.Fei1711sEGDGrymWMaBIvXdx3k0CVckNUbkMD5VV1Gk"

http :3000/ws/v1/min_app_versions/1 Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5LCJleHAiOjE0OTgyMzIwODd9.lq3Badyrxa114_51JZyIxrf7SM0-Q2jxXz7Oql5JEsY'
http :3000/ws/v1/min_app_versions/1 Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMCwidXNlcl9lbWFpbCI6InJlY0ByZWMuY29tIiwidXNlcl9hcHBfcmVnaXN0ZXJlZF9hdCI6IjIwMTctMDctMTEgMTY6MzU6MjIgKzAyMDAiLCJleHAiOjIyNTcxNjk1Mzd9.xwNEOdb4edsBzfu3Jbq7CAd9HKSAhpbTHPPhTaW7xso'
```

---

signup:

```bash
curl -X POST -F "email=agusti.br@coditramuntana.com" -F "password=123456789" http://localhost:3000/ws/v1/signup

http POST :3000/ws/v1/signup email="agustibr.10@coditramuntana.com" password="123456789"
```

---

login:

```bash
curl -X POST -F "email=agusti.br@coditramuntana.com" -F "password=123456789" http://localhost:3000/ws/v1/login
http POST :3000/ws/v1/login email="agusti.br@coditramuntana.com" password="123456789"
```

create version (httpie):

```bash
http POST :3000/ws/v1/min_app_versions codename="Test Version" description="Lorem ipsum dolor sit amet." platform="ios" min_version="2.0.1" store_uri="https://store.example.com" Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ5MjkyNTl9.Fei1711sEGDGrymWMaBIvXdx3k0CVckNUbkMD5VV1Gk'
```

---

edit version (httpie):

```bash
http PUT :3000/ws/v1/min_app_versions/3 codename="Test Version edit" Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo5LCJleHAiOjE0OTgyMTI4MDR9.AzSDyNVfUuW85mxZq8mVQ3_lF_0l-GD1-S4Q7oabdvo'
```

----