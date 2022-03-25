FROM python:3.9-slim-bullseye

# Create Virtual Environment and Make it availble to whole Container.
ENV VIRTUAL_ENV=/opt/venv

# RUN is used while building the Image

RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install Dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the Application to the Container
COPY app.py .

# CMD is used to when container is executed
# One Way of Writing
# CMD ["python3", "app.py", "--host=0.0.0.0"]

# Second Way of Writing
CMD ["python3","-m","flask","run","--host=0.0.0.0"]


