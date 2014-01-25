# -*- coding: utf-8 -*-
"""
    autodoc
    ~~~~~~~

    Autodoc Python implementation.


    `Ruby autodoc <https://github.com/r7kamura/autodoc>`_
    `Perl autodoc <https://metacpan.org/pod/Test::JsonAPI::Autodoc>`_

    :copyright: (c) 2014 Shinya Ohyanagi, All rights reserved.
    :license: BSD, see LICENSE for more details.
"""
import os
import json
from string import Template
from functools import wraps
from autodoc._compat import to_unicode


class Response(object):
    def parse(self, response):
        raise NotImplementedError()


class WebTestResponse(Response):
    def parse(self, response):
        """Parse WebTest response.

        :param response: WebTest response object
        """
        content_type = ''
        for k, v in response.headers.iteritems():
            if k == 'Content-Type':
                content_type = v

        status = response.status_code
        params = ''

        response_body = ''
        if to_unicode(response.body) != '':
            response_body = json.dumps(response.json_body, indent=2)

        request = response.request
        if to_unicode(request.body) != '':
            params = json.dumps(request.json_body, indent=2)

        ret = {
            'status_code': status,
            'response_content_type': content_type,
            'response_body': response_body,
            'target_url': '{0}://{1}'.format(request.scheme, request.host),
            'params': params
        }

        return ret


class Autodoc(object):
    def __init__(self):
        self.clear()
        root_path = os.path.dirname(os.path.abspath(__file__))
        self.template_path = os.path.join(root_path, 'templates',
                                          'template.rst')

    def clear(self):
        self.vars = []

    def parse(self, describe, response):
        if response.__module__ == 'webtest.response':
            klass = WebTestResponse()
        else:
            return

        document = klass.parse(response)
        document['describe'] = describe
        #: This variable is for Sphinx line separata.
        document['describe_separator'] = '-' * len(describe)

        self.vars.append(document)

    def create_document(self, output):
        """Read template file and render file.

        :param output: Output file path.
        """
        if not os.path.exists(self.template_path):
            raise IOError('Template file not found.')

        documents = []
        with open(self.template_path, 'rb') as f:
            data = f.read()
            template = Template(to_unicode(data))
            for v in self.vars:
                document = template.substitute(v)
                documents.append(document)

        with open(output, 'w') as f:
            f.write('\n'.join(documents))

    def _is_runnable(self):
        if 'PYAUTODOC' in os.environ and os.environ['PYAUTODOC'] == '1':
            return True

        return False

    def describe(self, *args, **kwargs):
        def _autodoc(func):
            @wraps(func)
            def __autodoc(*_args, **_kwargs):
                if len(_args) > 0:
                    #: Instance or class method.
                    response = func(_args[0])
                else:
                    #: Function.
                    if len(_kwargs) > 0:
                        response = func(**_kwargs)
                    else:
                        response = func()

                self.parse(args[0], response)

                return func
            return __autodoc
        return _autodoc

    def generate(self, *args, **kwargs):
        def _generate(func):
            @wraps(func)
            def __generate(*_args):
                if len(_args) > 0:
                    arg = _args[0]
                else:
                    arg = _args

                if self._is_runnable() is False:
                    return func

                if 'template' in kwargs:
                    template_path = kwargs['template']
                    if not os.path.isabs(template_path):
                        template_path = os.path.abspath(template_path)

                    self.template_path = template_path

                path = args[0]
                if not os.path.isabs(args[0]):
                    path = os.path.abspath(args[0])

                self.create_document(path)
                #: Initialize.
                self.clear()

                func(arg)

                return func
            return __generate
        return _generate


autodoc = Autodoc()
