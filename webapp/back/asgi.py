from fastapi import FastAPI

app = FastAPI()

@app.get("/back")
async def root():
    return {"Back": "Hello I'm Back2"}
