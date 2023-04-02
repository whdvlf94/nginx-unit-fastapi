from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"Front": "Hello I'm front"}
