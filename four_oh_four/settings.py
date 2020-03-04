import os


class Settings:
    def __init__(self):
        self.db = os.getenv('DB')
        self.log_format = os.getenv('LOG_FORMAT', '%(levelname)s [%(name)s] %(message)s')
        self.log_level = os.getenv('LOG_LEVEL', 'INFO')
        self.version = os.getenv('APP_VERSION', 'unknown')
        self.web_server_threads = int(os.getenv('WEB_SERVER_THREADS', '4'))
