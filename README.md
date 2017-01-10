# t
process of creating a minimalist jekyll theme from scratch 

---


Table of Contents
=================

  * [t](#t)
  * [Table of Contents](#table-of-contents)
    * [PROCESS](#process)
      * [I\. init](#i-init)
      * [II\. fix gemspec file](#ii-fix-gemspec-file)
      * [III\. update Gemfile](#iii-update-gemfile)
      * [VI\. add an index](#vi-add-an-index)
      * [V\. some templates and layout\.](#v-some-templates-and-layout)
      * [VI\. add posts](#vi-add-posts)
      * [V\. create and organize jekyll pages in a \_pages directory](#v-create-and-organize-jekyll-pages-in-a-_pages-directory)
      * [VI\. add includes](#vi-add-includes)
      * [VII\. data\.\.\.](#vii-data)
      * [VIII\. update layout](#viii-update-layout)
      * [IX\. Markdown:](#ix-markdown)
        * [What'is Mardown ?](#whatis-mardown-)
        * [setting](#setting)
        * [code highlighting (theme)](#code-highlighting-theme)
        * [settings](#settings)
      * [Integrate Bootstrap, Font Awesome](#integrate-bootstrap-font-awesome)
      * [features:](#features)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)


---

## PROCESS

### I. init

1 - generate the new theme directory

```
jekyll new-theme t
```

2 - eneter the directory and do some git stuff

```bash
cd t
```

3 - some git stuff :)

```bash
#git init #not needed: jekyll new-theme do this operation implicitly

git add .

git commit -m "init"

git remote add origin git@github.com:yaitloutou/t.git

git pull origin master --allow-unrelated-histories # git pull -> fatal: refusing to merge unrelated histories

# merge

git push origin master
```

init commit SHA1: af5b598c74834f04c8634b66abadf786bdd9aab6

### II. fix gemspec file

edit this 2 line in [t.gemfile](/t.gemfile)

```ruby
spec.summary       = %q{a short summary, because Rubygems requires one.}
spec.homepage      = "https://github.com/yaitloutou/t"
```

then install the ruby dependencies using this [bundler](http://bundler.io/rationale.html#summary) command:

```
bundle #verbose: bundle install
```

we may now build the site on the preview server, with:

```
bundle exec jekyll serve
```

but.. there is nothing to see yet ^^". 

### III. update Gemfile

I've got an indication that there is no config file, and a suggestion to add to the `Gemfile` the following line, though:

```ruby
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
```

>[Windows Directory Monitor (WMD) ](https://rubygems.org/gems/wdm/versions/0.1.1) is a library which can be used 
>to monitor directories for changes. It's mostly implemented in C and uses the Win32 API for a better performance.

### VI. add an index

add an `index.html`, or an `index.md` with [YAML Front Matter
](https://jekyllrb.com/docs/frontmatter/), to the root directory.
 
### V. some templates and layout.

>Jekyll uses the [Liquid templating](https://shopify.github.io/liquid/) language to process templates. 
>All of the standard Liquid [tags](http://shopify.github.io/liquid/tags/control-flow/) and [filters](http://shopify.github.io/liquid/filters/abs/) 
>are supported. . Jekyll even adds a few [handy filters and tags][j-t] of its own to make common tasks easier.
>
> -- <cite>[jekyll docs][j-t]</cite>

most of jekyll site contents is served via pages, posts, which are (as far as I understand it for now) `md` or `html` files using: 

html [template][j-t] + some [sass](sass-lang.com/) + jakyll/ruby logic.

So, at this step, I've added some simple layouts: 

* `page`and `post` display all the attribute/values of a page/post resp. then its content.
* `home` layout, for `index.md`, display a list of posts ids (relative path).

commit SHA1: 
* update layouts: page,post; update layout home > 29741d10d3b7f171967769af331bc10f62870b5b
* update index.md: layout > e2d1f3013dc06a7b93d781fe7bb93c3c28e91f0b

other refs
* for an in deepth look at jekyll objects check [jekyll-rubydoc][j-rd].
* [advanced-jekyll-templates](http://www.remotesynthesis.com/general/2015/10/02/advanced-jekyll-templates/)

### VI. add posts

for now:

* home: `http://127.0.0.1:4000/`

```    	
    layout : home
    content :
    dir : /
    name : index.md
    path : index.md
    url : /

Posts

    /2016/12/30/post-2
    /2016/12/30/post-1
```

* a post : `http://127.0.0.1:4000/2016/12/30/post-1`

```

    next : This is my 2nd post
    path : _posts/2016-12-30-post-1.md
    output :
    previous :
    content :

    This is my first post, how exciting!
    url : /2016/12/30/post-1.html
    id : /2016/12/30/post-1
    relative_path : _posts/2016-12-30-post-1.md
    collection : posts
    excerpt :

    This is my first post, how exciting!
    draft : false
    categories :
    layout : post
    title : First post!
    date : 2016-12-30 00:00:00 +0000
    slug : post-1
    ext : .md
    tags :

This is my first post, how exciting!
```
### V. create and organize jekyll pages in a _pages directory

by default the jekyll pages are located in the root file eg. `/index.md`. to create create and organize jekyll pages in a _pages directory, similarly to `_posts`. then access this pages without displaying the whole path in the url. I had to use [jekyll collections][j-c] as follows:

1 - Add a _pages_ collection in `_config.yml` :

    collections:
       pages:
         output: true
         permalink: /:path/

2 - create a new directory named `_pages` (it should have the same collection name, prefixed by `_`)

3 - add the pages in the `_pages` folder, as .md or .html files starting with YAML Front Matter.

eg. `/_pages/about.md` will looks like:

    ---
    layout: page
    ---
    
    <!-- about page content -->

after building that, the URL of the `about` page will be `<your-web-site>/about` .

Alternatively, to display a collection name, you have to define its permalink as:

    permalink: /:collection/:path/

Each collection is accessible via the `site` Liquid variable. So, to access the `pages` collection found in `_pages`, you’d use `site.pages`.

### VI. add includes

>These are the partials that can be mixed and matched by your layouts and posts to facilitate reuse. 
>The liquid tag `{% include file.ext %}` can be used to include the partial in `_includes/file.ext.`
>
> -- [jekyll structure][j-s]

for more about jekyll includes, check [jekyll.tips](http://jekyll.tips/jekyll-casts/includes/).

at this step, I've added `head.html header.html footer.html`  and `nav.html` to `/_includes` folder.

for what should/could go into `HEAD`, take a look at Josh Buchea HEAD: 
* github repo: [joshbuchea/HEAD](https://github.com/joshbuchea/HEAD)
* website: http://gethead.info/

### VII. data...

what's the best way to organise a website, or blog data?  basicly, it depends...  

but to keep things simple and clean, and avoid over-loding the `_config.file`. 

So I'll put:

* the website settings (title, description, ...) in `/_data/website.yml`.
* the website owner/default author data (name, email ...) in `/_data/admin.yml`
* if the website support guest posts it may need a `/_data/authors.yml`

(but I still looking for better names >> [one-of-the-coders-hardest-problems](http://www.commitstrip.com/en/2015/10/27/one-of-the-coders-hardest-problems/) )  

**Note:**
* the default data directory in jekyll configuration is `_data`, if you want to put the data in a different folder, you need to add/edit this line in `_config.yml` (cf. [jekyll configuration][j-cf])

```ruby
data_dir:     _data
```
* the supported type of data file are : `.yml .csv .json`
* to access the data `title` from `website.yml` : `site.data.website.title`
* to shorten this I've created a `data.html` in `_includes`, that assigne the data the document to a variable with the same name.

 

```liquid
<!-- TODO: use a forloop -->
{% assign website = site.data.website %}
{% assign admin = site.data.admin %}
{% assign social = site.data.social %}
```

### VIII. update layout

* [attr](https://github.com/yaitloutou/t/blob/2e33e6c7dcc8be948e1d13adce59a798572fd948/_layouts/attr.html) : get `page` attributes
* [page](https://github.com/yaitloutou/t/blob/2e33e6c7dcc8be948e1d13adce59a798572fd948/_layouts/page.html) : `title`, `content`
* [post](https://github.com/yaitloutou/t/blob/2e33e6c7dcc8be948e1d13adce59a798572fd948/_layouts/post.html) : `title`, `creation date`, `author` | `admin` info, `categories` + `tags` if existent, then `content`
* [home](https://github.com/yaitloutou/t/blob/2e33e6c7dcc8be948e1d13adce59a798572fd948/_layouts/home.html) : for each post, display its category ( `category` attribute if not `nil` || the first element of `cotegories` if not `empty`) + `title` +  `tags`.

So, what's added here is some **[liquid loops and logic](https://shopify.github.io/liquid/tags/iteration/)** plus some **html5 tags**.

cf. 
- [html-5-semantics](http://www.hongkiat.com/blog/html-5-semantics/)
- [schema.org](http://schema.org/) sementic html norms 
- a cool [html5 validator](https://validator.w3.org/nu/)

### IX. Markdown:

#### What'is Mardown ?

>Markdown is a text-to-HTML conversion tool for web writers. Markdown allows you 
>to write using an easy-to-read, easy-to-write plain text format, then convert it 
>to structurally valid XHTML (or HTML).
>
> -- [daringfireball.net](https://daringfireball.net/projects/markdown/)

Although there is various Markdown renderers that can be used with Jekyll, [Jekyll configurtion][j-c];

>Jekyll 3 and GitHub Pages now only support [Kramdown][kd] as the Markdown engine, 
>and [Rouge][rg] as the syntax highlighter. 
>
> -- [github](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0)

#### setting 

* `_config.yml` 

```ruby
highlighter: rouge

markdown: kramdown

kramdown:
  input: GFM
  auto_ids: true
  syntax_highlighter: rouge

```
* `Gemfile`

```ruby
#gem "jekyll", "3.3.1"
gemspec
gem 'github-pages'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
```

as for *now* with `jekyll 3.3.1`, `github-pages 112`, this is the same as the default setting, 
but I prefer decare it explicitly

#### code highlighting (theme)

>Rouge is compatible with the Pygments syntax highlighter, which means 
>that we can use [stylesheets created for Pygments](https://github.com/richleland/pygments-css). You can copy any of 
>those files and use them. Preview of this themes available [there](http://richleland.github.io/pygments-css/).
>
> -- [mycyberuniverse.com](http://mycyberuniverse.com/web/syntax-highlighting-jekyll.html)

to use a pygment theme for highlighting:

1- chose a theme: `theme`
2- copy `theme.css` 
3- replace `.codehilite` with `.highlight`

=> now you have a css theme that you can use with rouge to highlight the syntax. just put it in the `css` directory and call if form the `html` files.

4- you can go further and convert it form `css` to `scss` using [css2sass](http://css2sass.herokuapp.com/) (note: although, changing the extention is enough to convert a valid css to a scss, this app does more than that :D ), and place it in the `sass_dir` 

* **way ?**

by using `sass` files, jekyll will process and compress your `css` files at build time to produce a single minified `css` file.
beside that, the A in sass stand for Awesome, and everybody like what's Awesome

* **css vs sass ?**

>Sass is the most mature, stable, and powerful professional grade CSS extension language in the world.
>
> -- [sass-lang](http://sass-lang.com/)

* **sass vs scss ?**

>The new main syntax (as of Sass 3) is known as “SCSS” (for “Sassy CSS”), and is a superset of CSS3's syntax. 
>This means that every valid CSS3 stylesheet is valid SCSS as well. SCSS files use the extension .scss. 
>The second, older syntax is known as the indented syntax (or just “Sass”).
>
> -- [SO](http://stackoverflow.com/questions/5654447/whats-the-difference-between-scss-and-sass)

Or as [Mark Otto](http://markdotto.com/2014/09/25/sass-and-jekyll/) (Creator of Bootstrap) put it:

>As far as I know, Jekyll includes support for both .sass and .scss. If you’re unfamiliar with 
>the differences, .sass allows you to omit curly braces. I recommend sticking with .scss —it’s 
>less clever and more approachable.

btw, you might want to check his github repo [jekyll-example](https://github.com/mdo/jekyll-example)

#### settings

* `/_config.yml`

```ruby
# kramdown + rouge setting

# Assets
# We specify the directory for Jekyll so we can use @imports.
sass:
  sass_dir: _sass
  style: :compresseds
```
* `/_sass`

```bash
+ _sass/
|   code-style.scss  # font, padding, display
|   
\---code-highlight/  # syntax highlight
        default.scss
        colorful.scss
        monokai.scss       
```

* `/asset/css/style.scss`

```yaml
---
# Front matter comment to ensure Jekyll properly reads file.
---
@import "code-highlight/default";
@import "code-style";
```

* `/_include/head.html`

```html
<head>
  <!-- head stuff-->
	 <!-- CSS -->
  <link rel="stylesheet" type="text/css" href="/assets/css/styles.css">
</head>
```

### Integrate Bootstrap, Font Awesome.

//TODO: docuement how I've integrated Bootstrap and Font Awesome on the project locally.

[alternatives](http://alternativeto.net/software/bootstrap/)


### Features:

- [x] social integration
- [ ] social sharing / share link
- [x] list post by Category
- [x] list post by Tag
- [ ] searche
- [x] back to top
- [x] next/previous post
- [ ] pagination
- [ ] contact form
- [ ] disk comment
- [x] drafts
- [ ] drawer menu

#### darfts

[jekyll docs](https://jekyllrb.com/docs/drafts/)

#### Category

1 - I've created a [categories-generator](https://github.com/yaitloutou/t/blob/401a4e93ee4972048a7ffc1374dc02322f58c570/_plugins/categories-generator.rb) [plugin][j-p] that looks for all the post's categories and create a page for each one.

2 - then I created a [category_index.html](https://github.com/yaitloutou/t/blob/401a4e93ee4972048a7ffc1374dc02322f58c570/_layouts/category_index.html) layout that display all the post for a given catgory.

3 - then link each instance of a category `c` in `post` layout to its associated page : `/category/c`:

```html
{% for category in page.categories %}					
  <li>
    <a href="/category/{{category}}">{{category}}</a>
  </li>
{% endfor%}
```

4 - moved the html categories' (and tags) div to include

5 - add some filters to assure that : category `COOL` == `Cool` == `CooL` ... you got the idea, the categories should be case insensitive.
to do so we need :

- all the categories should generate the same url -> use [ruby slug](http://stackoverflow.com/a/4308399/2245329) in categories generator.

```ruby
			slug = category.strip.downcase.gsub(' ', '-').gsub(/[^\w-]/, '')
			site.pages << CategoryPage.new(site, site.source, File.join(dir, slug), category)
```

- when looping through categories in [category_index layout](https://github.com/yaitloutou/t/blob/401a4e93ee4972048a7ffc1374dc02322f58c570/_layouts/category_index.html) the comparison shoud be case insensitive too. -> cast (downcase, using [liquid string filters](http://jekyll.tips/jekyll-casts/string-filters-in-liquid/) ) and capture.
  
```liquid
<ul>
{% for post in site.posts %}
	{% for category in post.categories %}
		{% capture c %}{{ category | strip | downcase }}{% endcapture %}
		{% capture t %}{{ page.title | strip | downcase }}{% endcapture %}
		{% if c == t %}
			<li>
				{{post.date | date: "%m-%d-%Y" }} &raquo;
				<a href="{{post.id}}">{{post.title}}</a>
			</li>
		{% endif %}
	{% endfor %}
{% endfor %}
</ul>
```

that's it. then a last addition is to add `category_dir` in `_configfile`, so we don't have to edit the plugin to change this direrctory atfer.

#### Tags

it's the same as categories ↑, therefor, I refactorize there layout into one called `index_taxonomyhtml`:

so, now the `index_tag.html` (and `index_category.html` ) looks simply like:

```html
---
layout: index_taxonomy
taxonomy: tag
---
```
I still need to refactor their respective generator into one too, and remove this 2 layouts

### next/previous post

```html
<!-- Next/Prevous -->
<div class="page-nav col-xs-12">
	{% if page.next.url %}
	<div class="next col-lg-6 col-md-6 col-xs-12">
		<a href="{{page.next.url}}">{{page.next.title}} &raquo;</a>
	</div>
	{% endif %}

	{% if page.previous.url %}
	<div class="prev col-lg-6 col-md-6 col-xs-12">
		<a href="{{page.previous.url}}">&laquo; {{page.previous.title}}</a>
	</div>
	{% endif %}
</div>
```


[j-t]: https://jekyllrb.com/docs/templates/
[j-rd]: http://www.rubydoc.info/github/mojombo/jekyll/Jekyll/
[j-c]: https://jekyllrb.com/docs/collections/
[j-s]: https://jekyllrb.com/docs/structure/
[j-cf]: https://jekyllrb.com/docs/configuration/
[kd]: https://kramdown.gettalong.org/
[rg]:http://rouge.jneen.net/
[j-p]: https://jekyllrb.com/docs/plugins/
