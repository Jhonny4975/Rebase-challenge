# Rebase-challenge

This project is a challenge proposed by Rebase, it is an API in Ruby for listing medical exams.

### Tech Stack

- Ruby
- Sinatra
- Docker
- Redis
- Sidekiq

## Install project

### Requirements:

Only three tools are strictly needed:

- git;
- [docker](https://docs.docker.com/get-docker/);
- [docker-compose](https://docs.docker.com/compose/install/).

### Steps

Now we will need to clone the project, enter the project directory and run the script to prepare the application and start the server, for that follow the steps below.

```text
git clone https://github.com/Jhonny4975/Rebase-challenge.git

cd rebase-challenge

bash run
```

After waiting for the script to finish its work you should see something like:

![Screenshot_20220720_143501](https://user-images.githubusercontent.com/60988594/180046512-ddabb19b-c164-48b3-9190-15579e895f32.png)

Great, that means the server is active (don't close this terminal), now we can proceed with the usage instructions.

## Usage

To continue we will need an API client, for this example I will use [Insomnia](https://insomnia.rest/).

### Consult medical exams.

![GET](https://img.shields.io/badge/-GET-green "GET")![/tests](https://img.shields.io/badge/-/tests-grey "/tests")

With the server running, run your client API and make a get request for the `http://localhost:3000/tests` route.

![Screenshot_20220720_145343](https://user-images.githubusercontent.com/60988594/180049736-ee7d4527-db45-4b0c-b800-ffd5912e75a9.png)

It worked out! but why is it empty?

Well, we don't have anything in the database yet, so what we need to do now is create this data. You must be thinking "nice but how do we do that?" well, we have two ways, first, access the container and run a command that reads a previously prepared csv file and persists its data in the database, let's start with that then.

To do this, open another terminal, make sure they are in the same directory as before, and run the following command:

```bash
docker-compose run server bash
```

This command allows us to interact with a terminal inside the container, now we can move on to the next command:

```bash
rake db:seed:csv_data_import
```

After the execution you should see a success message and another one saying that 3900 exams were saved. Now go back to your API client and make the request again.

![Screenshot_20220720_151209](https://user-images.githubusercontent.com/60988594/180053050-9fd068f3-7cee-42c3-a62f-6efde7940625.png)

Wow, it worked, we have a lot of exams now! But what if we want to save our own csv file? This brings us to the second way of populating the database, for which we will need to go back to our API client. You can close the terminal we ran the last command now.

### Importing data from CSV files

![POST](https://img.shields.io/badge/-GET-blue "GET")![/import](https://img.shields.io/badge/-/import-grey "/import")

For this step, with the server running, run the client API and make a post request to the `http://localhost:3000/import` route, don't forget to upload your csv file before submitting.

If you forget or upload a document that is not a csv, you will see an error like this:

![Screenshot_20220721_154546](https://user-images.githubusercontent.com/60988594/180292332-67f83bda-268b-4dd4-83ad-45835a183790.png)

Here is an example request using Insomnia:

![Screenshot_20220721_155210](https://user-images.githubusercontent.com/60988594/180293841-6a560e6f-6cd4-4dd5-bd8b-816ac3586e48.png)

Now make a GET request to `/tests` again and see the csv data you just sent.
