#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# dependencies = [ "flask", "requests" ]
# ///

import os

import flask
import requests

import config

TOKEN = os.environ.get('TELEGRAM_TOKEN')

app = flask.Flask(__name__)

@app.errorhandler(Exception)
def exception_handler(error) :
    print(error)
    return '', 500

def sendMessage(chat_id, text) :
    requests.post(f'https://api.telegram.org/bot{TOKEN}/sendMessage', json = {
        'chat_id' : chat_id,
        'text' : text,
    })

bp = flask.Blueprint('bp', __name__)

@bp.route("/webhook", methods=[ 'GET' ])
def webhook_get() :
    return "get-ok"

# set web hook address with:
# `curl "https://api.telegram.org/bot${TOKEN}/setWebhook?url=https://${DOMAIN}/telegram/webhook"`
@bp.route("/webhook", methods=[ 'POST' ])
def webhook_post() :
    json = flask.request.get_json()
    print(json, flush=True)

    message = json.get("message", {})
    if not message :
        return flask.Response('post-ok', status=200)

    chat_id = message.get("chat", {}).get("id", "")
    if chat_id not in config.CHATS :
        return flask.Response('post-ok', status=200)

    sendMessage(chat_id, f'chat_id = {chat_id}')

    return flask.Response('post-ok', status=200)

app.register_blueprint(bp, url_prefix='/telegram')

if __name__ == "__main__" :
    #import waitress
    #waitress.serve(app, host="0.0.0.0", port=8080)
    app.run(host='0.0.0.0', port=8080, threaded=True, debug=True)
