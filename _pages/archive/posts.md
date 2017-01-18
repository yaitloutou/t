---
title: posts
---
<ul>
{% for post in site.posts %}
      <li>
      {{post.date | date: "%m-%d-%Y" }} &raquo;
      <a href="{{post.id}}">{{post.title}}</a>
      </li> <!-- ok -->
{% endfor %}
</ul>
