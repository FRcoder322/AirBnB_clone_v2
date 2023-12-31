from fabric import task
from datetime import datetime
import os

@task
def do_pack(c):
    """Generates a .tgz archive from the contents of the web_static folder."""
    
    # Create the versions folder if it doesn't exist
    c.run('mkdir -p versions')

    # Create the archive name using the current date and time
    now = datetime.now().strftime("%Y%m%d%H%M%S")
    archive_name = f"web_static_{now}.tgz"

    # Compress the web_static folder
    result = c.local(f'tar -cvzf versions/{archive_name} web_static')

    if result.failed:
        return None
    else:
        return os.path.join('versions', archive_name)

