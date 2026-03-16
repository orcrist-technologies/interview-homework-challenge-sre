FROM python:3.12-alpine
 
WORKDIR /app
 
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
 
COPY . .
 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
 
ENV PYTHONUNBUFFERED=1

CMD ["python", "server.py"]
 