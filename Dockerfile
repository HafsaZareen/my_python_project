FROM python:3.9-slim

WORKDIR /app

# Explicitly define path
COPY ./dist/*.whl /app/ 

RUN pip install /app/*.whl

CMD ["python", "-m", "my_python_project.main"]
