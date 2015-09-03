#!/usr/bin/python
import vim
import vimjira
from jira.client import JIRA

def as_ascii(str):
    if str is None:
        return None
    return unicode(str).encode('ascii', 'xmlcharrefreplace')

def get_priority_name(issue):
    if issue.fields.priority:
        return as_ascii(issue.fields.priority.name)
    else:
        return ""

def format_link(link):
    if hasattr(link, 'inwardIssue'):
        return "{}(i)".format(link.inwardIssue.key)
    else:
        return "{}(o)".format(link.outwardIssue.key)

def display_subtasks_line(subtasks):
    keys = ", ".join(t.key for t in subtasks)
    if len(keys) > 0:
        vim.current.buffer.append("Subtasks    : {}".format(keys))

def display_links_line(links):
    keys = ", ".join([format_link(l) for l in links])
    if len(keys) > 0:
        vim.current.buffer.append("Linked tasks: {}".format(keys))

def display_comments(issue):
    curbuf = vim.current.buffer
    comments = issue.fields.comment.comments
    curbuf.append("")
    curbuf.append("Comments")
    curbuf.append("="*len("Comments"))
    if len(comments) > 0:
        for comment in comments:
            updated = ""
            if comment.created != comment.updated:
                updated = " (edited)"
            title = "{}: {}{}".format(as_ascii(comment.author), comment.created, updated)
            curbuf.append("")
            curbuf.append(title)
            curbuf.append('-'*len(title))
            for oline in as_ascii(comment.body).split('\r\n'):
                for iline in as_ascii(oline).split('\n'):
                    curbuf.append(iline)

def display_issue(issue):
    vim.command('setlocal modifiable')
    curbuf = vim.current.buffer
    del curbuf[:]
    curbuf[0] = "{}/browse/{}".format(vimjira.get_server(), issue.key)
    curbuf.append("="*len(curbuf[0]))
    curbuf.append("Issue       : {}".format(issue.key))
    curbuf.append("Reporter    : {}".format(as_ascii(issue.fields.reporter)))
    curbuf.append("Assignee    : {}".format(as_ascii(issue.fields.assignee)))
    curbuf.append("Status      : {}".format(as_ascii(issue.fields.status)))
    curbuf.append("Issue type  : {}".format(as_ascii(issue.fields.issuetype)))
    curbuf.append("Priority    : {}".format(get_priority_name(issue)))
    curbuf.append("Components  : {}".format(", ".join([c.name for c in issue.fields.components])))
    curbuf.append("Created     : {}".format(issue.fields.created))
    curbuf.append("Updated     : {}".format(issue.fields.updated))
    if issue.fields.resolutiondate:
        curbuf.append("Resolved    : {}({})".format(issue.fields.resolutiondate, issue.fields.resolution))
    display_subtasks_line(issue.fields.subtasks)
    display_links_line(issue.fields.issuelinks)

    curbuf.append("")
    curbuf.append("Summary")
    curbuf.append("="*len("Summary"))
    curbuf.append(as_ascii(issue.fields.summary))
    curbuf.append("")
    curbuf.append("Description")
    curbuf.append("="*len("Description"))
    if issue.fields.description:
        for oline in issue.fields.description.split('\r\n'):
            for iline in oline.split('\n'):
                curbuf.append(as_ascii(iline))
    display_comments(issue)

    #vim.command('/^Description$')
    #vim.command('normal! jjgqG')
    vim.command('call s:wrap()')
    vim.command('normal! 1G')
    vim.command('redraw')
    vim.command('setlocal nomodifiable')

def display_issue_collection(title, issues):
    if len(issues) < 1:
        return
    vim.command('setlocal modifiable')
    curbuf = vim.current.buffer
    del curbuf[:]
    curbuf[0] = '{} ({} issues)'.format(title, len(issues))
    vim.command('redraw')
    for issue in sorted(issues, key=lambda i: i.fields.updated, reverse=True):
        curbuf.append("{}| {}| {}| {}".format(issue.key, issue.fields.updated, get_priority_name(issue), as_ascii(issue.fields.summary)))
    vim.command('2,$Tabularize /|')
    vim.command('normal! gg')
    vim.command('setlocal nomodifiable')
    vim.command('redraw')

def display_error(e):
    vim.command('setlocal modifiable')
    curbuf = vim.current.buffer
    del curbuf[:]
    for line in str(e).split('\n'):
        curbuf.append(line)
    vim.command('setlocal nomodifiable')
