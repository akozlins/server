#!/usr/bin/env python3

import config
import flask
import requests

app = flask.Flask(__name__)

# set web hook address:
# `curl "https://api.telegram.org/bot${TOKEN}/setWebhook?url=https://${DOMAIN}/telegram/webhook"`

def sendMessage(chat_id, text) :
    requests.post(f'https://api.telegram.org/bot{config.TOKEN}/sendMessage', json = {
        'chat_id' : chat_id,
        'text' : text,
    })

@app.errorhandler(Exception)
def exception_handler(error) :
    print(error)
    return '', 500

@app.route("/telegram/webhook", methods=[ 'GET' ])
def webhook_get() :
    return "get-ok"

@app.route("/telegram/webhook", methods=[ 'POST' ])
def webhook_post() :
    json = flask.request.get_json()
    print(json, flush=True)

    if "message" not in json :
        return flask.Response('post-ok', status=200)

    message = json['message']

    chat_id = message['chat']['id']
    if chat_id not in config.CHATS :
        return flask.Response('post-ok', status=200)

    sendMessage(
        text = f'chat_id = {chat_id}'
    )

    return flask.Response('post-ok', status=200)

if __name__ == "__main__" :
    app.run(host='0.0.0.0', port=8080, threaded=True, debug=True)
