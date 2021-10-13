{% extends "base.tpl" %}

{% block html_head_extra %}
{% lib
    "css/z.icons.css"
    "css/logon.css"
%}
{% endblock %}

{% block title %}
{_ Authorize _}
{% endblock %}

{% block content_area %}
    <div id="signup_logon_box" class="z-logon-box{% if style_boxed %} z-logon-box-boxed{% endif %}">
        <h2 class="z-logon-title">{_ Authorize access to your account _}</h2>

        {% if m.oauth2.client[q.client_id][q.redirect_uri] as app %}
            <p>
                {% trans "Do you want to give <b>{desc}</b> permission to access your account?" desc=app.description|escape %}
            </p>

            <p>
                {% trans "{desc} will be able to:" desc=app.description|escape %}
            </p>

            <ol>
                <li>{_ Act on your behalf and make changes. _}</li>
                <li>{_ Read all content you can read. _}</li>
            </ol>

            {% wire id="oauth2-authorize"
                    type="submit"
                    postback={oauth2_authorize
                        client_id=app.id
                        state=q.state
                        redirect_uri=q.redirect_uri
                        response_type=q.response_type
                        scope=q.scope
                    }
                    delegate=`mod_oauth2`
            %}

            <form id="oauth2-authorize" class="form-inline" method="post" action="postback">
                <p>
                    <button id="oauth2-authorize-accept" name="accept" type="submit" class="btn btn-primary">{_ Allow Access _}</button>
                </p>
                <p>
                    <button id="oauth2-authorize-cancel" name="cancel" type="submit" class="btn btn-default">{_ Cancel _}</button>
                </p>
            </form>
        {% else %}
            <p class="alert alert-warning">{_ Unknown client or redirect, check with your website administrator. _}</p>
        {% endif %}
    </div>
{% endblock %}
