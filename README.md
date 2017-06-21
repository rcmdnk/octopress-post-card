# octopress-post-card
Post card like link to other page in the site.

## Installation

Install plugin: [octopress-thumbnail](https://github.com/rcmdnk/octopress-thumbnail).

Copy `plugins/post_card.rb` to your `plugins/` directory.

Copy `sass/plugins/_post-card.rb` to your `sass/plugins/` directory.

## Usage

    {% post_card [url/title_url/image] {title/url/filename} [comment] %}

After installation, you can use `post_card` tag, like:


    ...
    
    {% post_card /blog/2013/08/03/computer-windows-autohotkey/ %}
    
    {% post_card /blog/2013/06/10/computer-mac-keyremap4macbook-vim/ %}
    
    ...

This will show like:

![post_card](https://raw.githubusercontent.com/rcmdnk/octopress-post-card/master/post_card.jpg)

An argument can be a title, an url, or a filename (like **2013-08-03-computer-windows-autohotkey.markdown**)
of your post.

An url can be w/ or w/o site url (i.e. **http://rcmdnk/github.com/blog/...** or **/blog/...**).

If `url`, `title_url` or `image` is given at the first,
it will return:

* `url`: URL with link.
* `title_url`: Title with link.
* `image`: Image with link.

Otherwise, it will return a card like link as above.

The last argument of `comment` is not used, but useful
to note what the link is.

It is useful to note a title in the comment when URL is used to find a card.
To find a card, URL is better than title, as a title can be changed.
