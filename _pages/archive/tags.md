---
title: tags
---
{%include data.html%}

<ul>
{% for tag in site.tags%}
  <li><a href="{{site.baseurl}}/tag/{{tag[0] | slug}}">{{tag[0]}}</a></li>
{% endfor%}
</ul>
