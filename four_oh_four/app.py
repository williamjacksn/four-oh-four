import flask
import four_oh_four.db
import four_oh_four.settings
import logging
import sys
import waitress
import werkzeug.middleware.proxy_fix

settings = four_oh_four.settings.Settings()

app = flask.Flask(__name__)
app.wsgi_app = werkzeug.middleware.proxy_fix.ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_port=1)


@app.route('/', methods=['GET', 'POST'])
def index():
    if flask.request.method == 'POST' and 'href' in flask.request.values:
        href = flask.request.values.get('href')
        app.logger.info(f'href: {href}')
    return 'OK'


def main():
    logging.basicConfig(format=settings.log_format, level='DEBUG', stream=sys.stdout)
    app.logger.debug(f'four-oh-four {settings.version}')
    if not settings.log_level == 'DEBUG':
        app.logger.debug(f'Changing log level to {settings.log_level}')
    logging.getLogger().setLevel(settings.log_level)

    db = four_oh_four.db.Database(settings)
    db.migrate()

    waitress.serve(app, ident=None, threads=settings.web_server_threads)
