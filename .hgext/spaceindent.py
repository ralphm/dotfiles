from mercurial import templatefilters

def spaceindent(text):
    return templatefilters.indent(text, '    ')

def extsetup(ui):
    templatefilters.filters["spaceindent"] = spaceindent

