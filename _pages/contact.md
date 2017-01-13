---
layout: page
title: Contact
---
{%include data.html%}

- <i class="fa fa-envelope" aria-hidden="true" title="email"></i> : [{{admin.email | replace: '@', ' [at] ' | replace: '.', ' [dot] '}}](mailto:{{admin.email}})
- <i class="fa fa-phone" aria-hidden="true" title="phone"></i> : {{admin.phone}}

