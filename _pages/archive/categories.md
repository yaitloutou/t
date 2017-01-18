---
title: categories
---
{%include data.html%}

<ul>
{% for category in site.categories%}
  <li><a href="{{site.baseurl}}/category/{{category[0] | slug}}">{{category[0]}}</a></li>
{% endfor%}
</ul>
