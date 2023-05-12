#!/usr/bin/env python3

import config
import flask
import os
import requests

app = flask.Flask(__name__)

# set web hook address:
# `curl "https://api.telegram.org/bot${TOKEN}/setWebhook?url=https://${DOMAIN}/telegram/webhook"`

@app.errorhandler(Exception)
def exception_handler(error) :
    print(error)
    return '', 500

@app.route("/telegram/webhook", methods=[ 'GET', 'POST' ])
def index() :
    if flask.request.method == 'POST' :
        json = flask.request.get_json()
        print(json, flush=True)

        if "message" not in json :
            return flask.Response('post-ok', status=200)

        message = json['message']

        chat_id = message['chat']['id']
        if chat_id not in config.CHATS :
            return flask.Response('post-ok', status=200)

        requests.post(f'https://api.telegram.org/bot{config.TOKEN}/sendMessage', json = {
            'chat_id' : chat_id,
            'text' : f'chat_id = {chat_id}',
        })

        return flask.Response('post-ok', status=200)

    else:
        return "get-ok"

if __name__ == "__main__" :
    app.run(host='0.0.0.0', port=8080, threaded=True, debug=True)
