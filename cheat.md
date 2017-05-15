# api Endpoints

list latest min_version:

```bash
curl localhost:3000/ws/v1/min_app_version
``` 

---

read min version 1:

```bash
curl localhost:3000/ws/v1/min_app_versions/1 -H "Content-Type: application/json" -H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ5MjkyNTl9.Fei1711sEGDGrymWMaBIvXdx3k0CVckNUbkMD5VV1Gk"
```

---

signup:

```bash
curl -X POST -F "email=agusti.br@coditramuntana.com" -F "password=123456789" http://localhost:3000/ws/v1/signup
```

---

login:

```bash
curl -X POST -F "email=agusti.br@coditramuntana.com" -F "password=123456789" http://localhost:3000/ws/v1/login

```

create version (httpie):

```bash
http POST :3000/ws/v1/min_app_versions codename="Test Version" description="Lorem ipsum dolor sit amet." platform="ios" min_version="2.0.1" store_uri="https://store.example.com" Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ5MjkyNTl9.Fei1711sEGDGrymWMaBIvXdx3k0CVckNUbkMD5VV1Gk'
```

---

edit version (httpie):

```bash
http PUT :3000/ws/v1/min_app_versions/3 codename="Test Version edit" Authorization:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0OTQ5MjkyNTl9.Fei1711sEGDGrymWMaBIvXdx3k0CVckNUbkMD5VV1Gk'
```

----