#!/usr/bin/python
import vim
import vimjiraformat
import sys
try:
    from jira.client import JIRA
    from jira.utils import JIRAError
    import git
    import getpass
    import keyring
except:
    sys.stdout.write("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    sys.stdout.write("!! Missing one or more Python dependencies !!\n")
    sys.stdout.write("!! pip install jira                        !!\n")
    sys.stdout.write("!! pip install GitPython                   !!\n")
    sys.stdout.write("!! pip install keyring                     !!\n")
    sys.stdout.write("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    raise
# Hide secure ssl warnings with Python 2.6
import requests.packages.urllib3
requests.packages.urllib3.disable_warnings()

def as_ascii(str):
    if str is None:
        return None
    return unicode(str).encode('ascii', 'xmlcharrefreplace')

def get_server(ask=False):
    server = keyring.get_password('vim-jira', 'server')
    if ask or not server:
        server = vim.eval("input('server: ')")
    keyring.set_password('vim-jira', 'server', server)
    return server

def get_username(ask=False):
    username = keyring.get_password('vim-jira', 'username')
    if ask or not username:
        username = vim.eval("input('username: ')")
    keyring.set_password('vim-jira', 'username', username)
    return username

def get_password(ask=False):
    password = keyring.get_password('vim-jira', 'password')
    if ask or not password:
        password = vim.eval("inputsecret('password: ')")
    keyring.set_password('vim-jira', 'password', password)
    return password

def issue(key):
    vim.eval("add(s:breadcrumbs, 'issue:{0}')".format(key))
    jira = JIRA(options={'server':get_server()}, basic_auth=(get_username(), get_password()))
    try:
        issue = jira.issue(key)
        vimjiraformat.display_issue(issue)
    except JIRAError as e:
        vimjiraformat.display_error(e)
        return
    vim.eval("add(s:history, 'issue:{0}')".format(key))

def search(query):
    vim.eval("add(s:breadcrumbs, 'query:{0}')".format(query))
    jira = JIRA(options={'server':get_server()}, basic_auth=(get_username(), get_password()))
    results = []
    try:
        results = jira.search_issues(query, maxResults=150)
        if results.total != len(results):
            answer = vim.eval("input('{0} issues available, get all? [y/N]')".format(results.total))
            if answer == 'y':
                results = jira.search_issues(query, maxResults=results.total)
    except JIRAError as e:
        vimjiraformat.display_error(e)
        return
    vimjiraformat.display_issue_collection(query, results)
    vim.eval("add(s:history, 'query:{0}')".format(query))

