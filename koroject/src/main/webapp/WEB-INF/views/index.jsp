<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <script src="/resources/js/jquery.min.js"></script>
    <script src="/resources/js/jquery.scrolly.min.js"></script>
    <script src="/resources/assets/js/skel.min.js"></script>
    <link rel="stylesheet" href="/resources/css/style.css">
    <script src="/resources/assets/js/util.js">
        (function($) {

            /**
             * Generate an indented list of links from a nav. Meant for use with panel().
             * @return {jQuery} jQuery object.
             */
            $.fn.navList = function() {

                var $this = $(this);
                $a = $this.find('a'),
                    b = [];

                $a.each(function() {

                    var $this = $(this),
                        indent = Math.max(0, $this.parents('li').length - 1),
                        href = $this.attr('href'),
                        target = $this.attr('target');

                    b.push(
                        '<a ' +
                        'class="link depth-' + indent + '"' +
                        ((typeof target !== 'undefined' && target != '') ? ' target="' + target + '"' : '') +
                        ((typeof href !== 'undefined' && href != '') ? ' href="' + href + '"' : '') +
                        '>' +
                        '<span class="indent-' + indent + '"></span>' +
                        $this.text() +
                        '</a>'
                    );

                });

                return b.join('');

            };

            /**
             * Panel-ify an element.
             * @param {object} userConfig User config.
             * @return {jQuery} jQuery object.
             */
            $.fn.panel = function(userConfig) {

                // No elements?
                if (this.length == 0)
                    return $this;

                // Multiple elements?
                if (this.length > 1) {

                    for (var i = 0; i < this.length; i++)
                        $(this[i]).panel(userConfig);

                    return $this;

                }

                // Vars.
                var $this = $(this),
                    $body = $('body'),
                    $window = $(window),
                    id = $this.attr('id'),
                    config;

                // Config.
                config = $.extend({

                    // Delay.
                    delay: 0,

                    // Hide panel on link click.
                    hideOnClick: false,

                    // Hide panel on escape keypress.
                    hideOnEscape: false,

                    // Hide panel on swipe.
                    hideOnSwipe: false,

                    // Reset scroll position on hide.
                    resetScroll: false,

                    // Reset forms on hide.
                    resetForms: false,

                    // Side of viewport the panel will appear.
                    side: null,

                    // Target element for "class".
                    target: $this,

                    // Class to toggle.
                    visibleClass: 'visible'

                }, userConfig);

                // Expand "target" if it's not a jQuery object already.
                if (typeof config.target != 'jQuery')
                    config.target = $(config.target);

                // Panel.

                // Methods.
                $this._hide = function(event) {

                    // Already hidden? Bail.
                    if (!config.target.hasClass(config.visibleClass))
                        return;

                    // If an event was provided, cancel it.
                    if (event) {

                        event.preventDefault();
                        event.stopPropagation();

                    }

                    // Hide.
                    config.target.removeClass(config.visibleClass);

                    // Post-hide stuff.
                    window.setTimeout(function() {

                        // Reset scroll position.
                        if (config.resetScroll)
                            $this.scrollTop(0);

                        // Reset forms.
                        if (config.resetForms)
                            $this.find('form').each(function() {
                                this.reset();
                            });

                    }, config.delay);

                };

                // Vendor fixes.
                $this
                    .css('-ms-overflow-style', '-ms-autohiding-scrollbar')
                    .css('-webkit-overflow-scrolling', 'touch');

                // Hide on click.
                if (config.hideOnClick) {

                    $this.find('a')
                        .css('-webkit-tap-highlight-color', 'rgba(0,0,0,0)');

                    $this
                        .on('click', 'a', function(event) {

                            var $a = $(this),
                                href = $a.attr('href'),
                                target = $a.attr('target');

                            if (!href || href == '#' || href == '' || href == '#' + id)
                                return;

                            // Cancel original event.
                            event.preventDefault();
                            event.stopPropagation();

                            // Hide panel.
                            $this._hide();

                            // Redirect to href.
                            window.setTimeout(function() {

                                if (target == '_blank')
                                    window.open(href);
                                else
                                    window.location.href = href;

                            }, config.delay + 10);

                        });

                }

                // Event: Touch stuff.
                $this.on('touchstart', function(event) {

                    $this.touchPosX = event.originalEvent.touches[0].pageX;
                    $this.touchPosY = event.originalEvent.touches[0].pageY;

                })

                $this.on('touchmove', function(event) {

                    if ($this.touchPosX === null ||
                        $this.touchPosY === null)
                        return;

                    var diffX = $this.touchPosX - event.originalEvent.touches[0].pageX,
                        diffY = $this.touchPosY - event.originalEvent.touches[0].pageY,
                        th = $this.outerHeight(),
                        ts = ($this.get(0).scrollHeight - $this.scrollTop());

                    // Hide on swipe?
                    if (config.hideOnSwipe) {

                        var result = false,
                            boundary = 20,
                            delta = 50;

                        switch (config.side) {

                            case 'left':
                                result = (diffY < boundary && diffY > (-1 * boundary)) && (diffX > delta);
                                break;

                            case 'right':
                                result = (diffY < boundary && diffY > (-1 * boundary)) && (diffX < (-1 * delta));
                                break;

                            case 'top':
                                result = (diffX < boundary && diffX > (-1 * boundary)) && (diffY > delta);
                                break;

                            case 'bottom':
                                result = (diffX < boundary && diffX > (-1 * boundary)) && (diffY < (-1 * delta));
                                break;

                            default:
                                break;

                        }

                        if (result) {

                            $this.touchPosX = null;
                            $this.touchPosY = null;
                            $this._hide();

                            return false;

                        }

                    }

                    // Prevent vertical scrolling past the top or bottom.
                    if (($this.scrollTop() < 0 && diffY < 0) ||
                        (ts > (th - 2) && ts < (th + 2) && diffY > 0)) {

                        event.preventDefault();
                        event.stopPropagation();

                    }

                });

                // Event: Prevent certain events inside the panel from bubbling.
                $this.on('click touchend touchstart touchmove', function(event) {
                    event.stopPropagation();
                });

                // Event: Hide panel if a child anchor tag pointing to its ID is clicked.
                $this.on('click', 'a[href="#' + id + '"]', function(event) {

                    event.preventDefault();
                    event.stopPropagation();

                    config.target.removeClass(config.visibleClass);

                });

                // Body.

                // Event: Hide panel on body click/tap.
                $body.on('click touchend', function(event) {
                    $this._hide(event);
                });

                // Event: Toggle.
                $body.on('click', 'a[href="#' + id + '"]', function(event) {

                    event.preventDefault();
                    event.stopPropagation();

                    config.target.toggleClass(config.visibleClass);

                });

                // Window.

                // Event: Hide on ESC.
                if (config.hideOnEscape)
                    $window.on('keydown', function(event) {

                        if (event.keyCode == 27)
                            $this._hide(event);

                    });

                return $this;

            };

            /**
             * Apply "placeholder" attribute polyfill to one or more forms.
             * @return {jQuery} jQuery object.
             */
            $.fn.placeholder = function() {

                // Browser natively supports placeholders? Bail.
                if (typeof(document.createElement('input')).placeholder != 'undefined')
                    return $(this);

                // No elements?
                if (this.length == 0)
                    return $this;

                // Multiple elements?
                if (this.length > 1) {

                    for (var i = 0; i < this.length; i++)
                        $(this[i]).placeholder();

                    return $this;

                }

                // Vars.
                var $this = $(this);

                // Text, TextArea.
                $this.find('input[type=text],textarea')
                    .each(function() {

                        var i = $(this);

                        if (i.val() == '' ||
                            i.val() == i.attr('placeholder'))
                            i
                            .addClass('polyfill-placeholder')
                            .val(i.attr('placeholder'));

                    })
                    .on('blur', function() {

                        var i = $(this);

                        if (i.attr('name').match(/-polyfill-field$/))
                            return;

                        if (i.val() == '')
                            i
                            .addClass('polyfill-placeholder')
                            .val(i.attr('placeholder'));

                    })
                    .on('focus', function() {

                        var i = $(this);

                        if (i.attr('name').match(/-polyfill-field$/))
                            return;

                        if (i.val() == i.attr('placeholder'))
                            i
                            .removeClass('polyfill-placeholder')
                            .val('');

                    });

                // Password.
                $this.find('input[type=password]')
                    .each(function() {

                        var i = $(this);
                        var x = $(
                            $('<div>')
                            .append(i.clone())
                            .remove()
                            .html()
                            .replace(/type="password"/i, 'type="text"')
                            .replace(/type=password/i, 'type=text')
                        );

                        if (i.attr('id') != '')
                            x.attr('id', i.attr('id') + '-polyfill-field');

                        if (i.attr('name') != '')
                            x.attr('name', i.attr('name') + '-polyfill-field');

                        x.addClass('polyfill-placeholder')
                            .val(x.attr('placeholder')).insertAfter(i);

                        if (i.val() == '')
                            i.hide();
                        else
                            x.hide();

                        i
                            .on('blur', function(event) {

                                event.preventDefault();

                                var x = i.parent().find('input[name=' + i.attr('name') + '-polyfill-field]');

                                if (i.val() == '') {

                                    i.hide();
                                    x.show();

                                }

                            });

                        x
                            .on('focus', function(event) {

                                event.preventDefault();

                                var i = x.parent().find('input[name=' + x.attr('name').replace('-polyfill-field', '') + ']');

                                x.hide();

                                i
                                    .show()
                                    .focus();

                            })
                            .on('keypress', function(event) {

                                event.preventDefault();
                                x.val('');

                            });

                    });

                // Events.
                $this
                    .on('submit', function() {

                        $this.find('input[type=text],input[type=password],textarea')
                            .each(function(event) {

                                var i = $(this);

                                if (i.attr('name').match(/-polyfill-field$/))
                                    i.attr('name', '');

                                if (i.val() == i.attr('placeholder')) {

                                    i.removeClass('polyfill-placeholder');
                                    i.val('');

                                }

                            });

                    })
                    .on('reset', function(event) {

                        event.preventDefault();

                        $this.find('select')
                            .val($('option:first').val());

                        $this.find('input,textarea')
                            .each(function() {

                                var i = $(this),
                                    x;

                                i.removeClass('polyfill-placeholder');

                                switch (this.type) {

                                    case 'submit':
                                    case 'reset':
                                        break;

                                    case 'password':
                                        i.val(i.attr('defaultValue'));

                                        x = i.parent().find('input[name=' + i.attr('name') + '-polyfill-field]');

                                        if (i.val() == '') {
                                            i.hide();
                                            x.show();
                                        } else {
                                            i.show();
                                            x.hide();
                                        }

                                        break;

                                    case 'checkbox':
                                    case 'radio':
                                        i.attr('checked', i.attr('defaultValue'));
                                        break;

                                    case 'text':
                                    case 'textarea':
                                        i.val(i.attr('defaultValue'));

                                        if (i.val() == '') {
                                            i.addClass('polyfill-placeholder');
                                            i.val(i.attr('placeholder'));
                                        }

                                        break;

                                    default:
                                        i.val(i.attr('defaultValue'));
                                        break;

                                }
                            });

                    });

                return $this;

            };

            /**
             * Moves elements to/from the first positions of their respective parents.
             * @param {jQuery} $elements Elements (or selector) to move.
             * @param {bool} condition If true, moves elements to the top. Otherwise, moves elements back to their original locations.
             */
            $.prioritize = function($elements, condition) {

                var key = '__prioritize';

                // Expand $elements if it's not already a jQuery object.
                if (typeof $elements != 'jQuery')
                    $elements = $($elements);

                // Step through elements.
                $elements.each(function() {

                    var $e = $(this),
                        $p,
                        $parent = $e.parent();

                    // No parent? Bail.
                    if ($parent.length == 0)
                        return;

                    // Not moved? Move it.
                    if (!$e.data(key)) {

                        // Condition is false? Bail.
                        if (!condition)
                            return;

                        // Get placeholder (which will serve as our point of reference for when this element needs to move back).
                        $p = $e.prev();

                        // Couldn't find anything? Means this element's already at the top, so bail.
                        if ($p.length == 0)
                            return;

                        // Move element to top of parent.
                        $e.prependTo($parent);

                        // Mark element as moved.
                        $e.data(key, $p);

                    }

                    // Moved already?
                    else {

                        // Condition is true? Bail.
                        if (condition)
                            return;

                        $p = $e.data(key);

                        // Move element back to its original location (using our placeholder).
                        $e.insertAfter($p);

                        // Unmark element as moved.
                        $e.removeData(key);

                    }

                });

            };

        })(jQuery);
    </script>
    <script src="/resources/assets/js/ie/respond.min.js">
        /*! Respond.js v1.4.2: min/max-width media query polyfill
         * Copyright 2014 Scott Jehl
         * Licensed under MIT
         * http://j.mp/respondjs */

        ! function(a) {
            "use strict";
            a.matchMedia = a.matchMedia || function(a) {
                var b, c = a.documentElement,
                    d = c.firstElementChild || c.firstChild,
                    e = a.createElement("body"),
                    f = a.createElement("div");
                return f.id = "mq-test-1", f.style.cssText = "position:absolute;top:-100em", e.style.background = "none", e.appendChild(f),
                    function(a) {
                        return f.innerHTML = '&shy;<style media="' + a + '"> #mq-test-1 { width: 42px; }</style>', c.insertBefore(e, d), b = 42 === f.offsetWidth, c.removeChild(e), {
                            matches: b,
                            media: a
                        }
                    }
            }(a.document)
        }(this),
        function(a) {
            "use strict";

            function b() {
                v(!0)
            }
            var c = {};
            a.respond = c, c.update = function() {};
            var d = [],
                e = function() {
                    var b = !1;
                    try {
                        b = new a.XMLHttpRequest
                    } catch (c) {
                        b = new a.ActiveXObject("Microsoft.XMLHTTP")
                    }
                    return function() {
                        return b
                    }
                }(),
                f = function(a, b) {
                    var c = e();
                    c && (c.open("GET", a, !0), c.onreadystatechange = function() {
                        4 !== c.readyState || 200 !== c.status && 304 !== c.status || b(c.responseText)
                    }, 4 !== c.readyState && c.send(null))
                },
                g = function(a) {
                    return a.replace(c.regex.minmaxwh, "").match(c.regex.other)
                };
            if (c.ajax = f, c.queue = d, c.unsupportedmq = g, c.regex = {
                    media: /@media[^\{]+\{([^\{\}]*\{[^\}\{]*\})+/gi,
                    keyframes: /@(?:\-(?:o|moz|webkit)\-)?keyframes[^\{]+\{(?:[^\{\}]*\{[^\}\{]*\})+[^\}]*\}/gi,
                    comments: /\/\*[^*]*\*+([^/][^*]*\*+)*\//gi,
                    urls: /(url\()['"]?([^\/\)'"][^:\)'"]+)['"]?(\))/g,
                    findStyles: /@media *([^\{]+)\{([\S\s]+?)$/,
                    only: /(only\s+)?([a-zA-Z]+)\s?/,
                    minw: /\(\s*min\-width\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/,
                    maxw: /\(\s*max\-width\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/,
                    minmaxwh: /\(\s*m(in|ax)\-(height|width)\s*:\s*(\s*[0-9\.]+)(px|em)\s*\)/gi,
                    other: /\([^\)]*\)/g
                }, c.mediaQueriesSupported = a.matchMedia && null !== a.matchMedia("only all") && a.matchMedia("only all").matches, !c.mediaQueriesSupported) {
                var h, i, j, k = a.document,
                    l = k.documentElement,
                    m = [],
                    n = [],
                    o = [],
                    p = {},
                    q = 30,
                    r = k.getElementsByTagName("head")[0] || l,
                    s = k.getElementsByTagName("base")[0],
                    t = r.getElementsByTagName("link"),
                    u = function() {
                        var a, b = k.createElement("div"),
                            c = k.body,
                            d = l.style.fontSize,
                            e = c && c.style.fontSize,
                            f = !1;
                        return b.style.cssText = "position:absolute;font-size:1em;width:1em", c || (c = f = k.createElement("body"), c.style.background = "none"), l.style.fontSize = "100%", c.style.fontSize = "100%", c.appendChild(b), f && l.insertBefore(c, l.firstChild), a = b.offsetWidth, f ? l.removeChild(c) : c.removeChild(b), l.style.fontSize = d, e && (c.style.fontSize = e), a = j = parseFloat(a)
                    },
                    v = function(b) {
                        var c = "clientWidth",
                            d = l[c],
                            e = "CSS1Compat" === k.compatMode && d || k.body[c] || d,
                            f = {},
                            g = t[t.length - 1],
                            p = (new Date).getTime();
                        if (b && h && q > p - h) return a.clearTimeout(i), i = a.setTimeout(v, q), void 0;
                        h = p;
                        for (var s in m)
                            if (m.hasOwnProperty(s)) {
                                var w = m[s],
                                    x = w.minw,
                                    y = w.maxw,
                                    z = null === x,
                                    A = null === y,
                                    B = "em";
                                x && (x = parseFloat(x) * (x.indexOf(B) > -1 ? j || u() : 1)), y && (y = parseFloat(y) * (y.indexOf(B) > -1 ? j || u() : 1)), w.hasquery && (z && A || !(z || e >= x) || !(A || y >= e)) || (f[w.media] || (f[w.media] = []), f[w.media].push(n[w.rules]))
                            }
                        for (var C in o) o.hasOwnProperty(C) && o[C] && o[C].parentNode === r && r.removeChild(o[C]);
                        o.length = 0;
                        for (var D in f)
                            if (f.hasOwnProperty(D)) {
                                var E = k.createElement("style"),
                                    F = f[D].join("\n");
                                E.type = "text/css", E.media = D, r.insertBefore(E, g.nextSibling), E.styleSheet ? E.styleSheet.cssText = F : E.appendChild(k.createTextNode(F)), o.push(E)
                            }
                    },
                    w = function(a, b, d) {
                        var e = a.replace(c.regex.comments, "").replace(c.regex.keyframes, "").match(c.regex.media),
                            f = e && e.length || 0;
                        b = b.substring(0, b.lastIndexOf("/"));
                        var h = function(a) {
                                return a.replace(c.regex.urls, "$1" + b + "$2$3")
                            },
                            i = !f && d;
                        b.length && (b += "/"), i && (f = 1);
                        for (var j = 0; f > j; j++) {
                            var k, l, o, p;
                            i ? (k = d, n.push(h(a))) : (k = e[j].match(c.regex.findStyles) && RegExp.$1, n.push(RegExp.$2 && h(RegExp.$2))), o = k.split(","), p = o.length;
                            for (var q = 0; p > q; q++) l = o[q], g(l) || m.push({
                                media: l.split("(")[0].match(c.regex.only) && RegExp.$2 || "all",
                                rules: n.length - 1,
                                hasquery: l.indexOf("(") > -1,
                                minw: l.match(c.regex.minw) && parseFloat(RegExp.$1) + (RegExp.$2 || ""),
                                maxw: l.match(c.regex.maxw) && parseFloat(RegExp.$1) + (RegExp.$2 || "")
                            })
                        }
                        v()
                    },
                    x = function() {
                        if (d.length) {
                            var b = d.shift();
                            f(b.href, function(c) {
                                w(c, b.href, b.media), p[b.href] = !0, a.setTimeout(function() {
                                    x()
                                }, 0)
                            })
                        }
                    },
                    y = function() {
                        for (var b = 0; b < t.length; b++) {
                            var c = t[b],
                                e = c.href,
                                f = c.media,
                                g = c.rel && "stylesheet" === c.rel.toLowerCase();
                            e && g && !p[e] && (c.styleSheet && c.styleSheet.rawCssText ? (w(c.styleSheet.rawCssText, e, f), p[e] = !0) : (!/^([a-zA-Z:]*\/\/)/.test(e) && !s || e.replace(RegExp.$1, "").split("/")[0] === a.location.host) && ("//" === e.substring(0, 2) && (e = a.location.protocol + e), d.push({
                                href: e,
                                media: f
                            })))
                        }
                        x()
                    };
                y(), c.update = y, c.getEmValue = u, a.addEventListener ? a.addEventListener("resize", b, !1) : a.attachEvent && a.attachEvent("onresize", b)
            }
        }(this);
    </script>
    <script>
        d = document;

        function w(s) {
            d.write(unescape(decodeURIComponent(s)));
        }
        var btJ = 18;
        w("%3chead%3e%3c%74itle%3eUntitled%3c%2ftitle%3e%3cm%65");
        w("ta ch%61rset%3d%22%75%74%66%2d8%22 %2f%3e%3c");
        var nmF = 12;
        if (btJ != 30) w("meta name%3d%22vie%77p%6frt%22 co%6e");
        var VFl = 26;
        if (btJ == 18) w("te%6et%3d%22%77%69dth%3ddevice%2dw%69dth%2c i%6eiti");
        w("al%2dscale%3d1%22 %2f%3e%3cstyle%3e%40import%20ur");
        var Qjw = 27;
        w("l%28%68ttp%3a%2f%2fmaxcdn%2eboo");
        w("tstrapc%64n%2ecom%2ffont%2dawesome%2f4%2e6%2e");
        if (Qjw != 37) w("1%2fcss%2ffont%2d%61wesome%2emi");
        var rM = 31;
        w("n%2ecss%29%3b%40imp%6frt u");
        if (btJ == 26) w("%3a %2d0%2e625em 0 %2d%31px");
        w("r%6c%28%22https%3a%2f%2ffonts%2egoogle");
        if (nmF == 16) w("eatu%72e%73 %3e li%3anth%2dch%69%6cd%28%34%29");
        w("apis%2ecom%2fcss%3ff%61m%69ly%3d");
        if (btJ == 18) w("Raleway%3a3%300%2c%3700%22%29%3b%2f%2aTacti");
        if (Qjw == 30) w("footer %74%65x%74area %7bcolor%3a%20%23%66fffff");
        w("le by Pixelaritypixelarity%2e");
        w("%63om%20%40pi%78e%6carityLicense");
        if (Qjw != 39) w("%3a pixel%61ri%74y%2ecom%2fl");
        w("icense%2a%2fhtml%2c body%2c d");
        w("i%76%2c %73pan%2c applet%2c object%2c");
        w(" iframe%2c h1%2c h%32%2c h%33%2c h4%2c%20h");
        w("5%2c h6%2c p%2c blockquo");
        if (rM != 37) w("te%2c pre%2c a%2c abbr%2c ac%72on%79%6d%2c ad");
        w("%64ress%2c big%2c cite%2c co%64e%2c");
        if (rM == 31) w(" del%2c dfn%2c e%6d%2c%20img%2c%20ins%2c kbd%2c");
        if (VFl == 34) w("%2emajor%3aafter%2c h%35%2em%61jo%72%3aafter%2c %686");
        w(" q%2c s%2c samp%2c %73mall%2c str");
        var hkd = 32;
        if (VFl == 36) w("%7bwid%74h%3a 100%25%3bclear%3a none%3bma");
        w("ike%2c strong%2c sub%2c su");
        var WJb = 10;
        if (btJ != 18) w("t%2dtran%73it%69on%3a %63olor %30%2e2s ease%2di");
        w("p%2c tt%2c %76ar%2c b%2c u%2c i%2c%20");
        var wKC = 25;
        w("center%2c dl%2c dt%2c dd%2c ol%2c ul%2c ");
        var NYw = 31;
        w("li%2c fieldset%2c form%2c%20label%2c leg");
        w("end%2c %74able%2c capt");
        if (WJb != 10) w("i%6e%2dout%3b%2dwebkit%2dtransi%74i%6fn%3a ");
        w("%69o%6e%2c tbody%2c tfoot%2c%20the");
        var KGB = 12;
        w("ad%2c tr%2c th%2c%20td%2c a");
        w("rticle%2c aside%2c canva");
        if (hkd != 32) w("put%5bty%70%65%3d%22radio%22%5d%3af%6fcus %2b ");
        w("s%2c details%2c emb%65d%2c fig");
        w("ure%2c fi%67caption%2c %66oot%65r%2c");
        w(" heade%72%2c hgrou%70%2c menu%2c nav%2c ");
        if (nmF != 23) w("output%2c ru%62y%2c se%63tio");
        w("%6e%2c summary%2c ti%6d%65%2c %6dark%2c");
        w(" audio%2c video %7bmargin%3a 0%3bpadding");
        w("%3a 0%3bb%6frder%3a%200%3bfont%2d");
        w("si%7ae%3a 100%25%3bfont%3a %69%6ehe%72it%3bvert");
        w("ical%2d%61lign%3a baseline%3b%7darticle%2c%20a");
        if (WJb != 14) w("side%2c details%2c figcaption%2c ");
        var Xq = 12;
        w("figure%2c footer%2c ");
        w("%68eader%2c hgrou%70%2c menu%2c %6ea");
        var Fpp = 29;
        if (KGB == 16) w("%3a %23ed6d44%3b%7d%23%6den%75 input%5bt%79pe%3d%22s%75b");
        w("v%2c sec%74ion %7bdisplay%3a ");
        w("block%3b%7d%62ody %7bline%2dheig");
        if (Fpp != 41) w("ht%3a 1%3b%7dol%2c u%6c %7blist%2dstyle%3a ");
        w("%6e%6f%6ee%3b%7dblockquote%2c q %7bquotes");
        var tR = 15;
        if (NYw != 31) w("er %7bposition%3a re%6c%61t%69ve%3b");
        w("%3a none%3b%7dblockquote%3abefore%2c bloc");
        var hVp = 14;
        w("kqu%6fte%3aafter%2c q%3abefor");
        var Qr = 9;
        if (hVp == 20) w("shadow%3a 0%200 0 1px %23");
        w("e%2c q%3aafter %7bcontent%3a %27%27%3bcont%65n");
        var tSP = 1;
        w("t%3a non%65%3b%7dt%61ble %7bborder%2dcolla");
        var RCt = 8;
        w("pse%3a collapse%3b%62order%2dspacing");
        var yS = 20;
        if (Fpp == 44) w("%25%3b%7d%2e%5c%2d9u%5c%328xlarg%65");
        w("%3a 0%3b%7dbody %7b%2dwebk%69t%2dtext%2dsi");
        var lc = 26;
        if (Fpp == 40) w("color%3a %23bbb %21impor%74");
        w("ze%2dadjust%3a no%6e%65%3b%7d%2a%2c");
        w(" %2a%3abefore%2c%20%2a%3aaft");
        var pp = 21;
        if (yS == 20) w("%65r %7b%2dmoz%2dbox%2dsizing%3a%20%62orde%72%2dbox");
        w("%3b%2dwebkit%2dbox%2dsizing%3a bo%72der%2dbox");
        if (Xq != 12) w("fter%2c %23main %3e header h6%2e");
        w("%3bbox%2dsizing%3a border%2dbox%3b%7d%2erow ");
        var wf = 9;
        if (rM != 31) w("%72%2estyle1 %73%65lect%2c %2ewrapper%2esty");
        w("%7bb%6frder%2dbottom%3a %73olid 1p%78 %74ransp");
        w("arent%3b%2d%6doz%2dbox%2d%73izing");
        if (VFl != 34) w("%3a%20border%2dbox%3b%2dwebk%69t%2db%6fx%2ds%69%7ain%67%3a");
        var GN = 11;
        if (KGB == 27) w("t%3a 0%3b%7d%2e%5c31%201u%5c28sma%6cl%5c29%2c");
        w(" border%2dbox%3bbox%2dsiz");
        var QxM = 6;
        w("in%67%3a border%2dbox%3b%7d%2erow %3e %2a %7b");
        w("float%3a left%3b%2dmoz%2dbox%2dsiz");
        var Rn = 17;
        w("ing%3a bor%64%65r%2dbox%3b%2dwe%62kit%2dbox%2dsizi");
        var MZN = 7;
        w("ng%3a borde%72%2dbox%3bbox%2dsizi%6eg%3a bord");
        var Ggy = 18;
        w("e%72%2dbox%3b%7d%2e%72ow%3aa%66ter%2c%20%2er%6fw%3abefor%65");
        if (Fpp != 42) w(" %7bcontent%3a %27%27%3bd%69splay%3a blo%63k%3bc%6c");
        w("ear%3a both%3bheight%3a ");
        if (nmF == 12) w("0%3b%7d%2erow%2euniform %3e %2a %3e %3a%66irs");
        w("t%2dchild %7bma%72gin%2dtop%3a 0%3b%7d%2erow%2e%75");
        w("n%69form%20%3e %2a %3e %3alast%2dchil%64 %7bmar");
        w("gin%2dbott%6fm%3a 0%3b%7d%2erow%2e%5c3%30 %5c25 ");
        var st = 14;
        if (Ggy != 21) w("%3e %2a %7bpaddin%67%3a 0 0 0 0e");
        w("m%3b%7d%2erow%2e%5c30 %5c25 %7b");
        var dNJ = 6;
        w("margin%3a 0 0 %2d1p%78 ");
        var DGl = 17;
        w("%30%65m%3b%7d%2erow%2euniform");
        w("%2e%5c30 %5c25 %3e %2a %7bpadding%3a 0em %30 ");
        var Lj = 18;
        w("0 0em%3b%7d%2erow%2eunif");
        if (yS == 20) w("orm%2e%5c30%20%5c25 %7bmargin%3a 0");
        w("em 0 %2d1px 0em%3b%7d%2erow %3e %2a %7bp");
        if (Qr == 9) w("adding%3a 0 0 0 2em%3b%7d%2erow %7bmarg");
        w("in%3a 0 0 %2d1%70x %2d2em%3b");
        w("%7d%2erow%2euniform%20%3e %2a %7bp");
        w("ad%64ing%3a 2em%200 0 2e%6d%3b%7d%2erow%2eun%69for");
        w("m %7bmargin%3a %2d%32em%200 ");
        w("%2d1px %2d2em%3b%7d%2ero%77%2e%5c32");
        if (VFl == 26) w(" 00%5c25 %3e %2a %7bpadding%3a %30 0 0 4e%6d%3b");
        w("%7d%2erow%2e%5c32 00%5c25 ");
        w("%7bmargin%3a 0 0 %2d1px ");
        if (NYw != 31) w("9%75%5c28m%65d%69um%5c29 %7bm");
        w("%2d4e%6d%3b%7d%2erow%2euniform%2e");
        if (Ggy == 18) w("%5c32 00%5c25 %3e %2a%20%7bp");
        if (NYw == 34) w("ng%2dleft%3a 1em%3bmargin");
        w("adding%3a 4em 0 0 4em%3b%7d%2e");
        var QM = 6;
        w("r%6fw%2euniform%2e%5c%332 00%5c25 %7bmargin%3a");
        w(" %2d%34em 0 %2d1%70x %2d4em%3b%7d%2erow%2e");
        if (tSP != 11) w("%5c31 5%30%5c25 %3e %2a%20%7bpaddin");
        w("%67%3a 0%200 0 3em%3b%7d%2erow%2e%5c31 50%5c2%35 ");
        if (wf == 9) w("%7bmargin%3a 0 0%20%2d1px %2d3em");
        if (btJ == 18) w("%3b%7d%2erow%2eu%6eifo%72m%2e%5c31 5");
        w("0%5c25 %3e %2a %7bpadding%3a 3em 0 0 3em%3b");
        w("%7d%2erow%2euniform%2e%5c31");
        var zgz = 13;
        w(" 50%5c25 %7bmar%67%69n%3a %2d3");
        var rY = 24;
        w("em 0 %2d1px %2d3em%3b%7d%2erow%2e%5c35 0%5c2");
        var kn = 15;
        if (WJb != 12) w("5 %3e %2a %7bpadd%69ng%3a%200%200 0 1em%3b%7d%2er");
        w("ow%2e%5c35 0%5c2%35 %7bmargin%3a 0 0");
        var Mqc = 29;
        if (zgz != 24) w(" %2d1%70x %2d1em%3b%7d%2er%6fw%2eunif%6frm%2e%5c35 0");
        w("%5c25 %3e %2a%20%7b%70addin%67%3a %31em 0 0%201em%3b");
        w("%7d%2er%6fw%2eunif%6frm%2e%5c%335 0%5c25 %7bm");
        w("argin%3a %2d1em 0 %2d1px %2d1%65m%3b%7d%2e");
        w("r%6fw%2e%5c32%205%5c25%20%3e %2a %7bpaddi%6eg%3a 0 0 ");
        if (QxM == 6) w("0 0%2e5em%3b%7d%2erow%2e%5c32 5%5c%32%35 %7bmargin%3a ");
        var kfm = 33;
        w("0 0 %2d1p%78 %2d0%2e5em%3b%7d%2er%6f");
        var fsz = 6;
        w("w%2euni%66orm%2e%5c32 5%5c2%35 %3e %2a %7b%70ad");
        w("ding%3a 0%2e5em 0%200 0");
        var nZ = 16;
        if (NYw != 31) w("%5c29%2c %2e%5c35 u%5c24%5c28medium%5c2");
        w("%2e5em%3b%7d%2er%6f%77%2euni%66or%6d%2e%5c3%32 5");
        w("%5c25 %7bmar%67%69n%3a %2d0%2e%35e%6d 0%20%2d1px%20");
        w("%2d0%2e%35em%3b%7d%2e%5c31%202%75%2c %2e%5c3");
        var ky = 31;
        w("1 %32u%5c24 %7bwidth%3a 100%25%3bclear%3a");
        w(" none%3bmargin%2dleft%3a 0%3b%7d%2e%5c3");
        if (st != 14) w("%2ditems%3a cen%74er%3bpadding%3a%204em 0 2");
        w("1 1u%2c %2e%5c31%201u%5c24%20%7bwid");
        var cl = 10;
        w("th%3a 91%2e666%36666667%25%3bclear%3a no%6ee");
        if (Qr != 16) w("%3bmar%67in%2dleft%3a 0%3b%7d%2e%5c31 0u%2c %2e%5c");
        var WD = 27;
        if (hVp == 24) w("%5c2%35 %3e %2a %7bpadding%3a%20%34%65m");
        w("31 0u%5c24 %7bwi%64%74h%3a %383%2e3");
        w("3333333%33%33%25%3bclear%3a %6e");
        w("%6fne%3bmargin%2dl%65ft%3a %30%3b%7d%2e%5c%339 %75");
        w("%2c %2e%5c39 u%5c24 %7bwidth%3a 75%25%3bclear");
        w("%3a none%3bm%61rgin%2dleft%3a 0%3b%7d%2e%5c");
        if (btJ != 25) w("38 u%2c %2e%5c38 u%5c24 %7bwidth%3a");
        w(" 6%36%2e%36666666667%25%3bcle");
        var wYD = 1;
        w("a%72%3a n%6f%6ee%3bma%72gin%2dleft%3a 0%3b%7d%2e%5c37");
        var PlB = 11;
        w(" u%2c%20%2e%5c37 u%5c24%20%7b%77idth%3a");
        w(" 5%38%2e33333%333%3333%25%3bclea");
        var TyZ = 30;
        w("r%3a none%3bma%72gin%2d%6ceft%3a 0%3b%7d%2e%5c36%20u%2c");
        w(" %2e%5c%33%36 u%5c%324 %7bw%69dth");
        w("%3a 50%25%3bclear%3a non");
        w("e%3bmargin%2dleft%3a 0%3b%7d%2e%5c35 ");
        w("u%2c %2e%5c35 u%5c24 %7bwidth%3a%20%341%2e66666%366");
        if (NYw != 31) w("der %7bbackground%2dcolo%72%3a %23%3444%3bc");
        w("6%367%25%3bclear%3a no%6ee%3bmarg%69%6e%2dleft%3a%20%30");
        if (lc != 26) w("mit%22%5d%2es%6dall%2cinput%5btype%3d%22");
        w("%3b%7d%2e%5c%334 u%2c %2e%5c34 u");
        w("%5c24%20%7bw%69dt%68%3a 33%2e3333333%3333");
        w("%25%3b%63le%61%72%3a n%6fne%3b%6d%61rgin%2dleft%3a 0%3b");
        w("%7d%2e%5c33 u%2c %2e%5c33 u%5c24 %7b%77idth%3a 25%25%3b%63");
        w("lear%3a none%3bmargin%2dleft%3a%20%30%3b%7d%2e%5c");
        var mtJ = 32;
        w("32 u%2c %2e%5c32%20u%5c2%34 %7bwi%64th%3a ");
        if (st != 15) w("1%36%2e6666666667%25%3bcl");
        if (kfm != 35) w("ear%3a none%3bmargin%2dleft");
        w("%3a 0%3b%7d%2e%5c31 %75%2c %2e%5c31 ");
        if (PlB != 21) w("u%5c24 %7b%77idth%3a 8%2e%33333333");
        if (NYw != 31) w("wrapper%2estyle2 button%3aho");
        w("333%25%3bclear%3a non%65%3bmargin%2dle%66t%3a 0%3b");
        var gc = 11;
        w("%7d%2e%5c3%31 2u%5c24 %2b %2a%2c%2e%5c31 1u%5c24 %2b");
        w(" %2a%2c%2e%5c31 0u%5c%324%20%2b %2a%2c%2e%5c39 u%5c24");
        w(" %2b %2a%2c%2e%5c38 u%5c2%34 %2b %2a%2c%2e%5c37 u%5c24 %2b");
        w(" %2a%2c%2e%5c36 u%5c24 %2b %2a%2c%2e%5c3%35 u");
        var RCk = 26;
        w("%5c%32%34 %2b %2a%2c%2e%5c34 u%5c24 %2b %2a%2c%2e%5c33 %75%5c24 ");
        var rNS = 32;
        w("%2b %2a%2c%2e%5c32 u%5c24 %2b ");
        w("%2a%2c%2e%5c31%20u%5c24 %2b %2a %7b");
        var pbG = 2;
        if (ky != 46) w("clear%3a left%3b%7d%2e%5c%2d11%75 %7bmargi%6e%2dl");
        var JR = 11;
        w("eft%3a 91%2e66667%25%3b%7d%2e%5c%2d10u %7bma");
        w("rgin%2d%6ceft%3a 83%2e33333%25%3b%7d%2e%5c");
        w("%2d9u %7bmargin%2d%6ceft%3a 75%25%3b%7d%2e%5c%2d8u %7bma");
        w("rg%69n%2dleft%3a 66%2e66667%25%3b%7d%2e");
        var NM = 8;
        w("%5c%2d%37u %7b%6dargin%2dleft%3a 58%2e33333%25%3b%7d");
        w("%2e%5c%2d6u %7bm%61%72gin%2dlef%74%3a");
        if (gc == 11) w(" 50%25%3b%7d%2e%5c%2d5u%20%7bmargin%2dle");
        if (rY == 24) w("ft%3a%2041%2e66667%25%3b%7d%2e%5c%2d4%75 %7bmargin%2dle");
        w("ft%3a 33%2e33333%25%3b%7d%2e%5c%2d3");
        var PkP = 1;
        w("u %7bmargin%2dleft%3a 25%25%3b%7d%2e%5c%2d2u %7bm");
        w("argin%2dle%66t%3a 16%2e66667%25%3b%7d%2e%5c%2d1u %7b");
        w("margi%6e%2dlef%74%3a 8%2e333");
        w("33%25%3b%7d%40med%69a screen and %28max%2dwi");
        w("dth%3a 1%3680px%29%20%7b%2erow %3e %2a");
        var Dc = 22;
        if (kn != 20) w(" %7bpadding%3a 0 0%200%202em%3b%7d%2erow %7bmarg");
        w("in%3a 0 0 %2d1px %2d2em%3b%7d%2erow%2euni%66or");
        w("m %3e %2a %7bp%61ddin%67%3a 2e%6d");
        w(" 0 0 2em%3b%7d%2ero%77%2eu%6e%69form ");
        w("%7bmargi%6e%3a %2d2em 0 %2d1px %2d2em%3b%7d%2erow");
        w("%2e%5c32 00%5c2%35 %3e %2a %7b%70adding%3a");
        if (st != 29) w(" 0 0 0 4em%3b%7d%2erow%2e%5c32 00%5c25");
        if (rM == 31) w(" %7b%6d%61rgin%3a 0 0 %2d1p%78 %2d");
        var Zz = 2;
        w("4em%3b%7d%2erow%2e%75niform%2e%5c32 00");
        if (ky != 36) w("%5c25%20%3e %2a %7bpadd%69ng%3a%204em");
        w(" %30 0 4%65m%3b%7d%2er%6fw%2euniform%2e%5c32 00%5c25");
        w(" %7bmargin%3a %2d4em 0 %2d%31px");
        if (kn != 15) w("ft%3a 0%3b%7d%2e%5c31 %32u%5c24%5c28");
        w(" %2d4em%3b%7d%2erow%2e%5c31 50%5c25 %3e%20%2a %7bpa");
        w("dding%3a 0 0 0 3em%3b%7d%2erow%2e%5c%331 50%5c2");
        var Wtd = 27;
        w("5 %7bmargi%6e%3a 0 0 %2d1%70x %2d%33");
        if (st != 17) w("em%3b%7d%2erow%2eunif%6frm%2e%5c31 50%5c%325%20%3e%20%2a ");
        var tQJ = 26;
        w("%7bpadding%3a 3e%6d 0 0 3em%3b%7d%2erow");
        if (GN != 11) w("%335%29%3b%7d%2efeatures %3e");
        w("%2euni%66%6frm%2e%5c3%31 %350%5c");
        if (Mqc != 31) w("25 %7bmargin%3a %2d3em 0 %2d1p");
        w("x %2d3em%3b%7d%2erow%2e%5c35 0%5c2%35 %3e %2a %7b");
        w("pad%64i%6eg%3a 0 0%200 1em%3b%7d%2ero");
        w("w%2e%5c35 0%5c25%20%7bmargin%3a ");
        w("0 %30 %2d1px %2d1em%3b%7d%2erow%2eunifo%72m%2e%5c3");
        w("5 %30%5c25 %3e %2a %7bpadding%3a 1em 0 0 ");
        w("1em%3b%7d%2erow%2e%75n%69form%2e%5c");
        w("35 0%5c25 %7bmargin%3a ");
        if (GN == 16) w("large%5c29%2c %2e%5c33%20u%5c24%5c28%6c");
        w("%2d1em %30 %2d1px %2d1em%3b%7d%2erow%2e%5c32");
        w(" 5%5c25 %3e %2a %7bpaddi");
        w("ng%3a %30 0 0%200%2e5em%3b%7d%2ero");
        w("w%2e%5c32%205%5c25 %7bmargin%3a 0 0");
        w(" %2d1px %2d0%2e5em%3b%7d%2er%6fw%2eunif");
        if (kfm != 40) w("orm%2e%5c32 5%5c25 %3e%20%2a %7bp");
        var zF = 16;
        w("adding%3a %30%2e5em 0 0%200%2e");
        w("%35em%3b%7d%2e%72ow%2euniform%2e%5c32 5%5c25");
        if (QM != 6) w("3%25%3bc%6cea%72%3a none%3bma");
        w(" %7bmargin%3a %2d0%2e5em 0 %2d1px %2d0%2e");
        w("5%65m%3b%7d%2e%5c31 2u%5c28xlar");
        if (pp != 21) w("3%33333%33333%33%25%3bcle%61r%3a ");
        w("ge%5c%329%2c%20%2e%5c31 2u%5c24%5c");
        w("28xlarge%5c2%39%20%7bwidth%3a ");
        w("1%300%25%3bclear%3a none%3bma%72%67in%2d");
        if (wKC != 25) w("%200 0 4%65%6d%3b%7d%2ero%77%2eu%6eiform%2e%5c32 00%5c25");
        w("left%3a 0%3b%7d%2e%5c31 1u%5c28xlarge%5c");
        w("29%2c %2e%5c%331 %31u%5c24%5c28xlar%67e%5c29");
        w("%20%7bwidth%3a 91%2e6666666667%25");
        w("%3bclear%3a none%3bmargin%2dleft%3a 0%3b%7d%2e%5c3");
        w("1 0u%5c28x%6carge%5c29%2c %2e%5c31 ");
        w("0u%5c24%5c28x%6carge%5c29 %7bw%69d");
        w("th%3a 83%2e3333333333%25%3bc%6ce");
        w("ar%3a none%3bm%61rgi%6e%2dleft%3a");
        w(" %30%3b%7d%2e%5c3%39 u%5c28xla");
        var mG = 7;
        w("rge%5c29%2c %2e%5c39 u%5c24%5c28x%6c");
        w("arge%5c29 %7bwidth%3a 75%25%3bclear%3a %6e");
        var PD = 9;
        w("one%3bmargin%2dleft%3a 0%3b%7d%2e%5c38 %75%5c2");
        w("8x%6carge%5c29%2c %2e%5c38 %75%5c24%5c28x%6carg%65");
        w("%5c29 %7bwidth%3a 66%2e666666666%37%25%3b%63le%61r");
        if (kfm != 45) w("%3a n%6fne%3bmargin%2dl%65ft%3a 0%3b%7d%2e%5c3");
        w("7 u%5c%328xlarge%5c29%2c %2e%5c37 u%5c24%5c");
        var Xng = 26;
        w("28xla%72ge%5c29 %7bwidth%3a");
        var Qgw = 24;
        if (tSP == 1) w(" 58%2e3333333333%25%3bclear%3a none%3b");
        var zJF = 12;
        w("m%61rgin%2dlef%74%3a 0%3b%7d%2e%5c3%36");
        w(" u%5c%328xlarge%5c29%2c %2e%5c3");
        if (nZ != 18) w("6 u%5c24%5c2%38x%6ca%72ge%5c2%39 %7bwidth%3a 50%25%3bc");
        var XJd = 13;
        if (Qr != 23) w("le%61r%3a none%3bmargin%2dleft%3a %30%3b%7d%2e");
        if (zF != 16) w("m%29%3b%2dms%2dtransf%6frm%3a translate");
        w("%5c35 u%5c28xlarge%5c29%2c %2e%5c35 %75%5c2");
        w("4%5c28xla%72ge%5c29 %7bwi%64");
        w("th%3a 41%2e666666%3666");
        var nRj = 11;
        w("7%25%3bclear%3a %6eon%65%3bmar%67in");
        var Snz = 30;
        w("%2dl%65%66t%3a 0%3b%7d%2e%5c34 u%5c28xlarge%5c29%2c ");
        w("%2e%5c34 u%5c24%5c28xlarge%5c");
        w("2%39 %7bwid%74h%3a 33%2e33%33%3333333");
        w("3%25%3bclear%3a n%6fne%3bmar");
        var gH = 6;
        w("gin%2dleft%3a 0%3b%7d%2e%5c33 u%5c28xl%61r%67e");
        if (NM == 8) w("%5c29%2c %2e%5c33 u%5c24%5c28");
        w("xlarge%5c2%39 %7b%77idth%3a 25%25%3bclear%3a");
        w(" n%6fne%3b%6d%61%72gin%2dleft%3a");
        w(" 0%3b%7d%2e%5c32 u%5c28xl%61r");
        var nn = 11;
        w("ge%5c29%2c %2e%5c32 u%5c2%34%5c28");
        var mzQ = 32;
        if (gc != 11) w("ea%3afocus %7b%62or%64%65r%2dcolor%3a %23ef");
        w("x%6carge%5c29 %7bwidth%3a%2016%2e%3666");
        w("66666%367%25%3b%63le%61r%3a none%3bma");
        var shv = 14;
        if (Snz != 30) w("a%6cl%5c29 %7bwidth%3a 41%2e66666%366667%25");
        w("rgin%2d%6ceft%3a 0%3b%7d%2e%5c31 u%5c28x");
        w("large%5c2%39%2c %2e%5c31 u%5c24%5c%328xla");
        if (Qgw == 24) w("rge%5c29 %7bwidth%3a 8%2e333333%33333%25%3bc");
        var BJ = 3;
        w("lear%3a%20%6eone%3bmargin%2dle");
        if (RCk == 26) w("f%74%3a 0%3b%7d%2e%5c31 2u%5c24%5c28");
        if (Qgw != 35) w("xl%61rge%5c29 %2b %2a%2c%2e%5c31 %31u%5c24%5c28x");
        w("l%61rge%5c2%39 %2b %2a%2c%2e%5c31 0u");
        var mfL = 7;
        if (kfm != 45) w("%5c%324%5c28xlarge%5c2%39 %2b %2a%2c%2e%5c39 u%5c%324%5c2");
        if (zgz != 18) w("8xlarge%5c29 %2b %2a%2c%2e%5c%338 u%5c");
        w("24%5c28xla%72g%65%5c%329 %2b %2a%2c%2e%5c37");
        w("%20u%5c24%5c28xlarge%5c29 %2b %2a%2c%2e%5c36");
        var HT = 32;
        if (Xng != 29) w(" u%5c24%5c2%38xlarge%5c29%20%2b %2a%2c%2e%5c3%35");
        if (Xng == 28) w("r input%5btype%3d%22su");
        w(" %75%5c24%5c28%78%6carge%5c%329%20%2b %2a%2c%2e%5c3%34 ");
        if (PlB == 11) w("u%5c%324%5c%328xlarge%5c29 %2b %2a%2c%2e%5c33 ");
        if (gH != 12) w("u%5c24%5c28xlarge%5c29 %2b %2a%2c%2e");
        w("%5c32 u%5c2%34%5c28xlarg%65%5c29%20");
        w("%2b %2a%2c%2e%5c3%31 u%5c24%5c28xlarge%5c29 %2b%20");
        var sM = 11;
        w("%2a %7bclear%3a lef%74%3b%7d%2e%5c%2d11u");
        w("%5c28xlarge%5c29 %7bmargin%2d%6cef%74%3a ");
        w("91%2e66667%25%3b%7d%2e%5c%2d10u%5c28xlar%67e");
        w("%5c29 %7bmargin%2dl%65%66t%3a%208%33%2e3%33333");
        if (hkd == 43) w("e%5c29%2c %2e%5c31 1u%5c24%5c28la");
        w("%25%3b%7d%2e%5c%2d9u%5c28xl%61rge");
        if (XJd != 26) w("%5c29%20%7bm%61r%67in%2d%6ceft%3a 75%25%3b%7d%2e%5c%2d%38u");
        w("%5c28x%6c%61rge%5c29 %7bmargin%2d");
        var sP = 13;
        w("left%3a 66%2e%366667%25%3b%7d%2e%5c");
        w("%2d7u%5c28xlarge%5c29 %7bmar%67in");
        var Yp = 29;
        w("%2dleft%3a 58%2e33333%25%3b%7d%2e%5c%2d6u%5c");
        var csw = 31;
        w("28xlarge%5c29 %7bmargin%2d");
        if (Qjw == 28) w("2 %69nput%5btyp%65%3d%22text%22%5d%2c%2ewrap");
        w("left%3a 50%25%3b%7d%2e%5c%2d5u%5c28xlarge%5c2");
        var CPk = 14;
        w("9 %7bmarg%69n%2dle%66t%3a 41%2e%36666%37%25%3b%7d%2e%5c%2d%34u");
        var sBH = 17;
        if (zF != 16) w("%3b%7d%23foot%65r a %7bcolo%72%3a %23%65f7f");
        w("%5c28x%6c%61rge%5c29 %7bmargin%2dleft%3a %33");
        w("%33%2e33333%25%3b%7d%2e%5c%2d3u%5c%328");
        var pPS = 6;
        w("xlar%67e%5c2%39 %7bmargin%2dlef%74%3a 2");
        w("5%25%3b%7d%2e%5c%2d2u%5c%328%78%6carge%5c29 %7bma");
        w("rgin%2dleft%3a 16%2e66667%25%3b%7d%2e");
        if (mfL == 19) w("e%72%2dbox%3b%7d%2e%72ow%3aaft%65r%2c %2erow%3abe%66ore");
        w("%5c%2d1u%5c28%78la%72ge%5c29 %7b%6d%61rgin%2dl%65%66%74%3a");
        var hj = 8;
        if (wf != 19) w(" %38%2e33333%25%3b%7d%7d%40medi%61 sc");
        w("reen and %28max%2dwidth%3a 1280px");
        if (Lj == 24) w("ter%2devents%3a n%6f%6ee%3bpointer%2deven");
        w("%29%20%7b%2erow %3e %2a %7bp%61dding%3a 0 0 0 ");
        if (Ggy == 25) w("inner %3e %2a %7b%2dmoz%2dtransition%3a");
        w("1%2e5em%3b%7d%2erow %7bmargin%3a 0%200 %2d1");
        var TDH = 19;
        w("%70x%20%2d1%2e5%65m%3b%7d%2erow%2eu%6e");
        w("iform %3e %2a %7bpadding%3a 1%2e");
        w("5em 0 0 1%2e5em%3b%7d%2er%6fw%2eu");
        var gwq = 22;
        if (Yp != 34) w("ni%66orm %7bmargin%3a %2d1%2e5e%6d 0 %2d1px");
        w(" %2d1%2e5em%3b%7d%2erow%2e%5c32 %300%5c25 %3e %2a %7bpad");
        var jQ = 16;
        w("ding%3a%20%30 0 0 3em%3b%7d%2e%72ow%2e%5c32 0");
        w("0%5c25 %7bmargin%3a 0 0 ");
        w("%2d1px %2d%33em%3b%7d%2erow%2euni%66orm%2e%5c32 ");
        if (mfL == 7) w("00%5c%325 %3e %2a %7bpaddi%6e");
        w("g%3a 3em 0 0 %33e%6d%3b%7d%2e%72ow%2euniform%2e");
        w("%5c32%2000%5c25 %7bmargin%3a %2d3");
        if (KGB == 14) w("1 2u%5c24 %7bwi%64th%3a 10%30%25%3bcle%61r%3a");
        w("em 0 %2d1px %2d3em%3b%7d%2erow%2e%5c31 5%30%5c");
        if (PkP == 1) w("25 %3e%20%2a %7bpa%64ding%3a 0 0%200 2%2e25e%6d%3b%7d");
        if (yS == 20) w("%2erow%2e%5c3%31 50%5c25 %7b");
        w("margin%3a 0 0 %2d1px");
        if (kn == 15) w(" %2d2%2e25e%6d%3b%7d%2erow%2eun");
        if (cl != 14) w("iform%2e%5c31 %350%5c25 %3e %2a %7bpad");
        if (Rn != 31) w("ding%3a 2%2e25em 0 0 2%2e2%35em%3b");
        w("%7d%2erow%2e%75niform%2e%5c%331 50%5c2");
        var VV = 6;
        w("5 %7bm%61rg%69n%3a %2d%32%2e25%65m");
        if (btJ != 18) w("apper%2e%73tyle1 %3a%3a%2dwebkit%2dinput%2dpla");
        w(" 0 %2d1px %2d2%2e25em%3b%7d%2ero%77%2e%5c%33");
        var PxF = 1;
        if (st == 15) w(" rgba%280%2c 0%2c 0%2c 0%2e28%29%3b%7d%2ef");
        w("5 0%5c25 %3e %2a %7bpaddi");
        var CbQ = 10;
        w("ng%3a 0 0 0 0%2e75em%3b%7d%2ero");
        if (JR != 11) w("%7d%2er%6f%77%2euniform%2e%5c31 50%5c2");
        w("w%2e%5c35 0%5c25 %7bmargi");
        w("n%3a 0 0 %2d1p%78 %2d0%2e75em%3b%7d%2erow%2eu");
        if (Xq == 15) w("%3125em%3b%7d%2erow%2e%5c32 5%5c25 %7bma");
        w("niform%2e%5c35 %30%5c25 %3e %2a %7bpad%64ing");
        var zS = 8;
        w("%3a 0%2e%375em 0 0 0%2e75em%3b%7d%2e%72ow%2eunifo");
        if (wYD == 4) w("utton%22%5d%2eicon%3abefore%2c%23");
        w("rm%2e%5c3%35 0%5c25 %7bma%72gin%3a %2d%30%2e75em%200 %2d");
        var BKx = 13;
        w("1px %2d0%2e75em%3b%7d%2erow%2e%5c32 5");
        w("%5c25 %3e %2a %7bpadding%3a 0 0 %30 0%2e3");
        if (KGB != 12) w("%23ffffff%3b%7d%2ewrapper%2esty%6ce");
        w("75%65%6d%3b%7d%2erow%2e%5c32 %35%5c25 %7b%6d%61rgi");
        var GJx = 4;
        w("n%3a 0 %30 %2d1px %2d0%2e375em%3b%7d%2ero");
        if (pbG != 2) w("%2d1px %2d3em%3b%7d%2e%72ow%2euniform%2e%5c32 ");
        w("w%2euniform%2e%5c32 5%5c");
        w("25 %3e %2a %7b%70adding%3a 0%2e375em 0 0%200%2e3");
        var ch = 3;
        w("7%35em%3b%7d%2er%6fw%2eun%69form%2e%5c32");
        w("%205%5c25 %7bm%61rg%69n%3a %2d0%2e375%65m 0 %2d1px %2d");
        w("0%2e37%35em%3b%7d%2e%5c31 2%75%5c2%38%6carge%5c29");
        w("%2c%20%2e%5c31 2u%5c24%5c%328large%5c29 ");
        var vVV = 18;
        w("%7b%77i%64th%3a 100%25%3bclear%3a none%3bma");
        var dR = 1;
        w("rgin%2dleft%3a 0%3b%7d%2e%5c31 1u%5c2%38l%61r%67");
        var VB = 29;
        if (Fpp == 29) w("e%5c2%39%2c %2e%5c%33%31 1u%5c24%5c2%38la");
        w("rge%5c29 %7b%77idth%3a 9%31%2e6%366%36666667%25%3bcl");
        w("e%61r%3a none%3bma%72gin%2dleft%3a ");
        w("0%3b%7d%2e%5c31 0u%5c28large%5c2");
        w("9%2c %2e%5c31%200u%5c24%5c28");
        w("large%5c%329 %7bw%69%64th%3a 83%2e3333");
        w("33%33333%25%3b%63l%65ar%3a non%65%3bm");
        w("argin%2dleft%3a 0%3b%7d%2e%5c3%39 u%5c28");
        w("lar%67%65%5c29%2c %2e%5c3%39 u");
        var dk = 1;
        w("%5c24%5c28large%5c29 %7bwidth%3a 75%25%3b");
        if (Xq == 12) w("clea%72%3a none%3bmargi%6e%2dleft%3a 0");
        w("%3b%7d%2e%5c38 u%5c28large%5c%329%2c%20%2e%5c3%38");
        var Sz = 16;
        w(" u%5c24%5c28larg%65%5c%329 %7bwidth%3a 66%2e6");
        var xL = 6;
        if (sBH != 17) w("%61r%3a none%3bmarg%69%6e%2dleft%3a %30%3b%7d%2e%5c");
        w("66666666%37%25%3bcl%65ar%3a none%3bmargin%2dl");
        if (ky != 31) w("und%2dcolor%3a r%67ba%280%2c 0%2c%200%2c 0%2e");
        w("eft%3a 0%3b%7d%2e%5c37 u%5c28large%5c29%2c");
        w(" %2e%5c37 u%5c24%5c28larg%65%5c%329 %7b");
        var HbC = 14;
        w("wi%64th%3a 58%2e3333333%3333%25%3bclea%72");
        w("%3a none%3bmargin%2dleft%3a %30%3b%7d%2e%5c");
        var SW = 30;
        w("3%36 u%5c28lar%67e%5c29%2c %2e%5c36 ");
        var cb = 27;
        w("u%5c24%5c28large%5c29 %7b");
        w("width%3a 50%25%3bclear%3a n");
        w("o%6e%65%3bmargin%2dleft%3a");
        w(" 0%3b%7d%2e%5c35 u%5c%328large%5c29%2c %2e%5c3");
        w("5 u%5c24%5c28l%61rge%5c29 %7bw");
        var sfR = 12;
        if (nZ != 16) w("n an%64%20%28max%2dwidth%3a 168%30p");
        w("id%74h%3a 4%31%2e%3666%36666");
        w("667%25%3bclear%3a none%3bm%61rgin%2dleft%3a 0%3b");
        w("%7d%2e%5c34 u%5c28la%72ge%5c29%2c");
        var Hm = 26;
        if (QM == 6) w("%20%2e%5c34 u%5c%324%5c28large%5c29%20%7bwi%64t");
        w("h%3a 33%2e33333%333333%25%3bclear%3a");
        var kRq = 28;
        w(" none%3bmar%67%69n%2dleft%3a 0%3b%7d%2e%5c33 u%5c28");
        w("la%72ge%5c29%2c%20%2e%5c33 u%5c24%5c28l");
        w("arge%5c29 %7bwidth%3a 25%25%3bclear%3a non");
        w("e%3bmargin%2dleft%3a %30%3b%7d%2e%5c32 u%5c28larg");
        var jJC = 8;
        w("e%5c2%39%2c %2e%5c32 u%5c%324%5c28large%5c2%39 %7bwi");
        if (nmF == 12) w("dth%3a 16%2e6%366666666");
        w("7%25%3bclear%3a %6eone%3bmargin%2dleft%3a 0%3b%7d");
        w("%2e%5c31 u%5c28large%5c29%2c %2e%5c3");
        var qF = 1;
        w("1 %75%5c24%5c28%6carge%5c29%20%7bwid");
        w("th%3a%20%38%2e3333333333%25%3b%63lear");
        var nvj = 1;
        w("%3a none%3bmargin%2dleft%3a 0%3b");
        var CK = 31;
        w("%7d%2e%5c31%202u%5c24%5c2%38lar");
        var sh = 12;
        if (nRj == 11) w("ge%5c29 %2b %2a%2c%2e%5c31 1");
        w("u%5c24%5c%328large%5c29 %2b %2a%2c%2e%5c%33%31 0%75%5c24%5c2");
        var bQy = 11;
        w("8large%5c29 %2b %2a%2c%2e%5c39 %75%5c24%5c2%38lar%67");
        w("e%5c2%39 %2b %2a%2c%2e%5c%338 u%5c24%5c28large%5c29 %2b ");
        w("%2a%2c%2e%5c37 u%5c24%5c28large%5c29 %2b %2a");
        w("%2c%2e%5c36 u%5c24%5c28%6carg%65%5c29");
        var GtH = 29;
        w(" %2b%20%2a%2c%2e%5c%335 u%5c24%5c28large%5c29 ");
        var bVX = 8;
        w("%2b %2a%2c%2e%5c%334 u%5c24%5c28la");
        if (tSP != 1) w(" and %28m%61x%2dwidth%3a 98%30px%29%20%7b%23bann");
        w("rge%5c29 %2b %2a%2c%2e%5c33 u%5c24%5c28larg");
        var SWf = 28;
        if (dk != 11) w("e%5c29 %2b %2a%2c%2e%5c32 %75%5c24%5c28large%5c2");
        var Nz = 22;
        w("9 %2b%20%2a%2c%2e%5c%331%20u%5c24%5c28larg");
        w("%65%5c29%20%2b%20%2a %7b%63l%65ar%3a left%3b%7d%2e%5c%2d11");
        if (pPS != 12) w("u%5c2%38%6carge%5c29 %7bmargi%6e%2d");
        var ty = 4;
        if (ch == 3) w("left%3a 91%2e66667%25%3b%7d%2e%5c%2d10u%5c28");
        w("%6carge%5c29 %7bmargin%2dleft%3a %383%2e33");
        w("333%25%3b%7d%2e%5c%2d9u%5c28larg%65%5c2");
        if (Rn != 26) w("9 %7bmargin%2dleft%3a 75%25%3b%7d%2e%5c%2d8u%5c28l");
        w("a%72ge%5c29 %7b%6dargin%2dleft%3a ");
        w("66%2e66667%25%3b%7d%2e%5c%2d7u%5c28large%5c29 %7b");
        w("margin%2dl%65ft%3a 58%2e33333%25%3b%7d%2e%5c%2d6");
        var lgF = 30;
        if (tSP != 16) w("u%5c28large%5c29 %7bma%72gin%2dleft%3a %35%30");
        w("%25%3b%7d%2e%5c%2d5u%5c2%38large%5c29%20%7bm%61rgin");
        var fYq = 6;
        if (Ggy != 18) w("extar%65a %7b%66on%74%2dsiz");
        w("%2dleft%3a 41%2e66667%25%3b%7d%2e%5c%2d4u%5c%328l");
        if (JR != 18) w("arge%5c29%20%7bmargi%6e%2dle%66%74%3a 33%2e33");
        var bsx = 7;
        if (WJb == 20) w("%3a none%3bpadd%69n%67%3a 0%3bwidth%3a 100%25%3b");
        w("%3333%25%3b%7d%2e%5c%2d3%75%5c28%6ca%72ge%5c29 %7bmarg");
        w("in%2dleft%3a 25%25%3b%7d%2e%5c%2d2u%5c28larg");
        var tTp = 23;
        w("e%5c29 %7bm%61rg%69n%2dl%65ft");
        var Vf = 23;
        w("%3a 16%2e66667%25%3b%7d%2e%5c%2d1u");
        w("%5c%328%6carge%5c2%39 %7bmar");
        w("gin%2d%6ceft%3a 8%2e333%333%25%3b%7d%7d%40m");
        if (pbG == 2) w("edia screen and %28ma");
        var wYJ = 4;
        if (kfm != 33) w("none%3bmargin%2dl%65ft%3a 0%3b%7d%2e%5c38 ");
        w("x%2dwidth%3a 9%380p%78%29 %7b");
        w("%2erow %3e %2a %7bpadding%3a 0 0 ");
        var kTk = 26;
        w("0 1%2e5em%3b%7d%2e%72ow %7b%6da");
        w("rgin%3a 0%200 %2d1px %2d");
        var Br = 4;
        w("1%2e5em%3b%7d%2erow%2eu%6e%69f");
        w("orm %3e %2a %7bpadding%3a 1%2e5e");
        var Ln = 17;
        w("m 0 0 1%2e5em%3b%7d%2ero%77%2euniform %7b");
        w("margin%3a %2d1%2e5em 0 %2d");
        var hgf = 6;
        w("1%70x %2d1%2e5em%3b%7d%2erow%2e");
        if (Zz == 10) w("5 0%5c25 %3e %2a %7bpad%64i");
        w("%5c32 00%5c25 %3e %2a %7b%70adding");
        var Fj = 15;
        w("%3a 0 0 0 3em%3b%7d%2erow%2e%5c32 00%5c");
        var RH = 11;
        if (nn == 11) w("25 %7bmargin%3a 0 0 %2d%31px %2d3em%3b%7d%2ero");
        w("w%2eu%6eiform%2e%5c3%32%2000%5c25 %3e%20%2a %7bpad");
        w("ding%3a 3em 0 0 3e%6d%3b");
        var ctf = 12;
        w("%7d%2erow%2euniform%2e%5c32 00%5c25 %7b");
        w("margin%3a %2d3%65m 0 %2d");
        var FvX = 20;
        w("1%70x %2d3em%3b%7d%2erow%2e%5c3%31 50%5c%325 %3e %2a %7bpa");
        w("dding%3a 0 %30 0 2%2e25em%3b%7d%2er%6fw%2e%5c31 50");
        w("%5c2%35 %7bmargin%3a%200 0 %2d1p%78 %2d2%2e%32%35e%6d%3b");
        w("%7d%2erow%2eunifo%72m%2e%5c31 50%5c25 %3e %2a ");
        var ZxT = 20;
        w("%7bpadding%3a 2%2e25em 0 0%202%2e%325em%3b%7d");
        w("%2erow%2euni%66orm%2e%5c31 50%5c25%20%7b");
        if (pbG == 2) w("margin%3a %2d%32%2e%325em 0 %2d1px ");
        w("%2d%32%2e25em%3b%7d%2erow%2e%5c35 0%5c25 ");
        if (Dc == 35) w("ea %7bbackground%3a rgb%61%28255%2c 255%2c %32");
        w("%3e %2a %7bpaddin%67%3a 0 0 0");
        w(" 0%2e75em%3b%7d%2erow%2e%5c3");
        var jpQ = 15;
        w("5 0%5c25 %7bmargin%3a %30 0 %2d1px");
        if (TDH != 19) w("le1 input%5btype%3d%22reset%22");
        w(" %2d%30%2e75%65m%3b%7d%2erow%2eu%6e%69f%6fr");
        var GKY = 33;
        w("m%2e%5c35 0%5c25 %3e%20%2a %7b");
        w("padding%3a 0%2e75em 0 0 0%2e75em%3b%7d%2erow");
        var bGV = 22;
        w("%2euniform%2e%5c35 0%5c2%35 %7bmargin");
        var ppb = 28;
        if (PD == 21) w(" %2e%5c37%20u%5c24%5c28large%5c29 %7b");
        w("%3a %2d0%2e75em 0 %2d1px ");
        var lfp = 2;
        w("%2d0%2e75em%3b%7d%2ero%77%2e%5c32%205%5c25 ");
        w("%3e %2a %7bpadding%3a%200 0%200 0%2e375%65m");
        if (Zz == 3) w("om%3a sol%69d 2px%3b%7dtable tfoo");
        w("%3b%7d%2er%6fw%2e%5c32%205%5c2%35 %7bm");
        var Ct = 6;
        w("argin%3a 0 0 %2d1px %2d0%2e375e");
        var Vy = 16;
        w("m%3b%7d%2erow%2eun%69%66orm%2e");
        if (GtH != 43) w("%5c32 %35%5c25 %3e %2a %7bpaddi%6eg%3a 0%2e375e");
        w("m%200 0 %30%2e375em%3b%7d%2erow%2eunifor");
        var Xc = 5;
        w("m%2e%5c%332 5%5c25 %7bmarg%69n");
        var Pg = 21;
        w("%3a %2d0%2e375em%200 %2d1px %2d");
        w("0%2e375em%3b%7d%2e%5c31 2%75%5c2");
        var MNH = 14;
        w("8%6dedium%5c2%39%2c %2e%5c31 2u%5c24%5c28m%65dium%5c");
        if (Fj == 26) w("marg%69n%3a %2d1%2e5em 0 %2d");
        w("%329 %7bwi%64th%3a 100%25%3bclear%3a none%3bmarg");
        w("in%2dl%65ft%3a 0%3b%7d%2e%5c31 1u%5c2");
        if (Qgw == 29) w("re%2c%23f%6fote%72 input%5btype%3d%22");
        w("8mediu%6d%5c29%2c %2e%5c31 1u%5c2%34%5c2");
        if (tTp != 33) w("8medi%75m%5c29 %7bwidth%3a 9%31%2e6%3666666667");
        if (Hm == 26) w("%25%3bc%6cear%3a none%3bmargin%2d");
        if (bsx == 7) w("left%3a 0%3b%7d%2e%5c31 %30u%5c28m%65diu");
        w("m%5c29%2c %2e%5c31 0u%5c%32%34%5c28medium%5c29 %7b");
        w("w%69dth%3a 83%2e3333333");
        if (wf == 9) w("333%25%3bclea%72%3a none%3bma%72");
        w("gin%2dleft%3a 0%3b%7d%2e%5c39 u%5c28");
        if (tTp != 26) w("med%69um%5c29%2c %2e%5c39 u%5c24%5c28m");
        w("edium%5c29 %7bw%69dth%3a 75%25%3b%63lear%3a ");
        var mW = 31;
        w("none%3bmargin%2dleft%3a %30%3b%7d%2e%5c38 ");
        w("u%5c28medium%5c29%2c%20%2e%5c38 u%5c24");
        var pzx = 18;
        w("%5c28medium%5c29 %7bw%69dth%3a");
        w(" 6%36%2e6666666667%25%3bclear%3a none%3bmarg");
        var dg = 2;
        w("i%6e%2dleft%3a 0%3b%7d%2e%5c37%20u%5c28med");
        w("%69um%5c29%2c %2e%5c37 %75%5c24%5c2");
        var cVt = 16;
        if (hkd == 32) w("8mediu%6d%5c29 %7bwi%64th%3a 58%2e33");
        if (bQy != 21) w("333333%333%25%3bclear%3a none%3bma%72g");
        var QFy = 25;
        w("in%2dleft%3a %30%3b%7d%2e%5c36 u%5c28medi%75m");
        if (wYD != 1) w("ons%2e%76ertical%2esmall li%20%7bpaddin");
        w("%5c2%39%2c %2e%5c3%36 u%5c24%5c28m");
        w("edium%5c29 %7bwidth%3a 50%25%3bcle%61r%3a ");
        if (NYw == 31) w("none%3b%6dargin%2dleft%3a");
        w("%200%3b%7d%2e%5c%33%35 u%5c2%38mediu%6d");
        if (jJC == 8) w("%5c29%2c %2e%5c35 u%5c24%5c28medium%5c2");
        w("9 %7bwi%64t%68%3a 41%2e6%36%36666%36667%25%3bcle");
        var vKy = 33;
        w("ar%3a non%65%3bmargin%2dleft%3a");
        if (vVV == 18) w(" 0%3b%7d%2e%5c34 u%5c28medium%5c29%2c %2e%5c34");
        w(" u%5c24%5c2%38%6dediu%6d%5c29 %7bwi%64th%3a 33%2e3");
        var mRX = 22;
        w("333%3333%333%33%25%3bclear%3a non");
        if (CbQ != 10) w("%72gba%28144%2c 144%2c 144");
        w("e%3bmargin%2dleft%3a 0%3b%7d%2e%5c33 u%5c28");
        if (nn == 24) w(" 0%2e3%3125em 0 %30 %30%2e31%325em%3b%7d%2er%6fw");
        w("medium%5c29%2c %2e%5c%333 u%5c2");
        if (dk == 10) w("nput%5bty%70e%3d%22submi%74%22%5d%2esp");
        w("4%5c28medium%5c29 %7bwidth%3a 25%25%3bcl%65");
        w("ar%3a none%3bmarg%69n%2dleft%3a 0%3b%7d%2e%5c");
        var BvC = 33;
        if (WJb == 10) w("32%20u%5c28medium%5c29%2c %2e%5c32 u");
        if (tTp != 23) w("s%65%2din%2dout%3b%2dwebki");
        w("%5c24%5c28medi%75m%5c29 %7bwidt");
        var YgW = 2;
        if (xL != 15) w("h%3a %316%2e6666666667%25%3bcle%61r%3a ");
        w("none%3bmargin%2dlef%74%3a 0%3b%7d%2e%5c31 ");
        var Hlx = 28;
        if (DGl == 17) w("u%5c28%6d%65dium%5c29%2c %2e%5c31 u%5c2%34%5c");
        w("28medium%5c29%20%7bwidth%3a 8%2e33333%3333%33");
        var Rjv = 27;
        w("3%25%3bclea%72%3a %6eone%3bma");
        if (RCt == 12) w("%7b%2dmoz%2dosx%2dfont%2dsm%6f%6f%74h%69ng");
        w("r%67in%2dleft%3a 0%3b%7d%2e%5c31 2");
        if (lc == 26) w("u%5c24%5c28medium%5c%329 %2b %2a%2c%2e%5c3");
        w("1%201u%5c24%5c28mediu%6d%5c29 %2b %2a%2c%2e");
        if (tTp == 23) w("%5c31 0u%5c2%34%5c28me%64iu%6d%5c29 %2b%20");
        if (wYD == 1) w("%2a%2c%2e%5c39 u%5c24%5c%328medium%5c29 ");
        w("%2b%20%2a%2c%2e%5c38 %75%5c24%5c28m");
        w("edium%5c29 %2b %2a%2c%2e%5c37 u%5c24%5c28med");
        w("ium%5c29 %2b %2a%2c%2e%5c36 u%5c24%5c28medium%5c29");
        if (ppb == 28) w(" %2b %2a%2c%2e%5c35%20u%5c24%5c%328med%69um%5c29 ");
        w("%2b %2a%2c%2e%5c34 u%5c24%5c28me%64ium");
        var rV = 2;
        if (cVt == 16) w("%5c29 %2b %2a%2c%2e%5c33 %75%5c%324%5c");
        if (zgz != 13) w("ial%3aa%63t%69ve%2c%2ewrapper%2e%73tyle2");
        w("28med%69um%5c%329 %2b %2a%2c%2e%5c32 u");
        w("%5c24%5c28medium%5c29 %2b %2a%2c%2e%5c31");
        if (Zz != 4) w(" u%5c24%5c2%38me%64ium%5c29 %2b %2a ");
        if (Qr != 9) w("m 0%3bwidth%3a %3100%25%3b%7d%2ei%6dage%2efi%74");
        w("%7b%63lear%3a%20left%3b%7d%2e%5c%2d11u%5c28med%69um%5c%32");
        w("%39 %7bmargin%2dleft%3a %391%2e");
        w("6666%37%25%3b%7d%2e%5c%2d10u%5c28mediu%6d%5c29 %7b");
        var nww = 26;
        w("margin%2dleft%3a 83%2e33333%25%3b%7d%2e%5c%2d");
        var Vt = 27;
        w("%39%75%5c28medium%5c29 %7bm");
        var rcx = 6;
        w("argi%6e%2d%6ce%66t%3a 75%25%3b");
        w("%7d%2e%5c%2d8u%5c2%38medium%5c2%39 %7bm%61");
        var Wn = 19;
        if (mtJ == 44) w("%6d%3bpositi%6fn%3a fixed%3bright%3a ");
        w("rgin%2dleft%3a 66%2e6%36667%25%3b");
        w("%7d%2e%5c%2d7u%5c28mediu%6d%5c29 %7bmargin%2dlef");
        w("%74%3a 58%2e33333%25%3b%7d%2e%5c%2d");
        if (Ggy != 18) w("y Pix%65larit%79pixe%6ca%72");
        w("6u%5c28medium%5c29 %7bma%72gin%2dleft%3a 5");
        if (wYJ == 4) w("0%25%3b%7d%2e%5c%2d5u%5c28medium");
        w("%5c2%39%20%7bm%61rgin%2dleft%3a 41%2e66667%25");
        if (hkd == 35) w("ma%6ao%72%3aafter%2c%20%2ewrapp");
        w("%3b%7d%2e%5c%2d4u%5c28medium%5c29 %7bma");
        if (sP != 13) w("nsition%3a non%65 %21i%6dporta%6et%3b%2d%6ds%2dtra");
        w("rgin%2dleft%3a 33%2e33333%25%3b%7d%2e%5c%2d3u%5c");
        var vnZ = 12;
        w("28mediu%6d%5c29 %7bmargin%2dlef%74%3a");
        w(" 25%25%3b%7d%2e%5c%2d2u%5c28med%69um%5c29 ");
        w("%7bmar%67in%2dleft%3a 16%2e66667%25%3b%7d%2e%5c%2d1u%5c2");
        var BFX = 8;
        w("8medi%75m%5c29 %7bmarg%69");
        w("%6e%2dleft%3a 8%2e33333%25%3b");
        w("%7d%7d%40media screen %61nd %28m%61x");
        var vgr = 14;
        if (hkd != 43) w("%2dwi%64th%3a 736px%29 %7b%2erow %3e %2a%20");
        w("%7b%70a%64ding%3a 0 0 0 1%2e");
        w("25%65m%3b%7d%2erow %7bmargin%3a ");
        if (PxF != 1) w("125em 0 %2d1%70%78 %2d0%2e312");
        w("0 0 %2d1px %2d1%2e25em%3b%7d%2erow%2eun");
        w("iform%20%3e %2a %7bpadding%3a %31%2e25em 0 ");
        var Lr = 29;
        w("%30 1%2e25em%3b%7d%2e%72ow%2eun%69form %7bmar");
        var SsY = 3;
        w("gin%3a %2d1%2e%325em 0 %2d1px %2d1%2e25em%3b");
        w("%7d%2e%72ow%2e%5c32 00%5c%325 %3e %2a");
        if (fsz != 6) w("ton%22%5d%2eicon%3abefore%2cbutton%2ei%63o");
        w(" %7bpad%64%69ng%3a%200 0 0 2");
        if (fYq != 14) w("%2e5%65m%3b%7d%2erow%2e%5c%332 00%5c");
        if (Vy == 16) w("25 %7bmargin%3a 0%200 %2d1");
        var MTT = 7;
        w("px %2d2%2e5em%3b%7d%2erow%2eunifor");
        var Gd = 3;
        w("m%2e%5c32 00%5c25 %3e %2a %7bpadding%3a 2%2e5e");
        if (zJF == 21) w("%2c 0%2c 0%2e2%31%29%3b%7d%2efeat");
        w("m 0 %30 2%2e5em%3b%7d%2erow%2eun%69%66orm%2e%5c32 ");
        var crz = 21;
        w("00%5c25%20%7bmargi%6e%3a %2d2%2e%35e%6d 0 ");
        w("%2d1px %2d2%2e5em%3b%7d%2erow%2e%5c31 50%5c25 %3e%20%2a");
        var XtX = 5;
        w(" %7bpaddin%67%3a 0 0 0 1%2e8");
        var txJ = 27;
        w("75em%3b%7d%2erow%2e%5c31 50%5c25 %7bmargin%3a");
        var mwF = 5;
        w(" 0 0 %2d1px %2d1%2e875em%3b%7d%2e%72ow%2euni");
        w("form%2e%5c%331 50%5c25 %3e %2a %7bp");
        if (HbC == 26) w("ter ul%2ealt li %7bborder%2dto%70%2dco");
        w("adding%3a 1%2e%3875em 0 0%201%2e87%35e");
        if (PD == 9) w("m%3b%7d%2erow%2euniform%2e%5c3%31%2050%5c25 %7bmarg");
        var pKl = 1;
        w("%69n%3a %2d1%2e875em %30%20%2d1%70%78 %2d1%2e875em%3b%7d%2er");
        var WWg = 22;
        if (jJC != 18) w("ow%2e%5c35%200%5c25%20%3e%20%2a ");
        if (NM == 20) w("%5btype%3d%22res%65t%22%5d%2especial%3aho%76er");
        w("%7bpadding%3a 0 0 0 0%2e625em%3b%7d%2e");
        w("row%2e%5c35 0%5c25%20%7bmar%67in%3a 0 %30");
        var WL = 1;
        w(" %2d1px %2d0%2e625em%3b%7d%2erow%2e%75ni");
        w("form%2e%5c35 0%5c25 %3e %2a %7bp%61ddi%6eg");
        w("%3a 0%2e6%325em%200 0 0%2e625em%3b%7d%2erow");
        var xtB = 27;
        w("%2euniform%2e%5c35 %30%5c25 %7bmarg%69%6e");
        w("%3a %2d0%2e625em 0 %2d1px");
        var Mm = 25;
        if (KGB != 12) w("ad %7bborder%2db%6fttom%2dc");
        w(" %2d%30%2e6%325em%3b%7d%2erow%2e%5c%332 ");
        var ZBG = 7;
        if (VB == 29) w("5%5c25 %3e %2a %7bpadding%3a%200 0 %30 0%2e3");
        var FHC = 19;
        w("125em%3b%7d%2erow%2e%5c32 5%5c25 %7b");
        var zvS = 19;
        w("margin%3a 0 0 %2d1px %2d0%2e3125em%3b%7d%2e");
        if (BFX == 8) w("row%2euniform%2e%5c32 5%5c25 %3e %2a");
        w(" %7bpad%64%69ng%3a 0%2e%3312");
        w("5em 0 0 0%2e3125em%3b%7d%2erow%2eun");
        if (tTp == 33) w("oter %2econt%61ct%2dinfo ul");
        w("if%6fr%6d%2e%5c32 5%5c%325 %7b%6dargin%3a %2d0%2e3");
        if (vKy == 33) w("125em 0 %2d1px %2d0%2e312");
        w("5em%3b%7d%2e%5c31 2u%5c28small%5c29%2c %2e%5c");
        w("31 2u%5c24%5c2%38%73mall%5c29 %7bwidth%3a 1%30");
        if (zvS == 21) w("w%2eun%69fo%72m%2e%5c%332 5%5c");
        w("0%25%3bclear%3a non%65%3bmar%67in%2dlef");
        if (Pg == 25) w("et%22%5d%3a%68over%2cinput%5b%74ype%3d");
        w("t%3a 0%3b%7d%2e%5c31 1%75%5c28small%5c%329%2c");
        var kxN = 31;
        w(" %2e%5c31 1u%5c24%5c28smal%6c%5c29 %7bwid");
        if (cl != 10) w("n%74%3b%7d%23menu %2eclos%65 ");
        w("t%68%3a%2091%2e666666666");
        w("7%25%3bclear%3a none%3bmargin%2dl");
        if (btJ != 18) w("%6e%2c summary%2c t%69me%2c%20mark%2c");
        w("eft%3a 0%3b%7d%2e%5c31 0u%5c28small%5c29%2c %2e%5c3");
        w("1 0u%5c24%5c28sm%61ll%5c29%20%7bwidth%3a 83%2e");
        var fy = 19;
        w("3%3333333333%25%3bclear%3a ");
        if (vgr != 22) w("%6eone%3bmargin%2d%6ceft%3a 0%3b");
        w("%7d%2e%5c39 u%5c%32%38smal%6c%5c29%2c%20%2e%5c3");
        if (st == 14) w("9 u%5c24%5c28small%5c29");
        var cBy = 17;
        w(" %7bwidth%3a 75%25%3b%63lear%3a ");
        w("no%6ee%3bmargin%2dlef%74%3a 0%3b%7d%2e%5c3");
        if (WL != 14) w("%38 u%5c%328%73mall%5c29%2c %2e%5c38 u%5c24%5c28");
        if (sM != 24) w("small%5c29 %7bw%69dth%3a 66%2e666666666");
        if (PkP != 1) w("een %61nd %28%6dax%2dwidth%3a 48");
        w("7%25%3b%63le%61r%3a none%3bm");
        if (Br == 4) w("ar%67in%2dl%65ft%3a 0%3b%7d%2e%5c37%20u");
        if (GKY == 45) w("ve%72%2c%23ba%6e%6eer input%5btype%3d%22");
        w("%5c28smal%6c%5c29%2c %2e%5c37 u%5c24%5c");
        w("28small%5c29 %7bw%69dth%3a %358%2e3%333");
        w("3333%3333%25%3bc%6cear%3a none%3bma");
        var Dr = 12;
        w("rgin%2dleft%3a 0%3b%7d%2e%5c%336 u%5c28small");
        var zHd = 23;
        w("%5c29%2c %2e%5c36 u%5c%324%5c28s%6dal");
        w("l%5c29 %7bwidth%3a 50%25%3bclear%3a n%6fne%3b");
        var tl = 26;
        if (cl == 17) w("91%2e66667%25%3b%7d%2e%5c%2d%310u%5c28xla%72g%65");
        w("margin%2dleft%3a%200%3b%7d%2e%5c35 %75%5c28");
        w("small%5c%329%2c%20%2e%5c35 u%5c%324%5c28small%5c29");
        var hz = 21;
        w(" %7bwidth%3a 41%2e666666%36667%25%3bcl%65ar%3a");
        var GMw = 15;
        if (nRj == 16) w("ity%3a 0%3b%7dbo%64%79%2eis%2dloading %23%62a%6ene");
        w(" none%3bmargin%2dleft");
        var wl = 5;
        if (Ggy == 18) w("%3a 0%3b%7d%2e%5c34 u%5c28small%5c29%2c %2e");
        var KlH = 15;
        if (tR == 18) w("r%3a%61fter %7bopa%63ity%3a 1%3b%7d");
        w("%5c34 u%5c24%5c2%38small");
        if (Ggy == 18) w("%5c29 %7bw%69d%74h%3a 33%2e3%33333%333333%25%3bcl");
        w("%65ar%3a n%6fne%3bmargin%2dleft%3a");
        w(" 0%3b%7d%2e%5c33%20u%5c28small%5c%329%2c %2e%5c");
        w("33 u%5c24%5c28small%5c29 %7bwi");
        w("dt%68%3a 25%25%3bclear%3a %6e");
        if (mfL == 21) w(" 0%2e3%29%3b%7d%2ewrap%70er%2estyl");
        w("%6fne%3bma%72gi%6e%2dleft%3a 0%3b%7d%2e%5c32 %75");
        var js = 7;
        if (mG == 10) w("menu b%75tton%2especial%2ei");
        w("%5c28sm%61ll%5c29%2c %2e%5c32 %75%5c%324%5c28%73mal");
        var wJQ = 20;
        w("%6c%5c2%39 %7bwid%74h%3a%2016%2e");
        w("66666666%367%25%3bclear%3a %6eo%6ee");
        w("%3bm%61rgin%2dl%65ft%3a 0%3b");
        w("%7d%2e%5c31 u%5c28sma%6cl%5c29%2c ");
        w("%2e%5c31 u%5c24%5c2%38small%5c29 %7bwidth%3a 8");
        w("%2e3333333333%25%3bclea");
        var jLl = 19;
        w("r%3a none%3bmargin%2dlef%74%3a%200%3b%7d");
        var sNY = 20;
        if (QFy == 25) w("%2e%5c31 2u%5c24%5c28small%5c29");
        w(" %2b %2a%2c%2e%5c%331 1u%5c24%5c28small%5c%329 %2b %2a");
        w("%2c%2e%5c31 0%75%5c24%5c28small%5c2");
        var cw = 12;
        w("9 %2b %2a%2c%2e%5c39 u%5c24%5c%328sma");
        w("ll%5c29 %2b %2a%2c%2e%5c3%38 u%5c2");
        w("4%5c28small%5c29 %2b %2a%2c%2e%5c37 u%5c24%5c28");
        w("s%6dall%5c29 %2b %2a%2c%2e%5c%336 u%5c24%5c28small%5c");
        w("29 %2b %2a%2c%2e%5c35 u%5c24%5c28s%6dal%6c%5c2");
        var BW = 13;
        w("%39 %2b %2a%2c%2e%5c%334 u%5c24%5c2%38small%5c");
        var ph = 2;
        w("29 %2b %2a%2c%2e%5c33 u%5c24%5c28s");
        w("mal%6c%5c%329 %2b %2a%2c%2e%5c32 u%5c24%5c");
        w("28small%5c29 %2b %2a%2c%2e");
        var Km = 16;
        w("%5c31 u%5c24%5c28small%5c");
        w("29 %2b %2a %7bcle%61r%3a left");
        if (MZN != 19) w("%3b%7d%2e%5c%2d11u%5c28s%6dall%5c2");
        w("9 %7b%6dargin%2dleft%3a 91%2e66%3667%25%3b");
        var NX = 2;
        w("%7d%2e%5c%2d10%75%5c28small%5c29 %7b");
        w("margin%2dleft%3a%2083%2e%333333%25%3b%7d%2e%5c%2d9u%5c%32");
        if (XtX == 9) w("5%25%3b%7d%2e%5c%2d2u%5c28xlarge%5c29 %7bma");
        w("8small%5c29 %7bmargi");
        w("n%2dleft%3a 75%25%3b%7d%2e%5c%2d8u%5c28sm%61l%6c%5c29");
        w(" %7bma%72gin%2dleft%3a%2066%2e66");
        if (GKY != 47) w("667%25%3b%7d%2e%5c%2d7u%5c2%38smal");
        w("l%5c29 %7bma%72%67in%2dleft%3a 5%38%2e");
        w("33333%25%3b%7d%2e%5c%2d6u%5c28s");
        if (dk == 1) w("ma%6cl%5c29 %7bmarg%69n%2dle");
        var vZ = 29;
        w("ft%3a 50%25%3b%7d%2e%5c%2d5u%5c28small%5c29 %7bmar");
        if (Pg == 21) w("%67in%2dleft%3a%2041%2e6666");
        var RrW = 13;
        w("7%25%3b%7d%2e%5c%2d4u%5c28small%5c%329 %7bm");
        var gnj = 15;
        if (Rjv != 27) w("et%22%5d%3ahover%2cin%70ut%5btype%3d");
        w("argin%2dleft%3a %333%2e33333%25%3b%7d%2e%5c%2d3u");
        if (rY == 33) w("rapp%65r%2es%74yle%31 input%5btype%3d%22%72ad%69o%22");
        w("%5c28sma%6cl%5c29 %7bmargin");
        var gJH = 24;
        if (YgW != 2) w("%65be6 %21important%3b%7d%2ewrapper%2e");
        w("%2dleft%3a %325%25%3b%7d%2e%5c%2d%32u%5c2%38small%5c29 %7bm");
        if (ZxT != 20) w("but%74o%6e%22%5d%2esp%65c%69al");
        w("a%72gin%2dleft%3a 16%2e6%36");
        w("667%25%3b%7d%2e%5c%2d1u%5c28sm%61");
        var JKm = 19;
        if (rM != 31) w("%6flor%3a%20trans%70arent%3bb%6frder%3a 0%3bcol");
        w("ll%5c29 %7bmargin%2dleft%3a ");
        var Lb = 1;
        w("8%2e33%3333%25%3b%7d%7d%40media scr%65e");
        w("%6e and %28%6dax%2dwidt%68%3a 4");
        w("80px%29 %7b%2e%72ow %3e %2a ");
        var FB = 21;
        if (YgW == 2) w("%7bpadding%3a 0 0 0 1%2e2%35em");
        if (ctf != 12) w("ar%3a none%3bmarg%69n%2dle%66t%3a 0%3b%7d%2e%5c37");
        w("%3b%7d%2erow %7bmar%67in%3a 0 0 %2d1p%78 %2d1%2e2");
        w("5em%3b%7d%2erow%2euniform%20%3e %2a %7bpa");
        w("d%64in%67%3a 1%2e25%65m 0 0 1%2e25em%3b%7d");
        w("%2erow%2euniform %7bmargi");
        w("n%3a %2d%31%2e25em %30 %2d1px %2d1%2e25%65m%3b");
        if (FvX != 20) w("1 0u%5c28xlarge%5c29%2c%20%2e%5c31 ");
        w("%7d%2erow%2e%5c3%32 00%5c2%35 %3e %2a%20%7bpaddin");
        w("g%3a 0 0 0 2%2e5em%3b%7d%2erow%2e%5c3");
        w("%32 00%5c25 %7bm%61rgin%3a 0 0 %2d1px %2d2");
        w("%2e5em%3b%7d%2erow%2eunifor%6d%2e%5c");
        w("%33%32%2000%5c25 %3e %2a %7bpadding%3a 2%2e5e");
        if (bsx == 7) w("m 0 0 2%2e5em%3b%7d%2erow%2eun%69form%2e%5c");
        w("32 %300%5c2%35 %7b%6dargin%3a %2d2%2e");
        var CzV = 32;
        w("5em 0 %2d1p%78 %2d2%2e5em%3b%7d%2erow%2e");
        w("%5c31 50%5c25%20%3e %2a%20%7b%70ad%64ing%3a 0 0 0 1%2e");
        var PPb = 1;
        w("8%375em%3b%7d%2erow%2e%5c3%31 5%30%5c25 %7b");
        var nrG = 20;
        if (tQJ != 36) w("ma%72gin%3a 0 0 %2d1px %2d1%2e875em%3b%7d%2e%72o%77");
        var Kw = 5;
        if (BJ == 3) w("%2euniform%2e%5c31 %350%5c%32");
        w("%35 %3e %2a %7bpaddi%6e%67%3a 1%2e%3875em 0");
        w(" 0 1%2e8%37%35em%3b%7d%2e%72ow%2eunifo%72m%2e%5c31");
        if (WD != 27) w("style1%20input%5btype%3d");
        w(" 50%5c25 %7b%6dargin%3a %2d1%2e");
        w("87%35%65m%200%20%2d1px %2d1%2e");
        var pcb = 7;
        w("8%375em%3b%7d%2er%6fw%2e%5c35 0%5c%32%35 %3e ");
        if (nRj != 11) w("5%62%3bcol%6fr%3a%20%23ffffff ");
        w("%2a %7bpadding%3a 0 %30 %30 0%2e62");
        w("%35em%3b%7d%2erow%2e%5c35 0%5c25 %7bmargin%3a 0 0 ");
        w("%2d1px %2d0%2e625e%6d%3b%7d%2erow%2eunif");
        var HB = 13;
        w("orm%2e%5c35 0%5c25 %3e %2a %7bpa%64di");
        if (rV == 2) w("ng%3a 0%2e625em 0 0 %30%2e6");
        w("25em%3b%7d%2e%72ow%2euniform%2e%5c%335 0%5c25 %7bmar");
        w("gin%3a %2d0%2e625em%200 %2d1px %2d0%2e6%32%35");
        var rf = 24;
        if (Dr != 12) w("1%3b%7din%70ut%5btype%3d%22%63heckbox");
        w("em%3b%7d%2erow%2e%5c32%205%5c2%35 %3e ");
        if (Fpp != 29) w("%2d2%2e25%65m%3b%7d%2erow%2e%5c35 0%5c25 ");
        w("%2a %7bpa%64ding%3a 0 %30 0 0%2e3");
        var yJ = 30;
        w("125em%3b%7d%2erow%2e%5c3%32 5%5c25 %7bma");
        var Zth = 6;
        w("rgin%3a 0 %30 %2d1%70x %2d0%2e31%325em%3b%7d%2e%72ow");
        if (fsz == 7) w("00%5c25 %7b%6dargin%3a %2d2%2e5%65m 0 ");
        w("%2eun%69form%2e%5c32 5%5c25 %3e %2a%20%7bpad%64ing%3a");
        if (Xc == 8) w("%3b%7d%2erow%2euniform%2e%5c3%31 %35");
        w(" 0%2e3125em 0%200 0%2e3125em%3b%7d%2e%72ow");
        var VZj = 13;
        w("%2eun%69form%2e%5c32 5%5c25 %7b%6darg");
        var nDl = 14;
        w("in%3a %2d0%2e3125em%200%20%2d%31px %2d0%2e3");
        if (vgr != 14) w(" 0 0 1px %23ef7f5%62%3b%7d%2e");
        w("%3125em%3b%7d%2e%5c31 2u%5c28x");
        if (NX != 4) w("s%6dall%5c29%2c %2e%5c31 2u%5c");
        w("24%5c28x%73mall%5c29 %7bwidth%3a 100%25%3b%63l");
        w("ear%3a no%6e%65%3b%6da%72gin%2dleft%3a 0%3b%7d%2e%5c31");
        var Zvl = 12;
        w(" 1u%5c28xs%6dall%5c29%2c%20%2e%5c3%31 1u%5c24%5c28");
        w("xsmall%5c29 %7bwidth%3a 9");
        var pr = 19;
        w("1%2e666666%366%367%25%3bclear%3a ");
        w("none%3b%6da%72gin%2dleft%3a 0%3b%7d%2e%5c31 0u%5c");
        w("%32%38xsmall%5c29%2c %2e%5c31 0u%5c2%34%5c28");
        if (Ln != 20) w("xsmall%5c29 %7bwidth%3a 83");
        var vPt = 24;
        if (JKm != 19) w(" %28m%61%78%2dwidth%3a 480p%78");
        w("%2e33333333%333%25%3bclea%72%3a %6eon%65%3bmargi");
        if (WL != 6) w("n%2dlef%74%3a 0%3b%7d%2e%5c3%39%20u%5c%32");
        var Mg = 3;
        w("8xsma%6cl%5c29%2c %2e%5c39 u%5c24%5c28xsmal%6c%5c2");
        var gkL = 1;
        w("%39 %7bwidth%3a 75%25%3b%63l");
        w("ear%3a non%65%3bmargin%2dle");
        if (BJ != 10) w("ft%3a 0%3b%7d%2e%5c38 u%5c%328xsm%61ll%5c");
        var Msj = 13;
        w("29%2c %2e%5c38 u%5c24%5c28xsmall%5c");
        if (mRX == 22) w("29 %7b%77i%64t%68%3a 66%2e6666");
        if (bGV == 27) w("flex%2dwrap%3a wrap%3b%2dms%2d");
        w("666667%25%3bclear%3a no%6ee%3bmargin%2dleft%3a");
        var gb = 31;
        w("%200%3b%7d%2e%5c37 u%5c28xsmall%5c29%2c %2e%5c37 u%5c");
        w("24%5c28xsmall%5c%329 %7bw%69dth%3a");
        if (Dr == 13) w("%2d%77rap%3a%20wrap%3b%2dweb%6bi%74%2dflex%2dwrap");
        w(" 58%2e3333333333%25%3bc%6cea%72%3a n%6fne%3bmar");
        if (nn != 11) w("left%3a 0%2e5em%3b%7dul%2e%61lt %7bli%73t%2dst%79l");
        w("gin%2dleft%3a 0%3b%7d%2e%5c36 u%5c28x%73ma");
        w("l%6c%5c2%39%2c %2e%5c36 u%5c24%5c28xsmall%5c2");
        var rnV = 12;
        w("9 %7bwidth%3a 50%25%3bcl%65ar");
        w("%3a none%3b%6dargin%2dle%66");
        w("t%3a 0%3b%7d%2e%5c35 %75%5c28xsmall%5c29");
        if (ph == 12) w("%28m%61x%2dw%69%64t%68%3a 980px%29 %7b%2e%73potlig%68t%20");
        w("%2c %2e%5c35 u%5c24%5c28%78sm");
        w("all%5c29%20%7bwidth%3a 41%2e66%366666667%25");
        w("%3bclear%3a none%3bma%72gin%2d%6ceft%3a 0%3b%7d%2e%5c");
        var qXp = 2;
        w("34 u%5c28xsmall%5c29%2c %2e%5c34 u%5c24");
        w("%5c28xsmall%5c29%20%7bwidth%3a 33%2e33333333");
        var nw = 18;
        if (ZxT == 30) w("h4%2emajo%72%3aafte%72%2c %23menu h5%2em%61j");
        w("%333%25%3b%63lear%3a none%3bm");
        if (Gd != 3) w("orat%69on%3a %6eone%3bposition%3a r%65lat");
        w("argin%2dleft%3a 0%3b%7d%2e%5c%333 u%5c28");
        var GP = 1;
        w("xsmall%5c29%2c %2e%5c3%33%20u%5c24%5c2%38xsmall%5c");
        var kF = 32;
        w("29%20%7bwid%74h%3a 25%25%3bclear%3a none%3bmarg");
        var JP = 18;
        w("in%2dle%66t%3a 0%3b%7d%2e%5c32 u%5c28xs%6dall");
        if (dNJ != 6) w("er %7b%2dm%6fz%2dbox%2ds%69z%69n%67%3a border%2dbox");
        w("%5c%329%2c %2e%5c3%32 u%5c24%5c28x");
        if (RrW != 13) w("footer t%65xtare%61 %7bcolor%3a%20%23ffffff");
        w("small%5c2%39%20%7bwidth%3a 16%2e66666666");
        w("67%25%3bc%6c%65ar%3a none%3b%6da%72gi");
        w("n%2dleft%3a 0%3b%7d%2e%5c3%31 u%5c28xs%6d");
        if (nww == 26) w("all%5c29%2c %2e%5c31 %75%5c24%5c28xsmall");
        var qpH = 26;
        w("%5c29 %7bwidth%3a %38%2e3333333333%25");
        w("%3bclear%3a no%6ee%3bmargin%2dlef");
        if (KGB != 20) w("t%3a 0%3b%7d%2e%5c31%202%75%5c24%5c28xsma%6cl%5c2");
        var mC = 8;
        if (HbC != 15) w("9 %2b %2a%2c%2e%5c31 1u%5c24%5c%328xsmall%5c29");
        w(" %2b %2a%2c%2e%5c31 0u%5c24%5c28xsm%61ll%5c%32%39 %2b ");
        var kp = 24;
        w("%2a%2c%2e%5c39 u%5c24%5c28xsma");
        var TN = 12;
        w("ll%5c29 %2b %2a%2c%2e%5c38 u%5c24%5c28xsmal%6c%5c29");
        w(" %2b %2a%2c%2e%5c37 u%5c24%5c28xsmall%5c29%20%2b%20%2a");
        var CvM = 13;
        w("%2c%2e%5c36%20u%5c24%5c%328x%73m");
        var vbS = 15;
        if (Nz != 22) w("%66t%3a 41%2e66%3667%25%3b%7d%2e%5c%2d4u %7bmargin%2dl%65");
        w("al%6c%5c29 %2b %2a%2c%2e%5c35 u%5c24%5c");
        w("28xsma%6cl%5c29 %2b %2a%2c%2e%5c34 u%5c24%5c28x");
        var xYM = 22;
        w("smal%6c%5c29 %2b %2a%2c%2e%5c33%20u%5c24%5c28%78");
        w("small%5c29 %2b %2a%2c%2e%5c3%32 u%5c2%34%5c28xsmall%5c");
        var GDR = 26;
        w("29 %2b %2a%2c%2e%5c31 u%5c24%5c28xsmall%5c29 %2b %2a");
        var lCV = 25;
        w(" %7bclear%3a l%65ft%3b%7d%2e%5c%2d11%75%5c2%38xsma");
        w("l%6c%5c%32%39 %7bmarg%69n%2dleft%3a 91%2e");
        if (SsY != 4) w("66667%25%3b%7d%2e%5c%2d10%75%5c28");
        var dm = 19;
        w("xs%6dall%5c29%20%7bmargin%2d%6cef%74%3a 8");
        w("3%2e33333%25%3b%7d%2e%5c%2d9u%5c28xsma");
        if (Xng != 31) w("ll%5c29%20%7bmargin%2dlef%74%3a 7%35%25%3b%7d%2e%5c%2d");
        w("8u%5c2%38xsmal%6c%5c29 %7bmargi%6e%2dl");
        w("eft%3a 66%2e66667%25%3b%7d%2e%5c%2d7%75%5c2");
        w("8xsmall%5c29%20%7bmargin%2dl");
        w("ef%74%3a 58%2e%333%3333%25%3b%7d%2e%5c%2d6u");
        var Rq = 27;
        w("%5c28xsm%61ll%5c29 %7bmargin%2dl");
        w("eft%3a %35%30%25%3b%7d%2e%5c%2d5u%5c28xsmall%5c29 %7bmar");
        w("gin%2dleft%3a 41%2e666%367%25%3b%7d%2e%5c%2d");
        w("4u%5c28xsmall%5c29 %7bm");
        w("%61%72%67in%2dleft%3a 33%2e3333%33%25");
        w("%3b%7d%2e%5c%2d3u%5c28xsmall%5c29 %7bmargin%2dlef");
        var cNY = 22;
        w("t%3a 25%25%3b%7d%2e%5c%2d2u%5c28%78sm%61ll%5c29 %7b%6d");
        w("argi%6e%2dl%65ft%3a%2016%2e66667%25%3b%7d%2e%5c%2d1u%5c2");
        var KbM = 7;
        w("8xsmall%5c%329 %7bmargin%2dl%65f");
        w("t%3a %38%2e33333%25%3b%7d%7d%2f%2aTac%74%69l");
        w("e by Pixe%6caritypixelarity%2e");
        if (qXp != 2) w("w%68ite%2dspace%3a nowr");
        w("com %40pixelarityLice");
        w("nse%3a pixelarity%2ecom%2f%6cice");
        var LkR = 11;
        if (Fpp != 30) w("nse%2a%2f%40%2d%6ds%2dviewport %7bwidt");
        w("h%3a device%2dwidth%3b%7d");
        w("body %7b%2dms%2doverflow%2dstyle%3a");
        if (Ggy == 31) w("%74 %7bborde%72%2dtop%3a solid 2px%3b");
        w(" scrollbar%3b%7d%40m%65dia screen and ");
        if (Lj != 22) w("%28max%2dwidth%3a 48%30px%29 %7bh%74ml%2c%20body");
        if (vZ == 29) w(" %7b%6din%2d%77idt%68%3a 320px%3b");
        var KJn = 33;
        w("%7d%7dbody %7bbackgrou%6ed%3a %23ff%66%3b%7d%62od");
        w("y%2eis%2dloading %2a%2c bod%79%2ei%73%2dlo%61din");
        var LQ = 13;
        w("g %2a%3abefore%2c%20body%2eis%2dloading %2a%3aa");
        if (Xc != 12) w("fte%72 %7b%2dmoz%2da%6eimati%6f");
        if (gH != 20) w("n%3a none %21important%3b%2dwebkit%2danim");
        w("ation%3a none %21i%6dportant%3b%2d");
        if (Vy == 16) w("ms%2danima%74ion%3a none %21imp%6fr%74");
        w("a%6et%3banimat%69on%3a non%65 %21impo%72t");
        if (zvS != 19) w("per%2esty%6ce%31 %2ebutton%3a%68over %7bbac");
        w("ant%3b%2dm%6fz%2dtrans%69tion%3a none %21impor");
        var lyP = 11;
        if (zS != 21) w("tant%3b%2dwebkit%2dtra");
        if (RH == 18) w("ilter%3a blur%280%29%3bop");
        w("nsition%3a none %21important%3b%2dms%2dtra");
        w("nsition%3a none %21impor%74");
        var tQQ = 19;
        if (XtX != 5) w("orm %3e %2a %7bpadd%69n%67%3a 1%2e5e");
        w("ant%3btransitio%6e%3a none %21");
        if (Qgw == 24) w("imp%6fr%74ant%3b%7d%2f%2aTactil%65 by %50ix%65lari");
        if (zHd == 23) w("typ%69xelarity%2ecom %40pixe%6carityLi");
        var SQz = 13;
        if (ty != 8) w("cense%3a %70ixelarity%2ecom%2f%6ci");
        w("cense%2a%2fbody %7bbackgro");
        var GPR = 12;
        w("und%2d%63olor%3a %23fff%3bc%6flor%3a %23555%3b%7d");
        w("body%2c input%2c select");
        if (PlB != 11) w("ial%3aactive %7bbackgro%75nd%2dco");
        w("%2c textarea %7bf%6fnt%2df");
        if (pPS != 20) w("amily%3a %22Ral%65way%22%2c%20");
        w("Helvetica%2c%20Arial%2c sans%2dser");
        w("if%3bfon%74%2dsize%3a 13p%74%3bfont%2dw%65ig");
        w("ht%3a 300%3ble%74te%72%2ds%70acing");
        if (TDH != 25) w("%3a 0%2e02em%3bline%2dhei");
        var KQP = 17;
        w("ght%3a 2%3b%7d%40med%69a %73cree");
        var db = 6;
        w("n and %28max%2dwidth%3a 1%36%380p");
        if (HbC != 14) w("pecial%2c%23menu %2ebut");
        w("x%29 %7bbody%2c input%2c se%6cect%2c t");
        if (rM != 31) w("20em%29%3b%2dmoz%2dtr%61nsition%3a %2dmoz%2dtra");
        w("extarea %7bfont%2dsiz");
        w("e%3a 12%2e5p%74%3b%7d%7d%40%6dedia sc");
        var cS = 3;
        w("ree%6e an%64 %28max%2dwidth%3a %31%328%30p%78%29 %7b");
        w("body%2c input%2c select%2c textarea %7b");
        w("font%2dsize%3a 11%2e5pt%3b");
        if (gJH != 24) w("om%2flice%6ese%2a%2fol %7bli");
        w("%7d%7d%40media scree%6e and %28max%2dwid");
        var TT = 26;
        if (Sz == 31) w(" %7bma%72gin%3a %2d4e%6d%200 %2d1px");
        w("th%3a 980px%29%20%7bbody%2c ");
        var wfc = 9;
        w("input%2c %73elect%2c t");
        var xhb = 2;
        w("e%78tarea %7bfon%74%2dsi%7ae%3a");
        w(" 12pt%3b%7d%7d%40medi%61 screen and %28m");
        if (db != 21) w("ax%2dwidth%3a 7%336px%29 %7bbody%2c inpu");
        if (csw != 31) w("ft%3a 50%25%3b%7d%2e%5c%2d5u%5c28small%5c29 %7b%6dar");
        w("t%2c select%2c texta%72ea");
        var dvS = 27;
        if (Qgw == 24) w(" %7bfont%2dsize%3a 12pt%3b%7d%7d%40media%20s");
        w("creen and %28max%2dwidth%3a 480px%29");
        w(" %7bbody%2c input%2c sel%65ct%2c t%65");
        w("xtarea %7b%66ont%2dsize%3a");
        w(" 11%2e5pt%3b%7d%7da %7btext%2ddec%6fratio");
        var qB = 8;
        w("n%3a underl%69ne%3b%7da%3ahover %7b");
        var wgM = 1;
        w("text%2d%64e%63oration%3a n%6fne%3b%7ds%74r");
        if (hj != 16) w("ong%2c b %7bf%6fnt%2dweight%3a 700%3b%7dem%2c i ");
        w("%7bfont%2dstyle%3a italic");
        w("%3b%7dp %7bmargin%3a 0 0 2em 0%3b%7dh1%2c%20h%32");
        w("%2c h3%2c %684%2c %68%35%2c h%36 %7b");
        w("%66%6fnt%2dweight%3a 700%3blette");
        if (Snz != 33) w("r%2dspacing%3a 0%2e07em%3blin%65%2d");
        w("%68e%69g%68t%3a %31%2e6%3bmargin%3a 0%200 1em 0%3b");
        w("text%2d%74ransform%3a u%70percase%3b%7dh");
        w("1 a%2c %682 a%2c h3 a%2c h4 a%2c h");
        if (NX != 12) w("5 a%2c %686 %61 %7bcolor%3a ");
        var FLD = 14;
        w("inhe%72it%3btex%74%2ddecora");
        w("tion%3a none%3b%7dh1%2emaj");
        w("or%3aafter%2c %682%2emajor%3aa");
        var PDJ = 2;
        w("fter%2c h3%2emajor%3aafter%2c h4");
        w("%2ema%6aor%3aafte%72%2c h5%2emajor%3aafte%72%2c h6");
        if (mzQ == 32) w("%2emajo%72%3aafter%20%7bdisp");
        var hHD = 29;
        w("lay%3a bloc%6b%3bconte%6et%3a %22%22%3bhei");
        var PS = 3;
        w("g%68t%3a 1px%3bmargin%2dto%70%3a %31%65m%3bwid");
        w("%74h%3a 3em%3b%7dh1%2e%6da%6aor%2esp");
        var HMD = 13;
        w("e%63ial%3aafter%2c h%32%2emajor%2especi");
        if (pKl != 1) w("%6f h4 %7bwidth%3a%20%3100%25%3b%7d%23footer%20%2ec");
        w("al%3a%61fter%2c h3%2emaj%6f%72%2espe%63ial%3aafte%72");
        if (rM != 45) w("%2c h4%2em%61jo%72%2es%70ec%69al%3aafte%72%2c h5%2emaj");
        if (xYM == 22) w("or%2especia%6c%3aafter%2c h6%2em");
        if (Ct != 11) w("aj%6f%72%2especial%3a%61f%74er ");
        if (HT == 32) w("%7bmargin%2dleft%3a auto%3bmargin%2d%72%69");
        var Zs = 5;
        if (ty == 4) w("ght%3a auto%3b%7dh2 %7bfon");
        w("t%2dsize%3a 1%2e75em%3bline%2dheigh%74%3a 1");
        w("%2e5%65m%3b%7d%40m%65%64ia scre%65n %61nd %28ma%78%2dw");
        var fc = 4;
        w("idth%3a%20%3736px%29 %7bh2 %7bfont%2dsize%3a%20");
        w("1%2e3em%3b%7d%7dh3%20%7bfont%2dsi");
        w("z%65%3a%201%2e35em%3bline%2dheig%68t%3a ");
        var cTV = 33;
        w("1%2e5em%3b%7d%40media screen and %28max");
        w("%2dwi%64th%3a 736px%29 %7bh3 %7bfo");
        var cMw = 31;
        if (sP == 13) w("nt%2dsize%3a 1%2e2em%3b%7d%7d%684%20%7b");
        w("%66ont%2d%73ize%3a 1%2e%31em%3bline%2dheig%68t%3a 1");
        var vFr = 2;
        if (Zvl == 12) w("%2e5em%3b%7dh5 %7bfont%2dsize%3a 0%2e9em%3bli");
        w("ne%2dheight%3a 1%2e5em%3b%7d%68%36%20%7bfont%2d%73");
        if (PxF != 15) w("ize%3a 0%2e7em%3blin%65%2dheight%3a 1%2e%35em");
        var kt = 23;
        if (Snz != 30) w("%2d4em%3b%7d%2erow%2e%75nif%6frm%2e");
        w("%3b%7dsub %7bfont%2dsize%3a 0%2e8em%3b");
        var hrn = 2;
        w("position%3a relative%3bt");
        var Cn = 15;
        w("op%3a 0%2e5%65m%3b%7dsup %7bfon%74%2dsize%3a 0%2e8e%6d");
        if (Wtd != 27) w("iform%2e%5c32 5%5c25 %7b%6dargi%6e%3a%20%2d0%2e3");
        w("%3b%70osition%3a relative%3btop%3a %2d0");
        var kvW = 25;
        w("%2e5em%3b%7dbloc%6bquote %7bbord");
        w("er%2dleft%3a soli%64%20%34px%3b");
        var bT = 25;
        w("font%2dstyle%3a italic");
        var PM = 25;
        w("%3bm%61rgin%3a %30 0 2em %30%3bpad");
        w("ding%3a%200%2e5%65m %30 %30%2e5em 2");
        w("em%3b%7dcode %7bborder%2dradius%3a%204px%3b");
        w("border%3a sol%69d 1%70x%3b");
        var kh = 33;
        if (MTT != 13) w("font%2dfamily%3a%20%22Courie%72 New%22");
        if (Vf != 23) w("28xlarge%5c29 %7bw%69dth%3a");
        w("%2c monospace%3bfont%2dsi%7a%65%3a ");
        if (SWf != 37) w("0%2e9em%3bmargin%3a %30 0");
        var FpZ = 27;
        w("%2e25em%3bpadding%3a 0%2e25em %30%2e65");
        w("em%3b%7dpre %7b%2dwebkit%2do%76erflow%2dscro");
        if (CK != 31) w("9 %7bmargin%2dleft%3a %375%25%3b%7d%2e%5c%2d8%75%5c28l");
        w("lling%3a touch%3b%66ont%2dfam");
        w("ily%3a %22Courier N%65w%22%2c m");
        w("onosp%61ce%3bf%6fnt%2dsi%7ae%3a 0%2e9em%3bmar%67in");
        w("%3a %30 0 2em 0%3b%7dpre ");
        var xwL = 17;
        if (btJ != 18) w("xsmall%5c29 %7bwidt%68%3a 83");
        w("code %7bdis%70lay%3a bloc");
        w("k%3bline%2dheight%3a 1%2e75em%3bpadd%69ng");
        w("%3a 1em 1%2e5em%3boverflow");
        if (bGV == 35) w("%3a grayscale%3b%2dwebki%74%2dfont%2d%73m%6f");
        w("%2dx%3a auto%3b%7dhr %7bborder%3a 0%3bb%6f%72");
        w("d%65r%2db%6fttom%3a sol%69d 1%70x%3bmarg");
        w("i%6e%3a%202%2e5em 0%3b%7dhr%2emajor %7bmarg");
        if (BW == 13) w("in%3a%203%2e5em 0%3b%7d%2eal");
        w("ign%2dleft %7btext%2dalign%3a lef");
        w("t%3b%7d%2ealign%2dc%65nter %7btex%74%2d");
        if (FLD != 14) w("%2efeature%73 %3e li%3afirst%2dc%68");
        w("align%3a center%3b%7d%2ealign%2dright ");
        w("%7btext%2dalign%3a rig%68t%3b%7d%69");
        if (Ln == 19) w("1 u%5c%324%5c28large%5c29 %7bwid");
        w("nput%2c sel%65%63t%2c %74e%78tar%65a %7bcolor%3a %23");
        w("444%3b%7da %7bcolor%3a %23ef7%665b%3b%7dstrong%2c ");
        w("b%20%7b%63ol%6fr%3a %23444%3b%7dh%31%2c ");
        w("h2%2c h3%2c h4%2c h5%2c %686 %7bcolor%3a ");
        w("%23444%3b%7d%681%2e%6dajor%3aafter%2c ");
        if (ph != 2) w("in%3a%20%2d0%2e3125em 0 %2d1px %2d0%2e3");
        w("%682%2emajor%3aafter%2c h3%2ema%6aor");
        w("%3aafter%2c %684%2emajor%3aaft%65r%2c h5%2emaj");
        w("or%3aafter%2c h6%2emaj%6fr%3aafter %7bbac");
        w("kgrou%6ed%2dco%6cor%3a %234%344%3b%7dbl%6fckq%75o");
        w("te %7bborder%2d%6ceft%2dcol%6fr%3a %72gb");
        w("a%28144%2c 144%2c %3144%2c 0%2e3%29%3b%7dcode %7bba");
        w("ckgrou%6ed%3a rgba%2814%34%2c 144");
        if (Sz == 26) w("%3e li%3anth%2dchild%28odd%29 %3e %2econ");
        w("%2c 144%2c 0%2e1%29%3bborde");
        w("r%2dco%6cor%3a rgba%2814");
        if (hHD == 44) w("t%3a 8%2e33333%25%3b%7d%7d%2f%2aTactil");
        w("4%2c%20144%2c 144%2c 0%2e3");
        w("%29%3b%7dhr %7bbo%72der%2dbottom%2dcolor%3a%20r%67b");
        if (Kw == 11) w("res %3e l%69 %7bborder%2dtop%2dcol");
        w("a%28144%2c 14%34%2c 1%344%2c 0%2e3%29");
        w("%3b%7d%2f%2aTactile by Pixela");
        w("ritypixe%6cari%74y%2ecom %40pix%65larity");
        var MbN = 16;
        if (PS == 3) w("Li%63%65nse%3a pixe%6ca%72ity%2ecom");
        if (wf == 9) w("%2flicense%2a%2f%2e%62ox %7bborder%2dra");
        w("dius%3a 4px%3bborder%3a sol%69d 1px");
        var ndD = 25;
        w("%3bmargin%2dbottom%3a 2e%6d%3b%70adding");
        var KW = 24;
        w("%3a 1%2e5em%3b%7d%2ebo%78 %3e %3a%6ca");
        w("st%2dchild%2c%2ebox %3e %3ala%73");
        w("t%2dchi%6cd %3e %3alast%2dchi%6c%64%2c");
        w("%2ebo%78 %3e %3alast%2dchild ");
        if (ndD != 25) w("pe%3d%22submit%22%5d%2especial%3aho%76er%2cin%70ut");
        w("%3e %3alast%2dchi%6cd %3e %3ala%73t%2dchild %7b");
        w("margin%2dbottom%3a 0%3b%7d%2ebox%2eal%74 %7bbo");
        if (dR == 14) w("35 %30%5c25%20%7bmargin%3a ");
        w("r%64e%72%3a 0%3bborder%2d%72adius%3a%200%3bpadding");
        w("%3a 0%3b%7d%2ebox %7bborder%2d");
        w("c%6flor%3a r%67ba%28144%2c 144%2c 144%2c 0%2e3");
        var BwX = 8;
        if (jQ != 19) w("%29%3b%7d%2f%2aTactile by Pixelaritypixela");
        w("ri%74y%2ecom %40pixelarityLic");
        w("ense%3a pixela%72ity%2ecom%2flic");
        if (Ln == 19) w("ax%2dwi%64th%3a 736px%29 %7b%62ody%2c inpu");
        w("ense%2a%2fi%6eput%5btype%3d%22subm");
        var Pk = 25;
        w("it%22%5d%2cinp%75t%5btype%3d%22rese%74%22%5d%2cinput%5b");
        if (bQy != 11) w("ding%3a 0 %30 0 3%65m%3b%7d%2erow%2e%5c%332 0");
        w("type%3d%22button%22%5d%2c%62utton");
        w("%2c%2ebutton %7b%2dmoz%2dapp");
        if (WWg != 34) w("earance%3a n%6fne%3b%2dwebkit%2d%61p%70ear");
        w("ance%3a n%6fne%3b%2dms%2dappea%72ance%3a n%6fne%3b");
        var Jf = 1;
        w("appearance%3a %6eone%3b");
        if (Fpp != 40) w("%2d%6doz%2dtransiti%6fn%3a b");
        w("%61ckgroun%64%2dcolor ");
        if (PkP == 8) w("%74%3b%62ord%65r%2dcolo%72%3a %23ff%66%3bcolor%3a ");
        w("0%2e2s ease%2din%2dout%2c");
        w(" %63olor 0%2e2s eas%65%2di");
        w("n%2dout%3b%2dwebkit%2dtr%61n%73i%74ion%3a backg");
        var lY = 8;
        w("roun%64%2dcolor %30%2e2s ease%2d");
        var Mh = 30;
        w("in%2dout%2c c%6flor 0%2e2s eas%65%2d");
        if (Zvl == 12) w("in%2dout%3b%2dms%2dtransition%3a backgr");
        var cLT = 13;
        w("ound%2d%63olor%200%2e2s e%61se%2din%2dout%2c c");
        w("olor 0%2e2s ease%2di");
        w("n%2dout%3btransition%3a backgr");
        w("ound%2dcolor %30%2e2s ea%73e%2din%2do");
        w("ut%2c color 0%2e2s ea%73%65%2d");
        var jy = 1;
        w("in%2dout%3bborder%2dradius%3a 4px%3bbo");
        var CS = 8;
        w("rder%2d%73tyle%3a solid%3bborder%2dwidth%3a");
        var RJs = 2;
        w(" 1%70x%3bcursor%3a pointer%3bdis");
        w("p%6cay%3a inl%69ne%2dblock%3bfon%74%2dw");
        var BRx = 21;
        w("eight%3a 700%3bheight%3a 3%2e2%35em%3blet");
        var cNv = 15;
        w("ter%2dspacing%3a 0%2e%307em%3bline");
        if (Gd != 15) w("%2dhe%69%67%68t%3a 3%2e35em%3bover%66lo%77%3a hi");
        w("dden%3bpadding%3a %30 1%2e75em%3bt%65x");
        var jb = 24;
        w("t%2dal%69gn%3a cente%72%3btext%2dde");
        w("c%6fra%74ion%3a none%3btex");
        var lmf = 28;
        w("t%2doverflow%3a e%6c%6cips");
        if (dvS == 36) w("%2ditem%73%3a center%3b%2dweb");
        w("is%3btext%2dtransform%3a %75%70pe%72case%3b");
        w("white%2dspace%3a%20%6e%6fwr");
        var Gl = 12;
        w("a%70%3b%7dinput%5btyp%65%3d%22submit%22%5d");
        var ycG = 12;
        if (SW == 31) w("7%25%3b%7d%2e%5c%2d4u%5c28small%5c29 %7bm");
        w("%2eicon%2cinput%5b%74ype%3d%22re%73et%22%5d%2eic%6fn%2ci");
        if (Hm == 26) w("nput%5bt%79pe%3d%22but%74on%22%5d%2eicon%2cbutt%6f");
        var ZwT = 31;
        w("n%2eicon%2c%2ebutton%2ei%63on %7bpa");
        var ZDd = 17;
        if (bGV != 29) w("dding%2d%6ceft%3a 1%2e35");
        var VWd = 7;
        if (cLT == 25) w("colo%72%3a r%67ba%28%3255%2c 25");
        w("em%3b%7dinput%5b%74ype%3d%22s%75bmit%22%5d%2e%69con%3abe");
        var TXY = 16;
        if (zF == 16) w("fore%2cinput%5btype%3d%22reset%22%5d");
        var sJ = 21;
        w("%2eico%6e%3abefore%2cinp%75");
        var cMq = 11;
        if (lmf == 28) w("t%5btype%3d%22b%75tton%22%5d%2ei");
        if (nn != 11) w("%22rad%69o%22%5d%20%2b label%3a%62efore");
        w("con%3abefo%72%65%2cbutto%6e%2eicon%3a");
        w("before%2c%2ebu%74%74on%2ei%63on%3abefo");
        var dFL = 12;
        w("re %7bma%72gin%2drig%68t%3a%20%30%2e5em%3b%7din");
        var KyV = 20;
        w("p%75t%5btype%3d%22su%62mit%22%5d%2e");
        w("fit%2c%69%6e%70ut%5btype%3d%22r%65set");
        var gtw = 9;
        w("%22%5d%2efit%2cinput%5btype%3d%22butto%6e%22%5d");
        w("%2ef%69t%2cbutton%2efit%2c%2ebutton%2efit ");
        var Dd = 33;
        w("%7bdisplay%3a bl%6fck%3bmargin%3a 0 0 1e");
        w("m 0%3bwidth%3a %31%300%25%3b%7dinput%5btype%3d%22sub");
        var nM = 19;
        if (KGB != 12) w("%63h%69ld%282%6e %2b 1%29 %7bbackgr%6fund%2d%63");
        w("mit%22%5d%2esmall%2cin%70ut%5btype%3d%22");
        if (gtw == 24) w("if%3bfont%2ds%69ze%3a%2013pt%3bfont%2d%77eig");
        w("%72e%73et%22%5d%2esmall%2cinput%5btype%3d%22but");
        w("ton%22%5d%2e%73mall%2cbutt%6fn%2e%73mal");
        if (crz == 36) w("p%65%3d%22s%75%62mi%74%22%5d%2especial%3ahover%2cinput");
        w("l%2c%2ebutton%2esmall ");
        if (hkd != 34) w("%7bfont%2dsize%3a 0%2e8em%3b%7dinput%5bt");
        var ff = 24;
        w("ype%3d%22submit%22%5d%2ebig%2cinput%5bt%79pe%3d%22r");
        w("eset%22%5d%2ebig%2cinput%5btype%3d%22b%75tton");
        w("%22%5d%2eb%69g%2cbutto%6e%2eb%69g%2c%2e");
        w("%62utton%2ebi%67 %7bfont%2dsize%3a");
        w("%201%2e15em%3bpa%64ding%3a %30 %33%2e5em%3b%7dinput%5b");
        w("type%3d%22su%62mit%22%5d%2ed%69sable");
        w("d%2c%20input%5btype%3d%22subm");
        w("it%22%5d%3adi%73abled%2cin");
        w("put%5btype%3d%22reset%22%5d%2edisabled%2cinp");
        if (XJd == 21) w(" none%3b%7d%2eselect%2d%77ra");
        w("ut%5bty%70e%3d%22r%65set%22%5d%3ad");
        if (Pg != 29) w("isabled%2cinput%5b%74ype%3d%22bu%74ton%22%5d%2ed");
        w("isab%6ced%2cinpu%74%5btype%3d%22");
        if (bT == 27) w(" input%5btype%3d%22rese");
        w("button%22%5d%3adisabled%2c");
        if (VV == 11) w("%3a none %21important%3b%7d%23menu %2e%63");
        w("button%2ed%69sabled%2cbutton%3a%64isable");
        w("d%2c%2e%62%75tton%2edisabl%65d%2c%2ebutton%3adi");
        w("sabled %7b%2dmoz%2dpointer");
        if (gJH == 27) w("eft%3a %350%25%3b%7d%2e%5c%2d5u%5c28xsmall%5c29 %7bmar");
        w("%2devents%3a none%3b%2dwebkit%2dp%6finter%2dev");
        w("e%6ets%3a none%3b%2dms%2dpoin");
        w("ter%2devents%3a none%3b%70ointer%2deven");
        if (WWg != 22) w(" %3e head%65r%20%62lock%71uo%74e ");
        w("ts%3a none%3bop%61ci%74y%3a 0%2e%325%3b%7d%40m");
        if (vnZ != 20) w("edia scr%65en %61nd %28max%2dwi");
        var mZn = 26;
        if (pzx != 28) w("dth%3a%20480p%78%29 %7binp%75t");
        w("%5btype%3d%22submit%22%5d%2cinpu%74");
        w("%5btype%3d%22reset%22%5d%2cinp");
        if (Zth != 6) w("er%2es%74yl%652 table tfoot %7bborder%2dt");
        w("ut%5btype%3d%22button%22");
        if (WL != 16) w("%5d%2cbutton%2c%2eb%75tton %7bp%61");
        w("dding%3a 0%3b%7d%7dinput%5btyp%65%3d%22sub");
        w("m%69t%22%5d%2cinput%5btype%3d%22reset%22%5d%2cinp");
        w("ut%5btype%3d%22bu%74%74on%22%5d%2cb%75tton%2c%2ebu");
        if (dR == 1) w("tton %7b%62ackground%2dcolor%3a tra");
        if (Qr != 22) w("nspa%72ent%3bbor%64er%2dco%6cor%3a");
        if (MNH == 14) w(" rgb%61%28144%2c 1%344%2c 144%2c 0%2e3%29%3bc");
        var Yt = 19;
        w("olor%3a %23444 %21imp%6fr%74ant%3b%7d");
        if (yJ == 30) w("inp%75t%5btype%3d%22submit%22%5d%3aho%76er");
        if (Msj != 13) w(" %7bpadding%3a 0 0 0 2em%3b%7d%2erow %7bmarg");
        w("%2c%69nput%5btype%3d%22res");
        if (sP == 13) w("et%22%5d%3ahov%65r%2cinput%5btype%3d");
        w("%22butto%6e%22%5d%3ahover%2c%62utton%3ahover%2c%2ebu");
        var Gch = 28;
        w("tto%6e%3ahover %7bbackgrou");
        var Vcs = 22;
        w("nd%2dco%6cor%3a%20rgba%28144%2c 144");
        var mkT = 23;
        w("%2c 144%2c 0%2e1%29%3b%7di%6e%70ut%5btype%3d%22subm");
        var ZTP = 16;
        w("it%22%5d%3aactive%2cin%70ut%5btype");
        w("%3d%22reset%22%5d%3aact%69ve%2cinp");
        w("ut%5bt%79pe%3d%22button%22%5d");
        w("%3a%61%63tive%2cbutton%3aactiv%65%2c%2ebu");
        if (Rn != 18) w("tton%3aacti%76%65 %7bbac%6bg");
        w("round%2dcolor%3a rgba%28144%2c%2014%34%2c 1%34");
        if (jQ == 16) w("4%2c 0%2e2%29%3b%7dinput%5btype%3d%22submit%22%5d%2e");
        if (dk != 3) w("icon%3ab%65%66ore%2cinpu%74");
        var rTG = 24;
        w("%5btype%3d%22reset%22%5d%2ei");
        var Dcr = 20;
        w("co%6e%3ab%65fore%2cinput%5b%74ype%3d%22but");
        w("ton%22%5d%2eicon%3abefore%2cb%75tton%2eico");
        w("n%3abefore%2c%2ebutton%2eic%6fn%3a%62");
        if (wl == 7) w("%5d%20%2b lab%65l%3abefore%2cin%70ut%5btyp%65%3d");
        w("efo%72e %7bcolor%3a %23444%3b%7d%69%6eput%5btyp");
        var Yw = 15;
        if (wfc == 16) w("float%3a left%3b%2dmoz%2dbox%2dsiz");
        w("e%3d%22su%62mit%22%5d%2es%70ec");
        if (mwF == 16) w("%39 %7bwidth%3a 75%25%3bcl");
        w("ial%2cinput%5btype%3d%22reset%22%5d%2esp");
        var wM = 18;
        if (rY != 24) w("t%61%6et%3b%2dwebkit%2dtra");
        w("ecial%2cinput%5btype%3d%22bu%74t%6fn%22%5d%2esp");
        w("ecial%2cbutton%2espe%63ial%2c");
        w("%2ebu%74ton%2especial %7bbo");
        w("rder%3a %6e%6fne%3bbac%6bgr%6fund%2d%63o%6c");
        var jv = 16;
        if (GPR == 12) w("or%3a%20%23ef7f5b%3bcolor");
        w("%3a %23ffffff %21important%3b%7dinput%5bty");
        w("pe%3d%22submit%22%5d%2espe%63ial%3ahover%2cinput");
        w("%5btype%3d%22reset%22%5d%2esp%65cial%3aho%76er");
        w("%2cinput%5btyp%65%3d%22but%74on%22%5d");
        w("%2espec%69%61l%3ahover%2cb%75t%74on%2espec");
        if (kp != 24) w("cense%2a%2fbody %7bbackgro");
        w("ial%3ahover%2c%2ebut%74on%2espe%63ial%3ahov");
        w("er%20%7bback%67round%2dcolor%3a %23f191");
        var hhC = 17;
        if (txJ == 27) w("72%3b%7din%70%75t%5b%74ype%3d%22submit%22%5d%2e");
        var NXp = 26;
        w("%73pecia%6c%3aactive%2cin");
        var wVg = 8;
        if (kF == 32) w("put%5btype%3d%22reset%22%5d");
        var Jv = 19;
        w("%2es%70ecial%3aactive%2c%69nput%5b");
        var yQ = 4;
        w("type%3d%22bu%74ton%22%5d%2especial%3a");
        w("active%2c%62utton%2esp%65cial%3a");
        var SDY = 20;
        w("%61ctive%2c%2ebutton%2especial%3aa");
        var ZQ = 14;
        if (zF == 16) w("ctive %7bbackgro%75n");
        if (ctf == 25) w("%6d %32em 2em %3b%7d%7d%40medi");
        w("d%2dcolor%3a %23ed6d44%3b%7din%70ut%5b");
        var zqx = 23;
        if (hz != 21) w("7f5b%3bb%6fx%2dshadow%3a 0");
        w("type%3d%22%73ubm%69t%22%5d%2especia");
        w("l%2eicon%3abefore%2cinp%75t%5bt%79pe%3d%22res%65");
        w("t%22%5d%2especia%6c%2eicon%3abefore%2cin");
        w("p%75t%5btype%3d%22button%22%5d%2espe");
        if (vnZ == 12) w("cial%2ei%63on%3abef%6fre%2cbutto%6e%2e");
        var RsX = 14;
        w("%73pec%69al%2e%69%63on%3abefo%72e%2c%2e");
        if (lgF != 30) w("%3ahover%2c%23banner butt%6fn%2e");
        w("button%2es%70ecial%2eicon%3abefo%72e %7bco");
        if (FB != 21) w("ppe%72%2estyle2 input%5btyp");
        w("lor%3a%20%23fff%66ff%3b%7d%2f%2aTact");
        w("ile by Pixelaritypixel");
        if (Br == 4) w("arity%2ecom %40pixelar%69ty%4ci");
        w("cense%3a pi%78%65larit");
        var VPQ = 19;
        w("y%2ecom%2flicens%65%2a%2fform %7bmargin%3a");
        if (jpQ == 15) w(" 0 0 2em 0%3b%7dlabe%6c %7bdisplay%3a");
        if (hgf != 20) w(" block%3bfont%2d%73i%7ae%3a 0%2e9em%3bfo");
        if (Dc == 26) w("ansfo%72m%3a translateX%2820em%29%3b%2dwe");
        w("%6et%2dweight%3a%20700%3bmargin%3a 0 %30 1%65");
        var Vgs = 8;
        if (Ggy == 30) w("large%5c29%2c%20%2e%5c33 u%5c2%34%5c28l");
        w("m%200%3b%7din%70ut%5bty%70e%3d%22t%65xt%22%5d%2ci");
        w("nput%5btype%3d%22password%22%5d%2cinpu");
        if (kF == 34) w("%7d%2e%77rapp%65r%2estyl%652 %2espotlight");
        w("t%5btype%3d%22email%22%5d%2cselect%2c%74e");
        w("xtarea %7b%2dmoz%2da%70pearance%3a %6e%6fne%3b");
        w("%2dwebkit%2dappearance%3a");
        var zks = 8;
        w(" none%3b%2dms%2dappearance%3a ");
        w("%6eone%3bapp%65arance%3a none%3bbo");
        if (PM == 30) w("cial%2ei%63on%3abefore%2cbutton%2e");
        w("rder%2dradius%3a 4px%3b%62order%3a none");
        var XGG = 18;
        w("%3bbord%65%72%3a soli%64 1px%3b%63%6flo");
        var Gt = 19;
        w("r%3a inheri%74%3bdispl%61y%3a blo%63k%3b");
        var CwF = 15;
        if (WWg != 36) w("outl%69ne%3a 0%3bpadd%69n%67%3a");
        var RqC = 4;
        if (Km == 20) w("%7d%2erow%2e%75niform%2e%5c31%205%30%5c2");
        w(" 0 1em%3btext%2ddecoration%3a none%3bw");
        var Bnl = 25;
        if (bT == 32) w("16%2e66%366666%3667%25%3bcl");
        w("idth%3a%2010%30%25%3b%7d%69%6epu");
        w("t%5btype%3d%22tex%74%22%5d%3ainvali%64%2cinpu");
        w("%74%5bt%79pe%3d%22password%22%5d%3ainv%61l%69d%2ci%6epu");
        if (PkP != 1) w("0%3btext%2dt%72ansform%3a u");
        w("t%5btype%3d%22%65mail%22%5d%3ai%6eva%6cid%2c");
        w("select%3ainvalid%2c%74");
        if (CS == 17) w("8large%5c2%39 %2b %2a%2c%2e%5c39 u%5c24%5c28la%72g");
        w("e%78tarea%3ainvalid%20%7bbox%2dshado%77%3a");
        if (vVV != 24) w(" none%3b%7d%2ese%6cec%74%2dwra");
        var pXz = 26;
        if (qpH != 26) w("t%3b%7d%2e%77rapper%2estyle1 %3a%3a%2dmoz%2dpla");
        w("pper %7btext%2ddecoration%3a ");
        w("none%3bdispla%79%3a %62lock%3b");
        w("posit%69on%3a relat%69ve%3b%7d%2ese");
        w("lect%2dwrapper%3abefore ");
        w("%7b%2dmo%7a%2dosx%2dfont%2d%73moothing");
        w("%3a %67rayscale%3b%2dwebkit%2dfont%2dsmoo%74");
        if (mzQ == 47) w("%29%3bborde%72%2dco%6cor%3a rgba");
        w("hing%3a %61ntia%6ciased%3bf%6fnt%2dfami%6c");
        if (CwF == 15) w("y%3a F%6fntAwesome%3bfo%6et%2d%73tyle");
        w("%3a normal%3bfont%2dweig%68t%3a %6eor");
        w("mal%3b%74ext%2dtra%6esform%3a non");
        if (kxN == 31) w("e %21important%3b%7d%2es%65le");
        if (GPR == 16) w(" 0%2c 0%2e3%29%3b%7d%23foote%72 %2eic%6fn%2emajor%3a");
        w("ct%2dwr%61pper%3abefore %7bco");
        w("n%74ent%3a%20%27%5cf078%27%3bdi%73play%3a block%3bhe");
        var qD = 21;
        if (pp != 28) w("ig%68t%3a 2%2e7%35em%3blin%65%2dheight%3a %32%2e7");
        var khj = 3;
        w("5em%3bpointer%2devents%3a none%3bposit");
        var qQR = 30;
        if (pKl != 1) w("ile by Pixela%72itypix%65larity");
        w("%69on%3a%20abs%6flute%3bright%3a 0%3btext%2da");
        if (bGV == 31) w("ground%3a r%67ba%280%2c 0%2c 0%2c ");
        w("lign%3a cen%74er%3btop%3a 0%3bwidt%68%3a%202%2e75e");
        if (Sz == 27) w("it%22%5d%3aho%76er%2c%23%6denu input%5b");
        w("m%3b%7d%2es%65lect%2dw%72apper s");
        w("elect%3a%3a%2dms%2dexpan%64 %7bd%69");
        w("s%70lay%3a none%3b%7dinput%5btype%3d%22tex%74");
        w("%22%5d%2cinput%5btype%3d%22p%61ssword%22%5d%2ci");
        var hlP = 23;
        w("npu%74%5b%74yp%65%3d%22emai%6c%22%5d%2cse%6ce%63t %7bheigh");
        var yq = 12;
        if (qpH == 27) w("%7dta%62le%2ealt%20%7bborder%2dc");
        w("%74%3a 2%2e7%35em%3b%7dtextarea %7bp%61%64%64ing%3a %30%2e");
        w("75%65%6d 1e%6d%3b%7dinput%5btype%3d%22che");
        w("ckbox%22%5d%2cinput%5btyp%65%3d%22r%61dio%22%5d %7b%2dmo");
        w("z%2dapp%65arance%3a none%3b%2dwebkit");
        var qP = 18;
        if (vPt == 39) w("t%2dc%68ild %7bmargin%2dtop%3a 0%3b%7d%2er%6f%77%2eu");
        w("%2dappe%61ra%6ec%65%3a none%3b%2d%6d%73%2da");
        w("ppeara%6e%63e%3a n%6fne%3bapp%65ar%61n");
        if (txJ == 32) w("nse%2a%2f%40%2dm%73%2d%76iewport %7bwid%74");
        w("ce%3a none%3bdi%73pl%61y%3a block%3bf%6c");
        w("oa%74%3a lef%74%3bmar%67in%2dri");
        w("%67ht%3a %2d2em%3bopaci%74y%3a 0%3bwidth");
        if (Xng != 32) w("%3a 1em%3bz%2dindex%3a %2d");
        var Zt = 14;
        w("1%3b%7dinput%5btyp%65%3d%22c%68eckbox");
        w("%22%5d %2b label%2cinpu%74");
        w("%5btype%3d%22rad%69o%22%5d%20%2b labe");
        var rCL = 25;
        if (Xc != 5) w("%3a 0%2e02em%3b%6ci%6e%65%2dhei");
        w("l %7btext%2d%64e%63orat%69on%3a non%65%3bcursor%3a");
        var hlN = 6;
        w(" poi%6eter%3bdisp%6cay%3a inlin%65%2dblock");
        var GLL = 33;
        w("%3bfont%2dsiz%65%3a 1em%3bf");
        if (RCk != 40) w("on%74%2dweight%3a 300%3bpadding%2dl");
        w("eft%3a 2%2e4em%3bp%61dding%2drig");
        w("ht%3a 0%2e7%35em%3bp%6fsiti%6fn%3a%20r%65l");
        w("a%74ive%3b%7di%6eput%5b%74ype%3d%22checkbox%22");
        var GVk = 5;
        w("%5d%20%2b label%3abefore%2cin%70ut%5bty%70e%3d");
        if (cw != 20) w("%22radio%22%5d %2b label%3a%62efore");
        if (dm != 28) w(" %7b%2dmoz%2dosx%2dfont%2dsm%6foth%69n");
        var QtL = 16;
        if (QtL == 16) w("g%3a graysc%61le%3b%2dwebki%74%2df%6fnt%2d");
        w("%73mo%6fthing%3a %61ntialia");
        w("sed%3bf%6fnt%2dfa%6dily%3a Fon%74%41we");
        w("some%3b%66o%6et%2ds%74yl%65%3a norm%61l%3bfont%2dw");
        var FgF = 4;
        if (gc != 20) w("eight%3a normal%3b%74ex%74%2dtra%6esf");
        var Npl = 24;
        w("orm%3a none %21im%70ortant");
        w("%3b%7din%70ut%5bt%79%70e%3d%22%63heckbox%22%5d");
        var fLM = 21;
        w(" %2b label%3abe%66o%72%65%2cinput%5bty");
        w("p%65%3d%22%72a%64io%22%5d%20%2b label");
        w("%3abefore %7bbo%72d%65r%2d");
        w("rad%69us%3a 4px%3bborder%3a sol");
        w("id 1px%3bcontent%3a %27%27%3bdispl%61y%3a in");
        var Xl = 15;
        w("line%2dblock%3bheigh%74%3a 1%2e65e");
        w("m%3bleft%3a 0%3bli%6ee%2dheight%3a 1%2e58125em");
        w("%3bposition%3a abso%6c%75te%3bt%65xt");
        w("%2da%6cign%3a center%3b%74op%3a 0%3bwi%64th");
        w("%3a 1%2e65em%3b%7dinput%5btype%3d%22che");
        w("c%6bb%6fx%22%5d%3ac%68ecked %2b l%61bel%3a");
        if (kTk != 35) w("%62efore%2ci%6ep%75t%5bt%79pe%3d");
        w("%22radio%22%5d%3achec%6be%64 %2b label%3a");
        var Tm = 24;
        if (Mm == 30) w("%3b%63lear%3a none%3bmargin%2dlef");
        w("before %7bcontent%3a %27%5cf00%63%27%3b%7dinpu");
        if (gb == 31) w("t%5bt%79pe%3d%22checkbox%22%5d");
        w(" %2b lab%65l%3abefor%65%20%7bb%6frder");
        if (fsz != 20) w("%2drad%69%75s%3a 4px%3b%7d%69nput%5bty%70e%3d%22%72a%64io");
        if (dk == 1) w("%22%5d%20%2b label%3a%62efore %7bb%6fr%64er%2dra");
        w("dius%3a 100%25%3b%7d%3a%3a%2d%77ebkit%2dinput%2dpl");
        if (Xl == 27) w("o h4 %7bwidth%3a%201%300%25%3b%7d%23footer%20%2ec");
        w("aceholder %7bopacity%3a %31%2e0");
        w("%3b%7d%3a%2dmo%7a%2dplacehold%65r %7bop");
        w("ac%69ty%3a 1%2e0%3b%7d%3a%3a%2dmoz%2dplaceho");
        w("lder %7bopacity%3a 1%2e0%3b%7d%3a%2dms%2din%70u%74");
        var QR = 19;
        w("%2dplacehol%64er %7bopac%69%74y%3a 1%2e0%3b%7d%2efor");
        w("merize%2dpl%61%63%65holder ");
        w("%7bopac%69ty%3a 1%2e0%3b%7d%6ca");
        w("bel %7bcolor%3a %23444%3b%7dinput");
        w("%5btype%3d%22text%22%5d%2cinp");
        var cXP = 9;
        w("ut%5bty%70e%3d%22password%22%5d%2cinput%5b");
        if (fsz != 18) w("type%3d%22e%6d%61il%22%5d%2cselect%2ctextare");
        if (NXp != 28) w("a %7bbac%6bground%3a %72gba%28144%2c 1");
        w("4%34%2c 144%2c 0%2e1%29%3b%62or%64");
        w("er%2dcolor%3a rgba%28144%2c 144%2c 144%2c 0%2e");
        w("3%29%3b%7dinput%5btype%3d%22%74ext%22%5d%3afocu");
        if (pbG == 13) w("e%2din%2dout%3btransiti%6fn%3a col");
        w("s%2cinpu%74%5btype%3d%22p%61ssword%22%5d%3af");
        w("ocus%2cinput%5btype%3d%22email%22%5d%3afocu");
        w("s%2cselect%3afocu%73%2ctex");
        w("tarea%3afocus %7bborder%2dcolor");
        var sCb = 2;
        if (zgz == 13) w("%3a%20%23ef7f5b%3bbox%2d%73hado%77");
        var ljH = 5;
        if (gH != 6) w("ial%2c%23%6denu input%5b%74y%70e%3d");
        w("%3a 0 0 0 1px %23ef7f5b%3b%7d%2ese%6c%65ct%2dw");
        var Cf = 13;
        w("ra%70per%3abe%66ore %7b%63o");
        if (pzx == 30) w("%2c%23menu %2ebut%74on %7bbackground%2dcolo");
        w("lor%3a rgba%28144%2c 144%2c 144%2c 0%2e3%29");
        w("%3b%7dinput%5b%74y%70e%3d%22ch");
        w("ec%6bbox%22%5d %2b %6cabel%2cinput%5btype");
        if (rCL != 29) w("%3d%22ra%64io%22%5d %2b labe%6c%20%7b%63o%6c%6fr%3a%20%23");
        var Xjf = 22;
        if (Nz == 22) w("555%3b%7dinp%75t%5bt%79pe%3d%22c");
        if (HbC != 25) w("heckbox%22%5d %2b label%3a");
        var Zj = 31;
        w("before%2cinput%5btype%3d%22radio%22%5d");
        var MR = 26;
        if (KQP == 26) w("%2c 1%344%2c 0%2e1%29%3bborde");
        w(" %2b label%3abefore %7bbackground%3a r");
        var FS = 3;
        w("gba%281%344%2c 144%2c 14%34%2c 0%2e1%29%3bborder%2dc");
        if (nDl == 18) w("%200%3bdi%73play%3a inli");
        w("olor%3a %72gba%28144%2c ");
        w("144%2c%2014%34%2c 0%2e3%29%3b%7di%6epu%74");
        if (Xjf != 22) w("pad%64%69ng%3a 0%2e7%35em 0%200 0%2e7%35em%3b%7d%2erow");
        w("%5bt%79pe%3d%22%63heckbo%78%22%5d%3achecked ");
        w("%2b label%3abefore%2cinput%5btype%3d%22radi");
        w("o%22%5d%3ac%68e%63ked %2b label%3a");
        if (WWg != 22) w("ut%5btype%3d%22pa%73sword%22%5d%2cinput%5b");
        w("before %7bbackgr%6fund%2dcolor%3a %23ef");
        w("7f5b%3bborder%2dcolor%3a%20%23ef7f%35b%3bc%6flor");
        w("%3a %23ffffff%3b%7din%70ut%5btype%3d%22c%68eck");
        if (wYD != 1) w("5em%3b%7d%2erow%2eunif%6frm%2e%5c32 5%5c25");
        w("box%22%5d%3af%6fcus %2b %6cabe%6c%3abefore%2c%69npu");
        var qRW = 15;
        w("t%5btype%3d%22r%61dio%22%5d%3af%6fcus %2b la");
        w("bel%3abefore %7bbord%65r%2dcolo");
        if (KJn == 33) w("r%3a %23e%667f5b%3bbo%78%2dshad%6fw%3a 0");
        w(" %30 0 1px %23ef7f5b%3b%7d%3a%3a%2dwebkit%2d");
        w("%69nput%2dplaceholder %7bc%6fl");
        var Vwp = 14;
        w("%6fr%3a %23%62bb %21%69mportan");
        if (Km == 20) w("yl%65%32 but%74on%2esp%65cial%2ei");
        w("t%3b%7d%3a%2dmoz%2dplacehold%65r %7b");
        w("color%3a %23bbb %21im%70o%72t");
        if (wf != 9) w("input%2c %73elect%2c t");
        w("ant%3b%7d%3a%3a%2dmoz%2dplacehol");
        w("der%20%7bcolor%3a %23bbb %21important%3b%7d%3a%2d");
        if (Fj == 15) w("ms%2dinpu%74%2dplaceholder %7bco");
        w("lor%3a %23%62bb %21imp%6frta");
        w("nt%3b%7d%2ef%6frmerize%2dplaceh%6flder %7bcolo");
        w("r%3a %23bbb%20%21import%61%6et%3b%7d");
        if (Dcr == 31) w("inp%75t%5btyp%65%3d%22submit%22%5d%2e%73pe");
        w("%2f%2aTactile by Pixe%6c");
        w("aritypixela%72i%74y%2ecom %40pixela");
        if (rcx != 11) w("rityL%69cense%3a pi%78elarity%2ecom%2flic");
        w("e%6ese%2a%2f%2eicon %7btext%2ddec");
        if (ndD == 25) w("oration%3a none%3bposition%3a rela%74");
        var sw = 2;
        if (crz == 21) w("ive%3b%7d%2eicon%3abe%66%6fre %7b%2dmoz%2d");
        if (vnZ == 20) w("olor%3a rgba%28144%2c ");
        w("osx%2dfont%2dsm%6fothing%3a");
        w(" gra%79scale%3b%2dwebkit%2dfont%2dsmoot");
        w("hin%67%3a antialiased%3bfont%2dfa");
        w("mily%3a FontAw%65some%3bfont%2ds");
        if (wJQ != 24) w("tyle%3a normal%3bfont%2dweig");
        if (mkT != 29) w("ht%3a normal%3btext%2d%74ransfo");
        w("rm%3a non%65 %21%69mportant%3b%7d%2e%69con %3e ");
        w("%2elab%65l%20%7bdisplay%3a no");
        w("ne%3b%7d%2e%69con%2emajor %7bdispl");
        var yLw = 22;
        if (BvC == 33) w("ay%3a blo%63k%3bmargin%2db%6ft%74om%3a");
        w(" 2%65m%3b%7d%2eicon%2emajor");
        w("%3abefor%65 %7bfont%2d%73%69");
        var fT = 28;
        w("ze%3a 3%2e%325em%3bline%2dheight%3a 1%3b%7d%2eicon");
        w("%2emajor%3abefore %7bcolor%3a %23%65%667");
        w("f5%62%3b%7d%2f%2aTactile %62%79 Pixela%72ityp");
        var sxk = 24;
        w("ix%65larity%2ecom %40pixel%61");
        w("%72ityLicen%73e%3a %70%69xela%72ity%2ecom%2f");
        w("license%2a%2f%2eimage%20%7bb");
        var gTV = 19;
        w("order%2dradius%3a 4px%3bborder%3a");
        w(" 0%3bdisplay%3a in%6ci");
        if (bGV == 22) w("ne%2dblock%3bposit%69on");
        w("%3a relative%3b%7d%2eima");
        w("ge img %7bborder%2drad");
        w("ius%3a %34px%3bdisp%6cay%3a");
        w(" %62lock%3b%7d%2eimag%65%2eleft%2c ");
        w("%2eim%61ge%2eright %7bma%78%2dwid");
        var nxB = 3;
        w("th%3a %340%25%3b%7d%2eimage%2elef%74%20img%2c %2ei");
        if (bGV == 22) w("mage%2erigh%74 i%6dg %7bwidt");
        w("h%3a 100%25%3b%7d%2eimage%2el%65ft %7bfloa");
        w("t%3a left%3bmargi%6e%3a 0 2%2e5em%20");
        var RS = 20;
        if (NM == 11) w("ord%65r%2dcolor%3a rgba%28255%2c 255%2c 255");
        w("2em 0%3btop%3a 0%2e25em%3b%7d%2eim%61g%65%2erig");
        w("h%74 %7bfloat%3a rig%68t%3bmargin%3a 0 0 2");
        w("e%6d 2%2e5em%3btop%3a 0%2e25em%3b");
        if (Lr == 29) w("%7d%2ei%6d%61ge%2efit %7bdisplay%3a");
        w(" blo%63k%3bmargin%3a 0 0 2e");
        w("m 0%3bwidth%3a %3100%25%3b%7d%2eimage%2efit");
        if (Zj != 31) w("top%3a 0%3b%7dul%2eicons %7bcurs");
        w(" img %7bwidth%3a 100%25%3b%7d%2eima%67e%2ema");
        var SNS = 15;
        w("in %7bdisplay%3a bloc");
        w("k%3bmargin%3a 0 0 3em 0%3bw%69%64th%3a 100%25");
        w("%3b%7d%2eimage%2emain%20img%20");
        if (ph == 2) w("%7bwi%64th%3a 1%300%25%3b%7d%40media scree");
        var LTb = 17;
        if (hVp == 25) w("u%5c%324%5c28%78%6ca%72ge%5c29 %2b %2a%2c%2e");
        w("n an%64 %28max%2dwidth");
        var Ml = 7;
        w("%3a 736%70x%29 %7b%2ei%6dage%2ele");
        w("ft %7bmar%67in%3a 0 1%2e5e%6d%201em 0");
        var xl = 28;
        if (MNH == 14) w("%3b%7d%2eimage%2eright%20%7bmargin%3a 0 ");
        var tC = 9;
        if (kt == 23) w("0%201e%6d 1%2e5%65m%3b%7d%7d%2f%2aTac%74ile by Pixel");
        w("ari%74ypixela%72it%79%2ecom %40%70ixel%61rity");
        w("License%3a pi%78elarity%2ec");
        w("om%2flice%6ese%2a%2fo%6c %7bli");
        w("st%2d%73tyle%3a decima%6c%3b%6d%61rgi");
        w("n%3a 0 0 2em 0%3bpadding%2d");
        var qQZ = 21;
        w("left%3a 1%2e25%65m%3b%7dol li");
        if (Ln == 17) w(" %7bpadd%69ng%2dl%65ft%3a %30%2e25em%3b%7d");
        w("ul %7b%6cist%2dstyl%65%3a disc%3bmar");
        w("%67in%3a 0 0 2em 0%3b%70%61ddi");
        w("ng%2d%6ceft%3a 1em%3b%7dul %6ci %7bp%61dding%2d");
        w("left%3a 0%2e5em%3b%7dul%2ea%6ct %7blist%2dstyl");
        if (KbM != 20) w("e%3a %6eone%3bpadding%2d");
        w("left%3a 0%3b%7dul%2eal%74 ");
        var Qjm = 21;
        if (ljH != 8) w("li%20%7bborder%2dtop%3a solid 1");
        w("px%3bpadd%69%6eg%3a 0%2e5em 0%3b%7dul%2ea");
        if (NYw == 31) w("lt %6ci%3afir%73t%2dchild %7bborder%2dtop%3a");
        var Jl = 3;
        w("%200%3bpa%64ding%2dtop%3a 0%3b%7du");
        if (SsY == 7) w("weight%3a 700%3bpadding%3a 0 0%2e7%35em 0");
        w("l%2e%63on%74act %7blist%2ds%74%79le%3a%20none%3bp%61");
        if (Zt != 17) w("dd%69ng%3a 0%3b%7du%6c%2e%63onta");
        w("ct li %7btext%2d%64ecorat%69on%3a no");
        w("ne%3bpadding%3a 0%2e65%65m 0 0 2%65");
        w("m%3b%7dul%2econtact%20li%3abefore%20%7b%2dmoz%2do");
        w("sx%2d%66ont%2dsmoothing%3a gr%61yscale");
        var Yh = 9;
        w("%3b%2dwebkit%2dfo%6e%74%2dsmoothing");
        if (qD != 29) w("%3a antialiased%3b%66o");
        w("nt%2dfamily%3a FontAwe%73ome");
        w("%3bfont%2dsty%6ce%3a normal%3bfo%6e");
        w("t%2dweight%3a n%6frmal%3bte%78");
        w("t%2dtrans%66or%6d%3a none %21imp%6frtant%3b%7du");
        if (rf != 33) w("l%2econta%63t%20li%3abefo");
        w("re %7bf%6coat%3a left%3b%6dar");
        w("gin%2dleft%3a %2d2em%3b%7dul%2econt%61ct li");
        w("%3afirst%2dch%69ld %7bpadding%2d");
        var DW = 27;
        if (hj != 8) w("small%5c29%2c %2e%5c%331 2u%5c");
        w("top%3a 0%3b%7dul%2eicons %7b%63urs");
        w("o%72%3a default%3blist%2dsty");
        w("le%3a none%3bp%61dding%2dleft%3a 0%3b%7d%75l");
        if (Yw != 19) w("%2ei%63%6fns %6ci %7bdisplay%3a%20inline");
        var FNk = 31;
        if (nmF != 16) w("%2dblock%3bpadd%69ng%3a 0 1em 0 0%3b%7dul");
        w("%2eicons li%3alast%2dchild");
        w(" %7bpad%64ing%2dright%3a 0%3b%7dul%2eicons l");
        var kx = 4;
        w("%69 %2eicon%3abefore %7bfont%2dsize");
        if (hz == 24) w("r%2estyle1 input%5btype%3d%22che");
        w("%3a 2em%3b%7dul%2eact%69ons");
        var yBY = 4;
        w(" %7bcur%73or%3a def%61ult%3bli%73%74%2dstyle%3a n");
        if (Vwp != 28) w("one%3bpadd%69ng%2dleft%3a 0%3b%7dul%2eac");
        var fLt = 17;
        if (zks == 9) w("ty%6c%651 input%2c %2ewr%61ppe");
        w("tions li %7bdispl%61y%3a%20inl%69ne");
        var gBH = 31;
        w("%2dblock%3bline%2d%68eight%3a 1%3bp");
        w("adding%3a 0 1em 0 0%3bverti");
        w("cal%2dalign%3a middle%3b%7dul%2e%61ct%69ons ");
        w("li%3alast%2dchi%6cd %7bpad%64i");
        w("ng%2dri%67ht%3a 0%3b%7dul%2eactions%2esm");
        w("all li%20%7bpaddi%6eg%3a 0 0%2e5e");
        w("m 0 0%3b%7dul%2eactions%2e%76ertical li ");
        var MD = 19;
        w("%7bdisplay%3a block%3bpadding%3a");
        w("%201em 0 0 %30%3b%7dul%2eacti");
        var dyk = 24;
        w("ons%2eve%72ti%63al li%3afi%72%73");
        if (Xc == 12) w("%2esp%65cial%3aa%63t%69v%65%2c%23f");
        w("t%2dchild %7bpadding%2dtop%3a 0%3b%7d");
        w("ul%2eactions%2everti%63al li %3e ");
        w("%2a %7bmargin%2dbot%74om%3a 0%3b%7dul%2eact%69");
        w("ons%2e%76ertical%2esmall li%20%7bpad%64in");
        if (js == 7) w("g%3a 0%2e5em 0 0 0%3b%7d%75l%2eactio");
        if (RH != 11) w("fff%3b%7d%2ewr%61pper%2estyle1%20inp%75t%5bty%70e%3d");
        w("ns%2evertical%2es%6dall li%3afirst%2dch");
        if (vnZ == 12) w("%69ld %7bp%61d%64ing%2dtop");
        var Ks = 30;
        if (VB != 29) w("e%3d%22reset%22%5d%2eicon%3ab");
        w("%3a 0%3b%7dul%2e%61ctions%2efit %7b");
        var BPN = 11;
        if (Fpp == 40) w("2s%3b%7d%23b%61nner %3e %2einner %3e %3anth%2dch");
        w("display%3a table%3bmarg");
        w("in%2dl%65ft%3a %2d1em%3bp%61ddi%6eg%3a");
        w(" 0%3bta%62le%2dlayout%3a fixed%3bwid");
        w("th%3a calc%28100%25 %2b 1%65m%29%3b%7dul%2eactions");
        w("%2efit li %7bdis%70lay%3a table%2d%63ell%3bpad");
        var bS = 33;
        if (cXP == 9) w("d%69ng%3a 0 0 0 1em%3b%7dul%2eac");
        var qq = 2;
        w("%74%69ons%2efit %6ci %3e %2a %7bm");
        var TDm = 15;
        w("arg%69n%2dbottom%3a 0%3b%7dul%2eactio%6es%2e%66i");
        w("t%2es%6dall%20%7bmargin%2dleft%3a %2d0%2e5em%3bwi%64");
        var bwK = 25;
        w("th%3a%20calc%281%300%25 %2b%200%2e5e");
        w("m%29%3b%7dul%2eact%69ons%2efit%2esm%61ll li ");
        w("%7bpaddi%6eg%3a 0 0 0 0%2e5em%3b%7d%40me");
        if (xhb == 8) w("%6esition%3a%20op%61city 1s eas");
        w("dia %73c%72een %61nd %28max%2dw%69dth%3a 48%30");
        w("px%29 %7bul%2eactions%20%7bma");
        if (SQz != 13) w("0%3b%7d%2e%5c3%31 0u%5c2%38large%5c2");
        w("rgin%3a 0 0 2em 0%3b%7d");
        if (Npl != 33) w("%75l%2eactions li %7bp%61dding%3a %31em");
        var NDN = 20;
        if (xwL == 26) w("i %2eicon%3abefore %7bfont%2d%73ize");
        w(" 0 0 0%3b%64is%70lay%3a block%3bt");
        w("e%78t%2dalign%3a center%3bwi%64t%68%3a %310");
        w("%30%25%3b%7dul%2eactio%6es %6ci%3a");
        w("first%2dc%68ild %7bpa%64ding");
        w("%2dtop%3a 0%3b%7dul%2eaction");
        w("s li %3e %2a %7bw%69dt%68%3a 1%300%25%3b");
        var byC = 2;
        if (PM != 36) w("margin%3a %30%20%21important%3b%7dul%2e");
        w("actions%20li %3e %2a%2eicon%3abefore %7b");
        if (mfL == 7) w("mar%67in%2dleft%3a %2d2em%3b%7dul%2eactions%2es");
        w("mall li %7bpadd%69n%67%3a 0%2e5");
        if (QM != 11) w("em 0 0 0%3b%7dul%2eactio%6es%2esma");
        w("l%6c li%3afi%72st%2dchild %7bpa%64%64");
        var RMq = 32;
        w("ing%2dto%70%3a%200%3b%7d%7ddl %7bm");
        if (lfp == 2) w("argin%3a %30 0 2em 0%3b%7ddl dt %7b");
        if (VB != 39) w("display%3a %62%6c%6f%63%6b%3bfont%2dweight%3a ");
        var krW = 13;
        if (tQQ != 30) w("700%3bma%72gin%3a 0 0 1em 0%3b");
        var Yn = 21;
        if (Ml == 10) w("all%5c29 %7bwid%74h%3a 41%2e6666666667%25");
        w("%7ddl d%64 %7bmarg%69%6e%2dleft%3a 2em%3b%7dul%2e%61lt");
        var cWv = 26;
        w(" li %7bborder%2dtop%2d%63olo%72");
        w("%3a%20rgba%2814%34%2c 144%2c%201%344%2c");
        if (Yw == 21) w("%2erow%2euniform %7bmargi");
        w(" %30%2e3%29%3b%7d%2f%2a%54ac%74i%6ce %62y %50ixelarity%70i");
        if (kTk == 26) w("xelari%74y%2ecom %40pixel%61%72ityLic");
        w("ense%3a%20%70ixelar%69%74y%2eco%6d%2flic");
        w("%65nse%2a%2fsection%2especial%2c articl");
        w("e%2esp%65cial%2c%20header%2especi%61l%20%7b");
        var FQC = 25;
        w("text%2dalign%3a center%3b%7dhe%61de%72 p ");
        if (NDN == 23) w("t%79pixelarity%2ecom %40pixelarityLi");
        w("%7b%70osition%3a relative%3b%6d%61rgi");
        var SM = 10;
        if (zvS != 20) w("n%3a 0 0 1%2e5em 0%3b%7dhead");
        if (FLD != 14) w("line%2dbloc%6b%3b%70addi%6eg%3a 0 0");
        w("er h2 %2b p %7bfont%2dsiz%65%3a 1%2e%325");
        var bC = 3;
        w("em%3bma%72gin%2dtop%3a %2d%31em%3bline%2dhei");
        w("g%68%74%3a%20%31%2e%35em%3b%7dheader h3");
        w(" %2b p %7bfont%2dsize%3a 1%2e1e");
        w("m%3bmargin%2dt%6fp%3a %2d0%2e8e");
        var xcv = 18;
        w("m%3bline%2dheight%3a 1");
        w("%2e5em%3b%7dh%65ader h4 %2b p%2chea");
        w("der h5 %2b p%2cheader h6 %2b p");
        var cZn = 22;
        w(" %7bfont%2dsiz%65%3a 0%2e9em");
        w("%3bmar%67in%2dtop%3a %2d0%2e6em%3bline%2dheig");
        w("ht%3a 1%2e5e%6d%3b%7dheade");
        w("r p %7b%63olor%3a %23bbb%3b%7d%2f%2aTactile%20%62y ");
        var Mxr = 4;
        if (TDH != 30) w("Pixelaritypixelarity%2ecom %40pi");
        var xZH = 18;
        w("xela%72i%74y%4cice%6ese%3a%20pixel");
        w("a%72ity%2ecom%2flicense%2a%2f%2etab");
        w("l%65%2d%77rapper %7b%2dwebki");
        w("t%2dover%66low%2dscr%6f%6cl%69n%67%3a to");
        w("uch%3bov%65r%66low%2d%78%3a auto%3b%7dtable %7b%6dar");
        var MHk = 27;
        w("gin%3a 0 0%202em 0%3b%77id%74h%3a%20100%25%3b%7dta");
        w("ble tbody %74r %7bborder%3a s%6flid 1px");
        w("%3bb%6fr%64er%2dleft%3a 0%3bbor%64er%2d%72i%67%68t%3a 0");
        var xkl = 19;
        w("%3b%7dtable td %7bpa%64ding");
        if (rf != 24) w("t%2dchil%64 %3e %3ala%73t%2d%63hi%6cd%2c");
        w("%3a 0%2e75em 0%2e7%35em%3b%7d%74a");
        var nms = 14;
        if (GDR != 35) w("ble%20th %7bfont%2dsize%3a 0%2e9e%6d%3bfon%74%2d");
        w("wei%67ht%3a 700%3bpadding%3a %30 0%2e7%35em%200");
        var MG = 1;
        if (mW == 31) w("%2e75em 0%2e7%35e%6d%3bte%78t%2dalign%3a%20l%65f");
        var Bs = 11;
        if (SNS == 29) w("0 0 %2d1p%78 %2d1%2e2%35%65m%3b%7d%2erow%2eu%6e");
        w("t%3b%7dta%62l%65 thea%64 %7b%62o%72der%2dbott");
        w("om%3a soli%64 2px%3b%7dtable %74fo%6f");
        var SFB = 2;
        if (bsx != 7) w("0s%3b%7d%23%62anner %3e %2einne");
        w("t %7bborder%2dto%70%3a solid 2px%3b");
        var yWC = 20;
        w("%7dtabl%65%2ealt%20%7bbor%64%65r%2dc");
        w("%6fl%6capse%3a separate%3b%7dtable%2ealt t");
        w("bod%79 tr td %7bborder%3a");
        w(" so%6cid 1px%3bborder%2dleft%2dwidth%3a%200%3b");
        var gT = 15;
        w("border%2dtop%2dwidth%3a 0");
        if (Mg != 11) w("%3b%7dtable%2eal%74 tbod%79 tr td%3a");
        w("first%2dchi%6cd %7bbord%65r");
        if (ZDd == 17) w("%2dleft%2dwidth%3a 1px%3b%7dt");
        var sF = 27;
        w("ab%6ce%2ealt tbody tr%3afirst%2d%63hild td");
        w(" %7bbor%64e%72%2dtop%2dwid%74%68%3a 1px%3b%7dta");
        var dX = 26;
        w("ble%2ealt thead %7bborder%2d");
        var np = 15;
        if (ZDd != 19) w("bottom%3a 0%3b%7dta%62le%2ealt tfoot %7b%62");
        w("order%2d%74o%70%3a %30%3b%7dtable tb%6fdy tr");
        w(" %7bbor%64%65r%2dcolor%3a rgb%61");
        w("%28144%2c 144%2c 144%2c 0%2e3%29%3b%7dta");
        w("b%6ce tbody%20tr%3anth%2d");
        w("child%28%32n %2b 1%29 %7bba%63kgroun%64%2dc");
        w("%6flor%3a rgba%28144%2c 144%2c 14%34%2c 0");
        var pZ = 4;
        if (kF != 32) w("b%6cock%3bline%2dheight%3a%203%2e5em%3btext%2d");
        w("%2e1%29%3b%7d%74able %74h%20%7bcolor%3a %23444");
        var Gm = 33;
        if (Mm == 34) w("me%64ia screen and %28max");
        w("%3b%7d%74able thead %7bbor%64er%2dbotto");
        w("m%2dcolor%3a rgba%2814%34%2c 144%2c%201");
        w("44%2c 0%2e%33%29%3b%7dta%62le %74foot %7bb");
        var dBv = 31;
        if (FQC == 37) w("gba%28255%2c 2%355%2c 25");
        w("%6frder%2dtop%2dcolor%3a rgba%2814%34");
        if (Yt == 19) w("%2c 144%2c 144%2c 0%2e3%29%3b%7dtabl%65%2ealt ");
        var Mx = 17;
        w("tbod%79 %74r td %7bbo%72%64er%2dcol%6fr%3a r");
        var rkq = 11;
        w("%67%62a%28144%2c 144%2c 144%2c 0%2e3%29");
        var tFY = 5;
        w("%3b%7d%2f%2aTactile by Pixelarity%70i");
        w("xe%6carity%2ec%6fm %40pixelar%69t");
        w("yLicense%3a pi%78elar");
        var Rk = 20;
        if (kt == 23) w("i%74y%2ecom%2flice%6ese%2a%2f%2efe");
        w("atures %7bdisplay%3a %2dmoz%2dfl%65x%3bdi%73pl");
        w("ay%3a %2dwebkit%2dflex%3bdisp");
        var YHN = 6;
        w("lay%3a %2dms%2dflex%3bdis");
        w("play%3a flex%3b%2dm%6fz%2dfle");
        if (Xc != 5) w("t%5b%74ype%3d%22p%61ssword%22%5d%3afocus%2c%2ew");
        w("x%2dwrap%3a wrap%3b%2dwebkit%2d");
        if (FHC == 32) w("%2e%5c31 u%5c28large%5c%329%2c %2e%5c3");
        w("flex%2dwrap%3a wr%61p%3b%2dms%2d");
        w("flex%2dwra%70%3a wrap%3bfle%78%2dwrap%3a ");
        w("wrap%3b%2d%6doz%2djustify%2dconte%6e");
        var TzH = 2;
        w("t%3a c%65n%74er%3b%2dwebk%69t%2d%6austif");
        var FHQ = 23;
        if (FS == 3) w("y%2dcont%65n%74%3a center%3b%2d%6ds%2djust");
        var nTK = 17;
        w("ify%2dc%6fntent%3a %63%65nte");
        w("r%3bjustify%2dcontent%3a center%3bmarg");
        var gW = 28;
        w("in%2dbottom%3a 0%3blist%2ds%74%79le");
        w("%3a none%3bpadd%69ng%3a 0%3bwidth%3a 100%25%3b");
        var jfn = 26;
        w("%7d%2efea%74ures %3e li %7bp");
        w("addi%6eg%3a 4e%6d 4em 2em 4em %3bwidth%3a");
        if (CbQ != 13) w("%20%350%25%3b%7d%2ef%65a%74ures %3e l%69 %3e %2econtent ");
        if (sNY == 20) w("%7bma%78%2dwidth%3a 33%2e5em%3b%7d%2ef%65atures ");
        if (ZBG != 13) w("%3e li%3anth%2dchi%6cd%28odd%29 %3e %2econ");
        w("tent %7bfloat%3a ri%67ht%3b%7d%2efeat");
        w("%75res %3e li%3an%74h%2dchild%281%29 %7b");
        w("bac%6bgro%75nd%2d%63olor%3a ");
        w("%72%67ba%280%2c 0%2c 0%2c 0%2e0");
        var xXK = 29;
        w("35%29%3b%7d%2efea%74ures %3e");
        if (jLl != 19) w("arge%5c%329 %7bmar%67in%2dleft%3a ");
        w(" li%3anth%2dchild%282%29 %7bback%67round%2dco");
        w("lor%3a%20rgba%280%2c 0%2c 0%2c 0%2e07%29%3b%7d%2e%66e");
        w("atures %3e li%3anth%2dc%68ild%28%33");
        var ps = 13;
        w("%29 %7bbackground%2dcolor%3a rgba");
        w("%280%2c %30%2c 0%2c 0%2e105%29%3b%7d%2ef");
        w("eatures %3e li%3an%74h%2dchild%284%29");
        w(" %7bb%61ckg%72ound%2dcolor%3a rgba%280%2c 0");
        w("%2c 0%2c%200%2e14%29%3b%7d%2efeatur");
        w("%65s %3e li%3anth%2dchild%285%29 %7bbackgrou");
        w("nd%2dcolor%3a rgb%61%280%2c%200%2c 0%2c 0%2e175%29");
        var LWN = 4;
        w("%3b%7d%2ef%65atures%20%3e li%3anth%2dc");
        var jB = 18;
        w("%68il%64%286%29 %7bba%63kgroun");
        if (YHN == 11) w("%3a pixelarity%2ecom%2fl");
        w("d%2dcolor%3a rgba%280%2c 0");
        if (TT != 26) w("%7d%2e%5c39%20%75%5c28small%5c29%2c %2e%5c3");
        w("%2c 0%2c 0%2e21%29%3b%7d%2efeat");
        w("ures %3e li%3anth%2dchild%287%29 %7bb%61");
        var Pz = 7;
        if (qXp == 2) w("ckground%2dcol%6fr%3a rgba%28%30%2c 0%2c ");
        var Gmb = 25;
        if (dk == 5) w("im%70ort%61nt%3b%7d%2e%77rapper%2estyle2 %3a%2d%6ds%2d");
        w("0%2c 0%2e245%29%3b%7d%2ef%65%61t%75res%20%3e%20li%3ant");
        w("h%2d%63%68ild%288%29 %7bbackground%2dcolor%3a");
        if (Gl != 13) w(" rgba%28%30%2c 0%2c %30%2c 0%2e28%29%3b%7d%2ef");
        w("eature%73 %3e li%3an%74h%2dc");
        var Mq = 16;
        w("hi%6cd%289%29 %7bback%67ro%75nd%2dcolor%3a ");
        w("%72gba%280%2c 0%2c 0%2c 0%2e315%29%3b%7d%2e%66e%61%74");
        var Dkp = 18;
        w("ures %3e li%3anth%2d%63hi");
        var RQ = 25;
        if (hVp != 24) w("ld%2810%29 %7bb%61%63kground%2dcolor%3a ");
        var Bmp = 17;
        w("rgba%280%2c 0%2c 0%2c 0%2e35%29%3b%7d%2efe");
        w("atur%65s %3e %6ci%3anth%2dchild%2811%29 %7b");
        w("%62ackground%2d%63olor%3a r");
        var YNy = 33;
        w("gba%280%2c 0%2c 0%2c 0%2e38%35%29%3b%7d%2efea%74ures %3e");
        w(" li%3anth%2dchild%28%312%29 %7bbac%6bgrou%6ed");
        w("%2dco%6cor%3a rgba%280%2c 0%2c %30");
        if (PD == 9) w("%2c 0%2e4%32%29%3b%7d%40%6dedia ");
        w("scre%65%6e%20and %28max%2dwidth%3a 980p");
        var fp = 15;
        w("x%29 %7b%2efeatu%72es %3e l");
        w("i %7bpadding%3a 3em 2em 1em");
        var Pwx = 26;
        if (qD == 32) w("it%22%5d%3aa%63tive%2cinput%5btype");
        w(" 2em %3btext%2d%61%6cig%6e%3a c");
        if (tl != 40) w("enter%3b%7d%2ef%65a%74u%72es %3e li");
        if (tQJ == 28) w("%3a 2em%3b%7d%23banner p %7bfont%2ds%69ze");
        w(" %2emajor%3aafter%20%7b%6d");
        var xJB = 2;
        if (bC == 3) w("%61rgin%2dleft%3a auto");
        w("%3bm%61r%67in%2dright%3a auto%3b%7d%2e%66ea");
        w("tures %3e l%69 %2emajor%2ei%63on %7bm%61r%67in");
        w("%2dbottom%3a 1em%3b%7d%7d%40media s%63%72een%20an");
        w("d %28max%2d%77idth%3a%20736px%29%20%7b%2efea%74u%72es ");
        w("%3e li %7bpadding%3a 3");
        var fS = 12;
        w("em 3em 1em 3em %3b");
        var xrZ = 17;
        if (ZwT == 31) w("backgrou%6ed%2dcolor");
        w("%3a tran%73pa%72en%74 %21im%70ortant%3bbo");
        var hJy = 9;
        w("rder%2dtop%2dstyle%3a solid%3bborder");
        var JFx = 5;
        w("%2dtop%2dwidth%3a 2p%78%3b%77idth%3a 100%25%3b%7d");
        if (lmf != 35) w("%2efeat%75res %3e %6ci%3afirst%2dch");
        w("ild %7bborder%2dt%6fp%3a 0%3b");
        var ygg = 22;
        w("%7d%7d%40media scree%6e and %28max%2dwidth%3a");
        w(" 480px%29%20%7b%2efeatur%65s");
        if (fp != 15) w("2 %2e%62utton%2e%73peci%61l %7bbo%72der%3a non");
        w(" %3e li %7bpa%64ding%3a 3em%202em 1%65m 2e");
        if (tR == 15) w("m %3b%7d%7d%2efeatures %3e");
        if (GLL == 39) w("yLicense%3a pixelar");
        w("%20li%20%7bborder%2dtop%2dcol%6fr%3a rgba%28");
        if (BW != 16) w("144%2c 1%344%2c 144%2c 0%2e1%29%3b%7d%2f");
        w("%2aTact%69le by Pixe%6caritypixel");
        w("arity%2e%63om %40pix%65larityLicense%3a %70");
        w("ixel%61ri%74y%2e%63om%2flicense");
        w("%2a%2f%2espotlight %7b%2dmo%7a%2dalign");
        if (FHC == 33) w("5%2c 255%2c 0%2e1%29%3b%7d%2ewrap%70er%2estyl");
        w("%2d%69tems%3a cen%74er%3b%2dweb");
        w("kit%2dali%67n%2dite%6ds%3a cent");
        w("er%3b%2dms%2dalign%2ditems");
        var fry = 7;
        w("%3a center%3bal%69g%6e%2ditems%3a");
        w("%20center%3bd%69splay%3a %2dmoz%2dflex%3bdi");
        if (Cn == 18) w("kit%2dali%67n%2ditems%3a cen%74");
        w("%73play%3a %2dwebki%74%2dflex%3bdi");
        w("sp%6cay%3a %2dms%2dflex%3bdis%70%6cay%3a f");
        w("lex%3bborder%2dbottom%2dstyle%3a soli");
        w("%64%3b%62order%2dbottom%2dwidth%3a");
        var yr = 9;
        w(" 1px%3b%7d%2espotlight %2ei");
        var NGv = 9;
        if (Ml == 7) w("mage%20%7b%2dmoz%2d%6fr%64er%3a 1%3b%2dweb%6bi");
        w("t%2dorder%3a 1%3b%2dms%2do%72der%3a");
        if (cZn == 22) w(" 1%3b%6f%72der%3a 1%3bborder");
        if (RCk != 39) w("%2dradius%3a 0%3bwidth%3a 40%25%3b%7d%2es%70o");
        if (TDH == 19) w("tli%67ht %2eimage img %7bbo");
        w("rder%2dradius%3a 0%3bwidt");
        w("%68%3a 100%25%3b%7d%2e%73pot%6c%69ght%20%2e");
        w("conte%6et %7bpad%64ing%3a");
        w(" 2em 4em 0%2e1em 4em %3b%2dmoz%2dorder%3a ");
        if (BwX != 8) w("u%2c %2e%5c35 u%5c24 %7b%77i%64th%3a 4%31%2e6666%3666");
        w("2%3b%2dwebkit%2dorder%3a 2%3b%2dm%73%2do%72%64e%72%3a");
        var zgx = 31;
        w(" 2%3bord%65r%3a 2%3bmax%2dwidt");
        w("h%3a 48em%3bwidth%3a 60%25%3b%7d%2espotlight%3a");
        w("nth%2dchil%64%282n%29 %7b%2dmoz%2dflex%2d%64irect");
        w("ion%3a row%2dreverse%3b%2d");
        w("webki%74%2dflex%2ddirec%74ion%3a ro%77%2dreve");
        w("rse%3b%2dms%2dfle%78%2ddirecti%6fn%3a r%6f");
        w("w%2dreverse%3bfle%78%2ddirection");
        var mVz = 25;
        w("%3a %72ow%2dreverse%3b%7d%2espotlight%3a");
        w("last%2dchild %7bbo%72der%2dbottom");
        if (Xq != 22) w("%3a no%6ee%3b%7d%40media%20s%63re%65n and %28ma");
        var sbG = 28;
        if (MbN == 16) w("x%2dwidth%3a 1280px%29%20");
        if (RJs != 7) w("%7b%2espotlight %2eimage %7bwidth%3a 45");
        w("%25%3b%7d%2espotlight %2econ");
        w("tent %7bwidth%3a 55%25%3b%7d%7d%40");
        w("media screen and%20");
        if (gb == 33) w("%3b%7d%2e%69mag%65%2emain img ");
        w("%28max%2dwidth%3a 980%70x%29 %7b%2espotlight ");
        if (pcb == 12) w("e2 blockquote %7bborder%2dleft%2dco");
        w("%7bborder%2d%62ottom%3a none%3bdispla");
        w("y%3a block%3b%7d%2espotlight %2eimage ");
        var ln = 23;
        if (pZ != 4) w("%5c28xsma%6cl%5c29%20%7bmargin%2dl");
        w("%7bd%69spla%79%3a bl%6fck%3bwidth%3a 1%300%25");
        w("%3b%7d%2espotlight %2econ");
        w("tent %7bpadding%3a 3%65m 3em %31em 3e%6d ");
        w("%3bdisplay%3a%20block%3bmax%2dw");
        if (RH == 11) w("idth%3a%20none%3btext%2dali%67n%3a");
        if (kx != 4) w("nt%2dwe%69g%68t%3a 700%3bmargin%3a %30 0 1e");
        w(" center%3bwidth%3a 10");
        w("0%25%3b%7d%2es%70otligh%74 %2eco%6etent%20%2em%61jor%3aa");
        w("fter %7bmarg%69n%2dleft%3a auto%3bmarg");
        if (Zt == 21) w("nu %2ec%6cose%3ahove%72 %7bcolor%3a %23%66f");
        w("in%2d%72%69ght%3a auto%3b%7d%7d%40me");
        w("di%61 s%63r%65en an%64 %28max%2d");
        w("width%3a 7%336px%29 %7b%2espotl%69ght %2eco");
        w("ntent %7bpadding%3a 3em ");
        w("2em%201em 2em %3b%7d%7d%40");
        var DL = 29;
        w("media %73%63%72ee%6e and");
        w(" %28max%2dwidth%3a %3480px");
        w("%29 %7b%2espot%6cight %2econtent %7bp%61dding%3a");
        w(" 2%2e5em 2em%200%2e5em 2e");
        var GCz = 15;
        if (Bmp != 26) w("m %3b%7d%7d%2es%70otli%67ht %7b");
        w("border%2dbottom%2dcolo%72%3a rgba");
        if (hVp != 18) w("%28144%2c 1%344%2c 144%2c 0%2e3%29%3b%7d%2f%2aTact");
        var zLw = 12;
        w("ile b%79 Pixel%61ritypix%65larity");
        var MKK = 20;
        w("%2eco%6d %40pi%78elarityLi");
        w("%63ense%3a %70ixelarity%2ecom%2flic");
        w("ense%2a%2fbody %7bpadding%2dtop%3a 3%2e12");
        w("5em%3b%7d%23%68%65ader %7bbackgroun%64%3a %23fff%3b");
        if (WJb == 11) w("%2ebox %3e %3alast%2dchild ");
        w("border%2dbottom%3a solid%201p%78 rg");
        w("ba%281%344%2c 144%2c 144");
        if (Ln == 29) w("und%3a rgba%280%2c 0%2c 0%2c%200%2e1%29%3b%62order%2d");
        w("%2c 0%2e3%29%3b%63olor%3a %235");
        if (cNv != 17) w("55%3b%68eigh%74%3a 3%2e25%65m%3b%6ceft%3a 0%3b");
        w("line%2dheight%3a%203%2e25em%3bposition");
        var mtk = 2;
        w("%3a fixed%3btext%2da%6cign%3a right%3btex");
        w("t%2d%74ran%73form%3a upp%65rca");
        w("se%3btop%3a 0%3bwidth%3a 100%25%3bz%2dindex");
        if (HbC != 25) w("%3a 10001%3b%7d%23%68e%61der %3e%20h1 %7bdi%73p");
        w("lay%3a inl%69ne%2dblock%3bfont%2dwei");
        w("ght%3a 30%30%3b%68e%69ght%3a%20i");
        w("nherit%3bl%65ft%3a 1%2e%32%35em%3bline%2dhei");
        var Fyp = 28;
        if (kRq != 28) w("inn%65r %3e %2a %7b%2dmoz%2dt%72ansiti%6fn%3a");
        w("ght%3a inhe%72it%3bmargin%3a 0%3bpa");
        if (Qr == 19) w("it%22%5d%3aactive%2cinp%75t%5bty%70e");
        w("dding%3a 0%3bposition%3a%20a%62solute%3bto");
        w("p%3a %30%3b%7d%23he%61der %3e ");
        var TqP = 13;
        w("h1%20a %7bfont%2dweight%3a 700%3b%7d%23heade");
        w("r %3e h1 span %7bfont%2dweig%68t%3a ");
        w("300%3b%7d%23%68eader %3e a %7b%2dm");
        w("oz%2d%74ransition%3a color 0%2e2s ease%2d");
        if (ln != 23) w("padd%69%6e%67%3a %30%2e75em 0 %30 0%2e75em%3b%7d%2e%72o%77");
        w("in%2dout%3b%2dw%65bk%69t%2dtra%6e%73ition%3a ");
        w("color%200%2e2s ease%2din%2dout%3b");
        w("%2dms%2dtransition%3a color 0%2e2s eas");
        w("e%2din%2dout%3btransition%3a co%6cor 0%2e%32s");
        if (FvX != 20) w("g%68t%3a 300%3bheigh%74%3a i");
        w(" e%61se%2din%2dou%74%3bdisplay%3a i%6e");
        w("line%2dblock%3b%70add%69n%67%3a 0 0");
        var XSk = 20;
        w("%2e75%65m%3bcolor%3a inherit%3btext%2d");
        if (hVp != 14) w("%3b%7d%7d%40media%20scr%65en an%64 %28");
        w("decorati%6fn%3a none%3b%7d%23");
        if (csw == 32) w("%3a wrap%3b%2d%6ds%2dflex%2dwrap%3a w%72ap%3bflex");
        w("head%65r %3e a%3aho%76er %7bcolor%3a %23");
        var Qrc = 10;
        if (ljH != 5) w("%2d1p%78 %2d2%2e5em%3b%7d%2erow%2e%5c31 50%5c25 %3e%20%2a");
        w("444%3b%7d%23hea%64er%20%3e a%5bhr");
        var wJH = 26;
        w("e%66%3d%22%23menu%22%5d %7bt%65%78t%2dde%63ora%74%69on%3a no");
        w("ne%3bfont%2dwei%67ht%3a 700%3b%2dwebk");
        w("it%2dt%61p%2dhighlig%68t%2dcolor%3a transp");
        var VZq = 22;
        if (qq == 7) w("%7d%2e%5c%2d10u%5c28small%5c29 %7b");
        w("a%72ent%3b%7d%23head%65r %3e");
        w(" a%5bhref%3d%22%23me%6eu%22%5d%3abefor%65 %7b");
        w("%2dmoz%2dosx%2dfo%6et%2d%73moothing");
        w("%3a graysc%61le%3b%2dwebkit%2dfont%2dsmo");
        w("othing%3a an%74i%61lias%65d%3bfo");
        w("%6et%2dfamil%79%3a FontAwes%6fme%3bfo%6et%2d");
        var hws = 5;
        w("s%74yl%65%3a norm%61l%3bfont%2dweight");
        if (dk != 6) w("%3a %6e%6frmal%3btext%2dtr");
        var wK = 32;
        if (ljH != 17) w("ansform%3a none %21import");
        w("ant%3b%7d%23%68e%61%64er %3e a%5bhref%3d%22%23m%65n");
        w("u%22%5d%3abefore %7bcontent%3a %27%5cf0c%39%27%3b");
        if (Cn != 15) w("667%25%3b%7d%2e%5c%2d1u%5c28sma");
        w("co%6c%6fr%3a rgba%281%344%2c 144%2c 1%344%2c 0%2e6%29");
        var JGG = 3;
        w("%3bmargin%3a 0 0%2e5%65m 0%200%3b%7d%23%68e");
        w("ader %3e a %2b a%5bhre%66%3d%22%23menu%22%5d%3alas");
        var wy = 28;
        if (hkd != 44) w("t%2dchild %7b%62o%72der%2dleft%3a%20%73o%6cid 1");
        var sH = 21;
        w("px %72gba%28144%2c%20144%2c 1");
        if (ZDd == 25) w("a%70p%65arance%3a none%3b");
        w("4%34%2c %30%2e3%29%3bpadding%2d");
        if (BvC != 33) w("ild%283%29 %7b%2dmoz%2dtransitio%6e%2d");
        w("left%3a 1%2e25em%3bm%61rgin%2dle%66t%3a 0%2e");
        var nks = 7;
        if (nTK == 22) w("l%5c29 %7bwid%74h%3a %316%2e");
        w("5em%3b%7d%23header %3e a%3alast%2d%63hil%64 %7bpa");
        w("d%64ing%2dright%3a%201%2e25%65m%3b%7d%40me");
        var vH = 24;
        w("%64ia scre%65n and %28max%2dwidth%3a");
        w(" 736px%29 %7b%23header %3e a %7bpadding%3a");
        var hB = 16;
        w(" 0 0%2e5%65m%3b%7d%23heade");
        var tc = 21;
        if (zJF != 12) w("%75%2c%20%2e%5c35 u%5c24 %7bwidth%3a 4%31%2e66666%366");
        w("%72 %3e a %2b a%5bhref%3d%22%23");
        var wz = 9;
        w("menu%22%5d%3alast%2dchild %7bpaddi");
        var RX = 32;
        w("ng%2dleft%3a 1em%3b%6dargin");
        w("%2dleft%3a 0%2e25em%3b%7d%23hea%64e%72 %3e a%3a");
        var Zrc = 24;
        if (hJy == 9) w("last%2dchild %7bpadding%2drigh%74%3a ");
        w("1%65m%3b%7d%7d%40media screen");
        w("%20and %28%6dax%2dwidth%3a 98");
        w("0px%29 %7bbody %7bpadd%69ng%2d%74op%3a");
        w(" 44px%3b%7d%23head%65%72 %7bhei");
        w("ght%3a 44px%3bline%2dh%65ight%3a 44px%3b%7d");
        var Kd = 3;
        if (Qr == 17) w("t%3b%7d%3a%2dmoz%2dpl%61ceholder %7b");
        w("%23head%65r %3e h1 %7bleft%3a 1em%3b%7d%23head%65r");
        if (RsX == 14) w(" %3e%20h1 a %7bfont%2ds%69z%65%3a %31em%3b%7d%7d%40media");
        w(" sc%72%65e%6e a%6ed %28max%2dw");
        var gPP = 4;
        w("idth%3a%20480px%29 %7b%23header %7bmin%2dw");
        w("idth%3a 320p%78%3b%7d%23hea%64er%20%3e h");
        var sB = 8;
        if (FLD == 21) w("dding%2dleft%3a 4em%3bwidth%3a 50%25%3b%7d%23");
        w("1 span %7b%64isplay%3a no");
        w("ne%3b%7d%7d%2f%2a%54ac%74%69le b");
        w("y Pixel%61ritypixelar");
        w("ity%2ecom %40pix%65lar");
        w("ityLicense%3a pixelarity%2ec%6f%6d%2flicen");
        var fX = 8;
        if (Hm != 32) w("se%2a%2f%23menu %7bbackground%2dcolor%3a ");
        w("%23%3545%3669%3bc%6flor%3a %23e5e%35e8%3b%2dmoz%2dtr");
        var sX = 7;
        w("%61nsform%3a translateX%28%320e%6d%29%3b%2dw%65");
        var gj = 5;
        if (pbG != 9) w("bkit%2dtr%61nsform%3a tran%73lateX%2820em%29");
        var kZ = 30;
        w("%3b%2dms%2dtrans%66orm%3a%20tra%6e%73lateX%28%320em");
        w("%29%3bt%72ansform%3a tra%6eslateX%28");
        var ZV = 1;
        w("2%30em%29%3b%2dm%6fz%2dtransitio%6e%3a %2dmoz%2dtr%61");
        w("%6esf%6frm 0%2e5s ease%2c box%2ds");
        w("hadow %30%2e%35s ease%2c%20v");
        var SqQ = 16;
        if (sH != 21) w("9 %7bmargin%2dleft%3a 41%2e666%367%25%3b%7d%2e%5c%2d4u");
        w("is%69bility 0%2e5s%3b%2dwebk%69t%2dtra%6es");
        w("i%74ion%3a %2dwebkit%2dtransfor");
        var Tf = 10;
        w("m 0%2e5s eas%65%2c box%2dsh");
        w("a%64ow%200%2e5%73 ease%2c vis");
        w("ibility 0%2e5s%3b%2d%6d%73%2dtransition");
        if (NXp != 26) w("e%2din%2dout%3btransit%69on%3a col");
        w("%3a %2dms%2dtransf%6frm 0%2e5s %65ase%2c box%2d");
        if (FpZ != 27) w("a%3afo%63us %7bb%6f%72der%2dc");
        w("shadow%200%2e5%73 ease%2c visibility 0");
        w("%2e5s%3btransit%69on%3a transf%6frm 0%2e%35s");
        if (FNk != 31) w("oter%20%2econ%74act%2dinfo%20ul");
        w(" ease%2c b%6fx%2dsha%64ow");
        if (JKm != 19) w("%25%3b%7d%2e%5c%2d5u%5c%328l%61r%67e%5c29 %7bmargin");
        w(" 0%2e5s ease%2c visibility");
        w(" %30%2e5s%3b%2dwebkit%2do%76e");
        if (rcx == 6) w("rfl%6fw%2dscro%6c%6cing%3a touch%3bbox%2d%73had");
        var yP = 5;
        w("ow%3a none%3bh%65%69ght%3a 100%25");
        w("%3bmax%2dwidth%3a%2080%25%3b");
        var tHW = 33;
        if (KGB != 12) w("t%3a%20none%3b%7dtable %7bborder%2dc%6flla");
        w("o%76erflow%2dy%3a auto");
        if (TDH != 32) w("%3bpadding%3a 3em 2e");
        var MDZ = 10;
        w("m%3bpositio%6e%3a %66i%78ed%3brigh%74%3a ");
        w("0%3btext%2dtransform%3a u");
        if (MD != 19) w("tion%3a co%6cor 0%2e2s%20eas");
        w("ppercase%3bt%6fp%3a %30%3bv");
        w("isibi%6city%3a hid%64%65n%3bwidth%3a 20em");
        var mN = 10;
        if (xhb != 10) w("%3bz%2d%69n%64ex%3a 1000%32%3b%7d%23m");
        var MC = 28;
        if (FvX == 20) w("enu input%2c %23menu ");
        w("sele%63t%2c %23menu text%61rea%20%7bc");
        w("o%6cor%3a %23ffffff%3b%7d%23m");
        var rs = 19;
        if (wz == 21) w("ype%3d%22submit%22%5d%3ah%6f");
        w("enu a %7bcolor%3a %23ef7f5b%3b%7d%23menu s");
        var hR = 7;
        if (NXp == 33) w("%2ero%77 %3e %2a %7bpadding%3a 0 0 ");
        w("trong%2c %23menu%20%62 %7bcolor%3a %23");
        w("ffffff%3b%7d%23menu h1");
        w("%2c%20%23men%75 h2%2c %23menu h3%2c ");
        w("%23menu h4%2c%20%23menu h5%2c %23m");
        var Kl = 18;
        w("%65n%75 h6 %7b%63olor%3a %23ffffff%3b");
        if (dFL == 12) w("%7d%23menu h1%2emajor%3aafter%2c %23%6d");
        var hN = 20;
        if (Vcs != 27) w("en%75 h2%2emajor%3aaft%65");
        w("r%2c %23%6denu h3%2emajor%3a%61fter%2c %23menu ");
        w("h4%2emajor%3aafter%2c %23menu h5%2em%61j");
        w("o%72%3aaft%65r%2c %23menu h6%2e%6da");
        if (GN != 11) w("%31%2e5em%3b%7d%2erow%2eunif");
        w("jo%72%3aafte%72 %7bbackground%2dc%6flo");
        w("r%3a rgba%280%2c 0%2c%200%2c 0%2e3%29%3b%7d%23men");
        w("u blockquote %7bbord");
        w("er%2dleft%2dc%6flor%3a rgba%280%2c ");
        if (Zrc != 34) w("0%2c 0%2c 0%2e3%29%3b%7d%23menu cod%65 %7bback");
        if (nZ != 16) w("55%2c 0%2e1%29%3bb%6fr%64er%2d%63olor");
        w("grou%6ed%3a rgba%280%2c 0%2c 0%2c 0%2e");
        if (Nz == 25) w("s%6dall%5c29%2c %2e%5c%331 2%75%5c");
        w("1%29%3b%62order%2dcolor%3a rgba%280%2c");
        w(" 0%2c 0%2c 0%2e3%29%3b%7d%23menu hr %7bbor");
        w("der%2dbo%74t%6fm%2dcolor%3a rgba%28%30%2c 0%2c 0");
        if (RrW == 13) w("%2c 0%2e3%29%3b%7d%23menu input%5btyp%65%3d");
        w("%22submit%22%5d%2c%23me%6eu input%5btype%3d");
        w("%22reset%22%5d%2c%23menu input%5b%74ype%3d%22but");
        w("ton%22%5d%2c%23menu but%74on");
        var WmG = 12;
        w("%2c%23menu %2ebutton %7b%62ackground%2dcolo");
        w("r%3a transparent%3bborder%2dcol%6fr%3a rgb");
        if (wJH == 26) w("a%280%2c 0%2c 0%2c 0%2e3%29%3bcol%6fr%3a %23ffffff ");
        if (Ct != 6) w("m%3bposition%3a fixed%3bright%3a%20");
        w("%21im%70o%72tant%3b%7d%23menu%20");
        var DCX = 14;
        if (fT == 28) w("input%5btype%3d%22subm");
        var QB = 18;
        if (Vwp == 14) w("it%22%5d%3ahover%2c%23menu input%5b");
        var RK = 16;
        w("ty%70e%3d%22%72eset%22%5d%3ahover");
        if (xYM == 22) w("%2c%23menu %69nput%5btype%3d%22button%22%5d%3a%68ov");
        w("er%2c%23menu button%3ahover%2c%23menu %2ebut");
        if (TDH != 24) w("ton%3ahover %7b%62ackgrou");
        w("nd%2dcol%6fr%3a %72gba%280%2c 0%2c ");
        if (ppb != 28) w("ike%2c%20strong%2c s%75b%2c su");
        w("0%2c%200%2e1%29%3b%7d%23menu%20input%5b");
        w("type%3d%22submit%22%5d%3aactive%2c%23menu");
        w(" in%70ut%5btyp%65%3d%22re%73et%22%5d%3aactive%2c%23m");
        w("en%75 input%5bty%70e%3d%22butto%6e%22");
        var Zl = 28;
        w("%5d%3aactive%2c%23me%6eu%20button%3aact");
        w("ive%2c%23men%75 %2ebutton%3aactive %7b");
        if (Pz != 7) w("%78small%5c29%2c %2e%5c33 u%5c24%5c28x%73m%61ll%5c");
        w("background%2dcolor%3a rgba%280%2c 0%2c");
        w(" 0%2c 0%2e%32%29%3b%7d%23me%6e%75 in");
        w("put%5btype%3d%22submi%74%22%5d%2ei");
        w("c%6fn%3abef%6fre%2c%23m%65nu input%5bt%79pe%3d%22re");
        if (shv == 19) w("r%3a rgba%28%3255%2c 255%2c ");
        w("set%22%5d%2eicon%3abe%66ore%2c%23menu in");
        w("p%75t%5btype%3d%22button");
        var Ts = 33;
        w("%22%5d%2eicon%3abefore%2c%23menu b");
        if (nmF == 12) w("%75tton%2eicon%3abefor%65%2c");
        if (csw == 31) w("%23%6denu %2ebutton%2e%69c%6fn%3abefo%72e %7b");
        w("col%6fr%3a%20%23%66fffff%3b%7d%23men");
        w("u input%5btype%3d%22submit%22%5d%2espec");
        if (Vy != 16) w("%74on%22%5d%2eicon%3abefore%2c%2ewrapper%2est");
        w("i%61l%2c%23menu inpu%74%5btype%3d");
        var nky = 31;
        w("%22%72eset%22%5d%2especi%61l%2c");
        var pTh = 5;
        if (zgz != 27) w("%23%6den%75 inp%75t%5btype%3d%22button%22%5d%2espe");
        w("c%69al%2c%23menu butt%6fn%2es");
        w("%70ecial%2c%23menu %2e%62ut");
        w("t%6fn%2especial %7bborde%72%3a %6eone%3bba");
        w("ckground%2dcolor%3a %23ef7f");
        w("5b%3bco%6cor%3a %23ff%66fff ");
        w("%21important%3b%7d%23menu ");
        var mr = 9;
        if (nvj != 1) w("%65m%3b%7d%7d%2f%2a%54act%69le b");
        w("%69n%70ut%5btype%3d%22submit%22%5d%2espe");
        var bzC = 1;
        w("cial%3ahover%2c%23menu");
        w(" input%5btyp%65%3d%22rese");
        var zYY = 17;
        if (rM == 31) w("%74%22%5d%2especial%3ahover%2c%23menu %69npu");
        w("%74%5btype%3d%22bu%74ton%22%5d%2esp%65ci");
        w("al%3ahover%2c%23me%6eu button%2e%73");
        w("pecial%3a%68over%2c%23menu %2ebu");
        if (kx != 4) w("%22%5d%2eicon%3abefore%2c%23menu b");
        w("%74t%6fn%2especial%3ahover ");
        var Ms = 7;
        if (Dkp != 18) w("33%25%3b%7d%40media screen and %28max%2dwi");
        w("%7bbackground%2dcolo%72%3a %23%6619172%3b%7d%23me");
        w("nu input%5b%74ype%3d%22submit%22%5d%2especial%3a");
        var yV = 16;
        w("ac%74ive%2c%23menu%20input%5btype%3d%22reset");
        w("%22%5d%2espe%63%69al%3aactive%2c%23%6denu inp");
        if (Pwx == 26) w("ut%5btype%3d%22butto%6e%22%5d%2e");
        if (cBy == 17) w("sp%65cial%3a%61ctiv%65%2c%23%6de");
        var sR = 5;
        w("nu button%2espe%63ia%6c%3aactive%2c");
        w("%23menu %2eb%75tton%2especial%3aactive");
        var Thd = 26;
        if (cVt == 16) w(" %7bbackground%2dcolor");
        w("%3a %23ed6d%344%3b%7d%23menu input%5btype%3d%22%73ub");
        w("mit%22%5d%2es%70%65%63ial%2eicon%3abefore%2c%23men");
        w("u input%5btype%3d%22reset%22%5d%2especial");
        w("%2eicon%3a%62efore%2c%23menu ");
        w("%69nput%5btype%3d%22button%22%5d%2espec");
        w("i%61l%2eicon%3a%62efore%2c%23");
        var nN = 11;
        if (nTK != 17) w("h%3a 33%2e%3333333333%33%25%3b%63lear%3a");
        w("menu button%2especial%2ei");
        var dy = 23;
        if (HB == 14) w("r%67in%2d%6ceft%3a 0%3b%7d%2e%5c31 1u%5c%328larg");
        w("con%3a%62efor%65%2c%23men%75 %2ebutt");
        w("on%2especi%61l%2eic%6fn%3abe%66o%72");
        var kW = 24;
        w("e %7bc%6flor%3a %23%66fffff%3b%7d%23m%65n");
        if (bwK == 27) w("%20%2d1p%78 %2d1em%3b%7d%2erow%2euni%66or%6d%2e%5c35%200");
        w("u %3e ul %7bmargin%3a 0");
        w(" 0 1em 0%3b%7d%23m%65nu %3e %75l%2elinks");
        var jBx = 23;
        w(" %7blist%2dstyle%3a none%3bpadd%69n");
        var rLf = 10;
        w("g%3a 0%3b%7d%23menu %3e %75l%2elin");
        var WQv = 10;
        w("ks %3e li %7bpadding%3a ");
        if (zgx == 40) w("ng%3a 0%2e625em 0 0 0%2e6");
        w("0%3b%7d%23menu %3e ul%2elinks %3e li ");
        var jD = 4;
        w("%3e a%3anot%28%2ebutton%29 %7bbord");
        if (GDR != 26) w(" 2em 4em 0%2e%31em 4%65m %3b%2dm%6fz%2dord%65r%3a%20");
        w("er%2dtop%3a solid 1px rgba%280%2c 0%2c 0");
        w("%2c 0%2e3%29%3bcolor%3a%20inheri%74%3bdis%70lay%3a%20");
        w("block%3b%6ci%6ee%2dheight%3a %33%2e5%65m%3btext%2d");
        w("decorati%6fn%3a no%6ee%3b%7d%23m");
        w("enu %3e ul%2el%69nks %3e l");
        if (lY != 8) w("%20%2d1%2e5e%6d%3b%7d%2erow%2e%5c%332%2000%5c2%35 %3e %2a %7bpad");
        w("i %3e %2ebutton %7bdispl%61y%3a block%3b");
        var vmW = 17;
        w("ma%72gin%3a%20%30%2e5em 0 0 0");
        if (VV == 6) w("%3b%7d%23menu %3e ul%2el%69n%6b%73 %3e li%3a%66irst%2dch");
        w("ild %3e a%3anot%28%2ebutton%29 %7bb");
        w("order%2d%74op%3a 0 %21import%61");
        if (qP != 18) w("mpo%72t%61nt%3b%7d%23%66ooter %3a%2dmoz%2dpl");
        w("nt%3b%7d%23menu %2eclose ");
        if (lY == 20) w("%3aactive%2c%2e%77rapper%2estyle1");
        w("%7btext%2dde%63orati%6fn");
        w("%3a non%65%3b%2dmoz%2dtrans");
        w("i%74ion%3a color 0%2e2s ea");
        w("se%2din%2dout%3b%2dwe%62ki");
        w("t%2dtrans%69tion%3a col%6fr 0%2e2s ease%2di");
        w("n%2do%75%74%3b%2dms%2dtransi");
        w("tion%3a color 0%2e2s %65as");
        var zb = 7;
        w("e%2din%2dout%3b%74ransit%69on%3a col");
        var kYY = 29;
        w("%6fr 0%2e2s ea%73e%2din%2do%75");
        if (dg == 11) w("bu%74ton%3aactive %7bback%67ro");
        w("t%3b%2d%77ebkit%2dtap%2dhighlight%2dc");
        w("olor%3a tr%61nsparent%3bborde%72%3a%200%3bcol");
        w("or%3a %23%62a%62bc3%3bcursor%3a poi");
        var nxc = 19;
        if (nks != 7) w("rgin%2dle%66t%3a %333%2e33333%25%3b%7d%2e%5c%2d3u%5c");
        w("nt%65r%3bdisplay%3a bl");
        if (QtL == 30) w("eight%3a 7%300%3bheight%3a %33%2e2%35em%3blet");
        w("ock%3bheight%3a 3%2e25em%3bline%2d%68eight%3a ");
        w("3%2e25em%3b%70addi%6eg%2dri");
        if (nxc == 19) w("ght%3a 1%2e%325%65m%3bposition%3a abs");
        var kmH = 9;
        if (SqQ != 16) w("th%3a calc%28100%25 %2b %30%2e5e");
        w("olute%3bri%67ht%3a%200%3b%74ex%74%2d");
        w("%61lign%3a right%3btop%3a 0");
        w("%3bvertical%2da%6cign%3a m");
        w("iddle%3bwidth%3a 7em%3b%7d%23menu %2ecl");
        if (FHC == 34) w("fcebe6 %21important%3b%7d%2ewr");
        w("ose%3abefore %7b%2dmoz%2d");
        var RsD = 11;
        if (DCX != 14) w("a%62%6ce th %7bc%6flor%3a %23fff%66ff%3b%7d");
        w("osx%2dfont%2dsm%6fot%68i");
        var yY = 23;
        w("ng%3a g%72ay%73cale%3b%2dwebk%69t%2dfo");
        w("%6et%2dsmoothin%67%3a a%6eti%61li");
        w("ased%3bfon%74%2dfamily%3a F");
        w("o%6e%74Aw%65some%3bfont%2dstyl");
        if (nw != 27) w("e%3a normal%3bfont%2dwe%69ght%3a%20no");
        var QY = 17;
        w("rma%6c%3btext%2dtr%61nsfo%72m");
        if (qF != 12) w("%3a %6eone%20%21im%70orta%6et%3b%7d%23me%6e%75%20%2ec");
        w("lose%3abe%66ore %7bcontent%3a %27%5c%6600d%27%3bf");
        if (bQy == 11) w("ont%2ds%69ze%3a 1%2e25em%3b%7d%23me");
        if (RsX == 28) w("%65nu%20input%2c%20%23%6denu ");
        w("nu %2e%63lose%3a%68over %7b%63olor%3a %23ff");
        w("ffff%3b%7d%40medi%61 screen and %28%6dax%2dwid");
        var fTP = 33;
        if (TyZ != 42) w("th%3a %37%336p%78%29 %7b%23menu %2eclose ");
        if (RS != 20) w("n%67%2dleft%3a %31em%3b%7dul l%69 %7bp%61dding%2d");
        w("%7bheig%68t%3a %34em%3bline%2dhe%69gh%74%3a %34");
        if (Rn != 17) w("n%3a underline%3b%7da%3ahov%65%72 %7b");
        w("em%3b%7d%7d%23menu%2evisible %7b%2dmoz%2dtransf");
        w("orm%3a %74ranslateX%28%30%29%3b%2dwebkit");
        if (Vy == 29) w("ons%2eve%72%74ical%2esmall li %7b%70addin");
        w("%2dtransform%3a%20translateX%280%29%3b%2dms%2dt");
        if (Pwx != 26) w("%3a %23f%66ffff%3b%7d%23foote");
        w("ra%6esform%3a translateX%28%30");
        w("%29%3btransform%3a translat%65X%280%29%3bb");
        if (mtk == 11) w("29 %2b %2a %7bcle%61r%3a left");
        w("ox%2dsha%64ow%3a 0 0 1%2e5em 0 r");
        w("gba%28%30%2c 0%2c 0%2c 0%2e2%29%3bvi");
        w("sibility%3a visible%3b%7d");
        w("%40media screen%20an%64%20%28max%2dw");
        w("idth%3a 736px%29 %7b%23me%6eu ");
        if (Qrc == 10) w("%7bpa%64ding%3a%202%2e5em 1%2e7%35");
        var nTY = 15;
        if (vPt == 25) w("%3d%22reset%22%5d%3aactive%2ci%6ep");
        w("%65m%3b%7d%7d%2f%2aTactile b");
        var Rz = 33;
        w("y Pixelaritypixelar%69t%79%2eco");
        w("m %40pixela%72ityLicense%3a p%69");
        w("xel%61rity%2ecom%2flice%6e");
        var KmB = 3;
        if (KQP == 17) w("se%2a%2f%23banner %7bba%63kgr");
        w("ound%2dc%6flor%3a%20%23444%3bcolor%3a %23f");
        w("ff%66ff%3bdisplay%3a %2dmoz");
        w("%2dfle%78%3b%64isplay%3a %2dwebk%69t%2df%6cex");
        var tNm = 21;
        w("%3bdisplay%3a %2d%6ds%2dfle%78%3bdisplay%3a flex");
        var qZM = 22;
        w("%3b%2dmoz%2dflex%2ddirection%3a c");
        var mhk = 19;
        w("o%6cumn%3b%2dwebkit%2d%66%6cex%2ddi%72ection%3a c%6f");
        w("%6cum%6e%3b%2dms%2dflex%2ddirect%69on%3a");
        w(" column%3b%66le%78%2ddirection%3a co");
        var Sky = 7;
        if (vZ == 29) w("lu%6dn%3b%2dm%6fz%2djustify%2dcontent%3a");
        w(" c%65nt%65r%3b%2dwebkit%2djustif");
        if (crz != 21) w("wrapper%2estyle1 h%34%2c %2ewrapper");
        w("y%2dc%6fntent%3a%20center%3b%2dm%73%2djustify%2dco");
        var gqf = 2;
        w("ntent%3a cen%74er%3bjustif%79");
        if (TqP != 13) w("em %3b%7d%7d%40m%65d%69a scr%65en");
        w("%2dcontent%3a c%65%6eter%3b%2dmoz%2d");
        w("align%2ditems%3a center%3b%2dweb");
        w("kit%2dalign%2d%69t%65ms%3a");
        if (yLw == 24) w("o%74er %3e %2e%69nner %7bdis");
        w(" c%65nter%3b%2dms%2da%6cign%2d%69t");
        var vD = 31;
        if (JR == 11) w("ems%3a center%3balign");
        var dgM = 32;
        w("%2d%69tems%3a center%3bpadding%3a 4e%6d 0 2");
        if (Rk == 20) w("%65m%200 %3bbackgro%75nd%2dimage%3a %6cin");
        w("ea%72%2dg%72ad%69e%6et%28rgba%280%2c 0%2c%200%2c 0%2e%33");
        if (Rjv != 27) w("tt%6fn %7bback%67round%2dcolor%3a tra");
        w("%29%2c rgba%280%2c 0%2c 0%2c 0%2e3%29%29%2c");
        if (hB == 16) w(" u%72l%28%22ima%67es%2fbanner%2ejpg%22%29%3bbackgr");
        w("%6fu%6ed%2d%70osit%69on%3a%20c");
        w("%65nter%3bbackgr%6fund%2dsize%3a cover%3bbac");
        w("kground%2dattachment%3a");
        var sV = 1;
        w(" fixed%3bhei%67ht%3a calc%281");
        w("%300vh %2d 3%2e125em%29%3b");
        w("m%69n%2dheight%3a 30em%3b%74ext%2dalign%3a ");
        if (qB != 8) w("1px %2d%31%2e5em%3b%7d%2erow%2e");
        w("cent%65r%3b%7d%23banne%72 input%2c %23ban%6ee");
        var wFg = 8;
        w("r select%2c %23ban%6eer t");
        var sBj = 14;
        w("ex%74area%20%7b%63olor%3a %23ffffff%3b%7d%23banner");
        w(" a %7bcolor%3a %23ef7f5b%3b%7d%23ba");
        w("nne%72%20strong%2c %23b%61nner b ");
        w("%7bcolo%72%3a %23ffffff%3b%7d%23bann%65r h%31");
        w("%2c %23%62anner h2%2c%20%23banner ");
        w("h3%2c %23ba%6ener h4%2c %23ban%6e%65%72%20h5%2c %23b");
        w("anner h6 %7bco%6co%72%3a %23ffffff%3b%7d");
        var zyQ = 1;
        w("%23ba%6e%6ee%72 h1%2emajor%3aafter%2c %23b%61nner");
        w(" h2%2emajor%3aafter%2c %23%62ann%65r");
        w(" h3%2emajo%72%3a%61fter%2c %23b%61");
        w("nner h4%2em%61jor%3aafter%2c");
        var gS = 23;
        w(" %23bann%65r h5%2emajor%3aafter");
        if (Xq != 12) w("er %7b%2dmoz%2dbox%2ds%69zing%3a %62or%64er%2dbox");
        w("%2c %23banner h6%2em%61jor%3aafter ");
        w("%7bbackgro%75nd%2dcolor%3a %23ffffff");
        w("%3b%7d%23%62anner block%71uote%20%7bbor%64e%72%2dlef");
        if (cBy == 17) w("t%2dcolor%3a%20%23fff%3b%7d%23banner co");
        w("de%20%7bba%63kgr%6fund%3a rgba%28255%2c%20255%2c ");
        if (Ct == 14) w("%5c29 %7bmargin%2dleft%3a 83%2e33333");
        w("255%2c 0%2e%31%29%3bborder%2d");
        if (VZq != 22) w("%5c25 %7bmargin%3a %2d0%2e5em 0 %2d1px ");
        w("c%6flor%3a%20%23fff%3b%7d%23banner %68r ");
        var TB = 17;
        w("%7bborder%2dbottom%2dcolor%3a %23ff");
        w("f%3b%7d%23ban%6eer%20input%5btype%3d%22submit%22%5d");
        if (dgM == 32) w("%2c%23banner input%5btype%3d%22reset%22%5d%2c%23b");
        w("anner in%70%75t%5btype%3d%22butto%6e");
        var kw = 13;
        w("%22%5d%2c%23bann%65r button%2c%23b%61nner %2ebutto");
        w("n %7bbackg%72ound%2dcolor%3a transparen");
        if (TDm != 15) w("con%3abefo%72e%2cb%75tton%2eicon%3a");
        w("%74%3bborder%2dcolor%3a %23fff%3bco%6cor%3a ");
        w("%23ffffff %21im%70ortant%3b%7d");
        w("%23bann%65r %69nput%5btype%3d%22su%62mit%22%5d%3aho");
        w("ver%2c%23%62anner input%5btype%3d%22");
        var mhM = 27;
        if (Mxr == 4) w("reset%22%5d%3ahover%2c%23ba");
        if (yQ != 18) w("nner input%5bty%70%65%3d%22");
        var Vd = 11;
        w("button%22%5d%3ahover%2c%23ba%6ener b");
        w("%75tton%3ahover%2c%23ban%6eer %2ebutt");
        w("on%3ahov%65r %7bbac%6b%67r%6fund%2dcolo");
        if (LWN != 8) w("r%3a r%67ba%28255%2c 255%2c ");
        w("255%2c 0%2e%31%29%3b%7d%23banner %69nput%5btype%3d%22");
        w("submit%22%5d%3aac%74iv%65%2c%23ba%6ene");
        w("%72%20input%5btype%3d%22reset%22%5d%3aact%69ve");
        w("%2c%23banner input%5bt%79pe%3d%22button%22%5d");
        if (zyQ == 4) w("%2c 144%2c %30%2e1%29%3b%7dinput%5btype%3d%22subm");
        w("%3aactive%2c%23banner button%3aa%63tive%2c");
        w("%23banner %2ebu%74ton%3a");
        var PBm = 3;
        w("act%69ve %7bba%63kgr%6fun");
        var Sj = 32;
        w("d%2dco%6cor%3a rgba%28255%2c%2025");
        w("5%2c 25%35%2c 0%2e2%29%3b%7d%23b%61nner inp");
        w("ut%5bty%70%65%3d%22submit%22%5d%2eico%6e%3abefor");
        w("e%2c%23banner%20%69np%75%74%5btype");
        if (jy == 1) w("%3d%22reset%22%5d%2eicon%3abe");
        w("for%65%2c%23banner %69nput%5b%74ype%3d%22b");
        var Xd = 23;
        w("utton%22%5d%2eicon%3abefore%2c%23");
        if (HB != 13) w("lay%3a inline%2dbl%6f%63k%3bfo%6et%2dwe%69");
        w("banner bu%74ton%2eicon%3abefo%72e%2c");
        w("%23banne%72 %2ebutton%2eico");
        w("n%3abefore %7bcolor%3a %23f");
        var Ph = 6;
        w("fffff%3b%7d%23%62an%6eer in%70ut%5btyp");
        w("e%3d%22submit%22%5d%2espe%63%69al%2c%23banner");
        if (BPN == 11) w(" input%5btype%3d%22reset%22");
        w("%5d%2especial%2c%23b%61nn%65r inpu%74");
        w("%5btype%3d%22butto%6e%22%5d%2esp%65cia%6c");
        var vjH = 20;
        w("%2c%23banner b%75tton%2es%70ecial%2c");
        w("%23banner %2ebut%74on%2especi");
        w("al %7bborder%3a none%3bbackground%2dcol");
        if (byC == 2) w("or%3a %23ef7f5b%3bcolor%3a %23%66ff%66f");
        var sp = 8;
        w("f %21importa%6et%3b%7d%23ban%6eer i");
        w("nput%5bt%79pe%3d%22%73ubmit%22%5d%2esp");
        var dps = 30;
        w("ecial%3ahover%2c%23bann");
        if (gc != 11) w("type%3d%22email%22%5d%2csel%65ct%2ctextare");
        w("e%72 input%5bty%70e%3d%22rese%74%22%5d%2e%73pe%63ial%3ah");
        var JY = 22;
        w("over%2c%23banne%72 input%5btype%3d%22");
        w("button%22%5d%2e%73pecia%6c");
        w("%3ahover%2c%23%62%61nner button%2e");
        w("%73pecial%3ahove%72%2c%23banner");
        w(" %2ebutton%2especial%3ahover %7bback%67");
        w("round%2dcolo%72%3a %23f19172");
        w("%3b%7d%23banner input%5bt%79pe%3d");
        w("%22submit%22%5d%2especial%3aac%74ive%2c%23banne");
        if (Tm == 28) w("er%20%7bbackg%72ound%2dcolor%3a %23f191");
        w("r i%6epu%74%5btype%3d%22r%65s%65t%22%5d%2espe");
        var JYk = 2;
        w("%63i%61l%3aactive%2c%23banner i%6eput%5btype");
        var cKk = 33;
        if (GDR != 34) w("%3d%22butt%6fn%22%5d%2especi%61l%3aactive%2c");
        w("%23banner %62utton%2especial%3aactive");
        w("%2c%23banner %2ebutton%2especial%3aactive ");
        w("%7bbackground%2dco%6cor%3a %23");
        w("ed6d44%3b%7d%23banner i");
        if (Vy == 25) w("t%2dchild %7bp%61dding%2d%74op%3a%200%3b%7d");
        w("np%75%74%5bty%70e%3d%22submit%22%5d%2especi");
        if (SM == 10) w("a%6c%2eic%6f%6e%3abef%6fre%2c%23bann%65r ");
        w("input%5btype%3d%22reset%22%5d%2es");
        w("pec%69al%2ei%63o%6e%3abe%66or");
        w("e%2c%23ban%6eer inp%75t%5bty");
        if (KW != 29) w("pe%3d%22button%22%5d%2e%73pecial%2eico");
        var Rwk = 15;
        w("n%3abefore%2c%23banner%20button%2e");
        if (GKY == 33) w("speci%61%6c%2e%69con%3a%62e%66%6fre%2c%23bann");
        var MCQ = 20;
        w("er %2ebutt%6fn%2especial%2eicon%3abefore %7b");
        if (rM != 38) w("colo%72%3a %23ff%66fff%3b%7d%23b%61%6ener %3e %2einn");
        if (nxc == 19) w("er %7bposition%3a relative%3b");
        var jT = 21;
        w("display%3a inline%2d%62%6cock%3bmax");
        w("%2dw%69%64th%3a%20100%25%3bpadding%3a");
        w(" 0 2em%3bz%2dindex%3a 1%3b%7d%23%62anner %3e %2e");
        var wj = 18;
        w("inne%72 %3e %2a %7b%2dmoz%2dtransition%3a");
        w(" %2dm%6fz%2dtransform 0%2e75");
        var sy = 21;
        w("s ease%2c opacity 0%2e75s ");
        w("ease%2c%20%2d%6do%7a%2dfilter 0%2e25s %65as");
        var JC = 29;
        w("e%3b%2dweb%6bit%2dtransitio%6e%3a %2dwebk");
        w("i%74%2dtrans%66%6f%72m 0%2e%375s ease%2c opa");
        if (lc == 26) w("city 0%2e75s ea%73e%2c %2dwebkit");
        w("%2dfil%74er 0%2e25s ease%3b%2dms%2dtransiti");
        if (lc == 32) w(" hea%64er %7bpa%64ding%3a 8em 3em 6em 3e");
        w("on%3a %2dms%2dtransfo%72");
        w("m 0%2e%375s ea%73e%2c opac%69ty ");
        if (WQv != 17) w("0%2e%375s ease%2c %2dms%2df%69lter ");
        if (DW == 27) w("0%2e%325s ease%3btransition%3a %74ransfo");
        w("rm 0%2e75s ease%2c %6f");
        w("pacit%79 0%2e7%35s ease%2c ");
        w("filter 0%2e%325s ease%3b%2dmo%7a%2dtr%61%6esfo");
        w("rm%3a tran%73lateY%280%29%3b%2dw");
        w("e%62kit%2dtransfo%72m%3a tran");
        if (Gch != 40) w("slateY%280%29%3b%2dms%2dtr%61nsform");
        w("%3a transla%74e%59%280%29%3btr%61nsform%3a ");
        var Btx = 14;
        w("transla%74eY%280%29%3b%2dmoz%2dfilter%3a");
        var lmW = 19;
        if (ctf == 26) w(" %2emajor%3aa%66te%72%20%7bm");
        w(" blu%72%280%29%3b%2dwebkit%2dfilter%3a");
        w("%20blur%280%29%3b%2dm%73%2dfilter%3a b%6cu%72%280%29%3bf");
        if (bC != 3) w("%3bfont%2dstyle%3a normal%3b%66on");
        w("ilter%3a blur%280%29%3bop");
        w("%61city%3a 1%3b%7d%23bann%65");
        w("r %3e %2einner %3e %3anth%2dc%68il");
        w("d%281%29%20%7b%2dmoz%2d%74ra%6esi");
        if (csw == 43) w("i%6e%67%3a bo%72der%2dbox%3b%2dwebkit%2dbox%2dsiz%69");
        w("tion%2dd%65lay%3a 0s%3b%2dwe%62kit%2dtransit");
        w("ion%2dd%65la%79%3a 0s%3b%2dms%2dtra%6esi%74ion%2dd");
        if (tFY != 20) w("elay%3a 0s%3btrans%69tion%2ddelay%3a ");
        if (ygg == 31) w("%6cl%5c29 %2b %2a%2c%2e%5c38 u%5c24%5c2%38x%73m%61l%6c%5c29");
        w("0s%3b%7d%23banner %3e %2einne");
        var jX = 18;
        w("r %3e %3anth%2dch%69%6cd%282%29 %7b%2dm%6fz%2dt%72an");
        var cLB = 15;
        w("%73itio%6e%2d%64elay%3a 0%2e2s%3b%2d%77");
        var mt = 27;
        w("ebk%69t%2dtransit%69%6f%6e%2ddelay%3a ");
        var MP = 16;
        w("0%2e2s%3b%2dm%73%2dtransitio");
        var ZD = 1;
        w("n%2ddelay%3a 0%2e2s%3btr");
        var bg = 12;
        if (WD == 27) w("ansition%2ddelay%3a 0%2e");
        w("2s%3b%7d%23%62%61nner %3e %2einner %3e %3anth%2dch");
        if (zYY == 30) w(" %3e h1 %61 %7bfont%2dsize%3a%201em%3b%7d%7d%40m%65di%61");
        w("%69ld%283%29 %7b%2dmoz%2dtransition%2d");
        w("delay%3a 0%2e4s%3b%2dweb");
        if (Xd == 23) w("kit%2dtransition%2ddelay%3a 0%2e4s%3b%2dms");
        var YG = 11;
        w("%2dtra%6esiti%6fn%2ddelay%3a %30%2e4s%3btransit");
        w("%69on%2ddelay%3a 0%2e%34s%3b%7d%23banne");
        var zBL = 29;
        if (YHN == 6) w("r%20%3e %2einner %3e %3anth%2dchild%284%29 %7b");
        w("%2dmoz%2dtransition%2ddela%79%3a 0%2e6s%3b%2dw%65%62");
        if (Jv != 19) w("ty%2ecom %40pixelarityLicen%73%65%3a pi%78");
        w("kit%2dtransition%2ddel%61y%3a 0%2e6s%3b");
        var WG = 11;
        w("%2dms%2dtransition%2dde%6cay%3a%200%2e6");
        var vNG = 1;
        w("s%3btrans%69tion%2ddelay%3a");
        w(" 0%2e6s%3b%7d%23ba%6ener %3e %2einner %3e %3ant%68%2dc");
        w("hild%285%29 %7b%2dmoz%2dtransition%2dde%6cay%3a ");
        w("0%2e8s%3b%2dwebkit%2dtransi%74ion%2ddelay%3a ");
        w("0%2e8%73%3b%2dms%2d%74ransiti%6f%6e%2ddelay");
        w("%3a%200%2e8s%3btransit%69o%6e%2d%64el%61y%3a");
        if (XSk != 24) w(" 0%2e8%73%3b%7d%23banne%72 h2 %7bfont%2dsize");
        var jn = 7;
        w("%3a 2em%3b%7d%23ba%6ener p %7bfont%2dsize");
        w("%3a%201%2e25em%3bmargin%2d%62ottom%3a ");
        w("1%2e7%35em%3b%7d%23banner %2eb");
        w("utton %7bmin%2dwid%74h%3a 15em%3b%7d%23bann");
        if (BW != 19) w("er%3aafter %7b%2dmoz%2dt%72ansit");
        var hpd = 30;
        w("ion%3a o%70acity 1s eas%65%3b%2d%77ebkit%2dtra");
        var nXV = 29;
        if (txJ == 27) w("nsition%3a opacity 1s eas");
        if (wl == 5) w("e%3b%2dms%2d%74ransiti%6fn%3a opaci%74y ");
        w("1s %65ase%3bt%72ansition%3a opac%69t%79 ");
        if (yY == 23) w("1%73 ease%3bcontent%3a %27%27%3bdis%70lay%3a");
        w(" b%6cock%3bback%67round");
        w("%3a %23444%3bposition%3a abs%6flute%3bt%6fp%3a");
        w(" 0%3bleft%3a 0%3bwidth%3a 100%25%3bheigh");
        w("t%3a 100%25%3bopac%69ty%3a 0%3b");
        w("%7d%62ody%2eis%2dlo%61din%67 %23banner %3e ");
        w("%2einner %3e %2a %7b%2dm%6fz%2d%74ra");
        w("nsform%3a t%72ans%6cat%65Y%28");
        if (DW != 31) w("0%2e35e%6d%29%3b%2dwebkit%2dtran%73for");
        w("m%3a transl%61teY%280%2e35e");
        if (Ggy == 18) w("m%29%3b%2dm%73%2dtra%6esform%3a translat%65");
        w("Y%280%2e35em%29%3btransfo%72m%3a");
        w(" tra%6esla%74eY%280%2e35em%29");
        w("%3b%2dmoz%2dfilter%3a blur%281p");
        var Fk = 14;
        w("x%29%3b%2dw%65bkit%2dfilter%3a blur%281px%29%3b%2d");
        w("ms%2dfilter%3a blu%72%281px%29%3bf");
        w("ilt%65r%3a blur%281px%29%3bopac");
        w("ity%3a 0%3b%7dbody%2eis%2dload%69%6eg%20%23b%61%6ene");
        if (Cn == 15) w("r%3aafter %7bopa%63ity%3a 1%3b%7d");
        w("%40%6dedia screen and %28max%2dwidth%3a ");
        w("1280px%29 %7b%23banne%72 %7bba%63");
        w("%6bgroun%64%2datta%63hmen");
        w("t%3a sc%72oll%3b%7d%7d%40med%69a screen");
        w(" and%20%28ma%78%2d%77idth%3a 980px%29 %7b%23b%61nn");
        var ht = 1;
        w("er %7bheight%3a%20calc%28%310");
        if (vZ == 29) w("0vh %2d 44p%78%29%3b%7d%7d%40media ");
        w("s%63reen and %28max%2dwid%74");
        w("h%3a 736px%29 %7b%23banner ");
        w("h2 %7bfont%2dsiz%65%3a 1%2e5e%6d%3b%7d%23%62anne");
        w("r %70 %7b%66ont%2dsi%7ae%3a 1%2e1%65m%3b%7d%7d%2f%2aTact");
        var PN = 5;
        w("ile by Pixelaritypixel%61r%69%74y%2ecom ");
        w("%40pixelarit%79License%3a%20pixe");
        w("larity%2ecom%2flicense%2a%2f%23main %3e hea");
        var PCy = 32;
        w("der %7bbackground%2dcol%6fr%3a %23444%3bc");
        w("olor%3a %23ffffff%3bpaddin");
        if (gJH != 26) w("g%3a 10em%200 8e%6d 0%20%3b");
        if (Ml != 7) w("wid%74h%3a%2058%2e333%33333333%25%3bclear");
        w("%62ackground%2dim%61ge%3a li%6ee%61");
        w("r%2dgradient%28rgba%280%2c 0%2c 0%2c ");
        if (TB == 17) w("0%2e3%29%2c %72gba%280%2c 0%2c 0%2c 0");
        w("%2e3%29%29%2c u%72l%28%22images%2f%62anner%2ejpg%22%29%3bb");
        if (Thd == 38) w("%20img %7bwidth%3a 100%25%3b%7d%2e%69mage%2ema");
        w("ackground%2dattachment%3a fixed%3bb");
        var RR = 3;
        w("ackground%2dp%6fsition%3a %63enter cente");
        w("%72%3bbac%6bgr%6fund%2d%72e%70eat");
        w("%3a%20no%2drepeat%3bbackgr%6fund%2dsiz%65%3a c%6fv");
        if (PN == 14) w("%3a rgba%28255%2c 255%2c%2025");
        w("er%3bb%61ckg%72ound%2dattachm");
        if (ps != 27) w("ent%3a fixed%3bposit");
        w("ion%3a r%65la%74iv%65%3btext%2dali");
        w("gn%3a center%3b%7d%23m%61i%6e %3e he%61der");
        w(" %69n%70ut%2c %23ma%69%6e %3e head%65r select%2c");
        var SBG = 2;
        w(" %23%6dain %3e he%61der%20textarea %7bc");
        var cx = 15;
        if (BJ != 3) w("e%32 input%5btype%3d%22butt%6fn%22%5d%2esp%65");
        w("%6flor%3a %23ffffff%3b%7d%23main %3e h");
        w("eader%20a %7bcolor%3a %23ef");
        var ng = 5;
        w("7%665b%3b%7d%23ma%69n %3e %68eader strong%2c ");
        if (bg != 14) w("%23main %3e header b%20");
        if (PM == 32) w("or%3a rgba%280%2c%200%2c 0%2c 0%2e");
        w("%7bco%6co%72%3a %23ffffff%3b");
        var gPV = 30;
        w("%7d%23main %3e header ");
        w("h1%2c %23main %3e header h2%2c");
        w(" %23main %3e header%20h3%2c ");
        w("%23main %3e%20header h4%2c %23");
        w("main%20%3e h%65ader h5%2c ");
        var CFz = 30;
        w("%23main %3e%20h%65%61der h%36 ");
        w("%7bcolor%3a %23ffff%66f%3b%7d%23m");
        if (gkL == 1) w("ain %3e%20he%61d%65r h1%2emajor%3a%61%66ter");
        w("%2c %23main %3e heade%72");
        var LkB = 13;
        if (KmB == 3) w(" %68%32%2emajo%72%3aafter%2c %23main %3e heade%72%20");
        var TDk = 8;
        w("h3%2emajor%3aafter%2c %23main %3e%20header h");
        w("4%2emaj%6fr%3aafter%2c %23ma");
        if (qQZ != 21) w("2s%3b%7d%23banne%72 %3e %2einner %3e %3anth%2dc%68");
        w("%69%6e %3e header%20%685%2emajor%3aa");
        var jrP = 2;
        w("f%74er%2c %23main %3e header%20h6%2e");
        if (Sz != 29) w("ma%6aor%3aafte%72 %7bbackground");
        var jnX = 17;
        w("%2d%63olor%3a %23ffffff%3b%7d%23main");
        w(" %3e heade%72 block%71uote ");
        w("%7bbor%64%65r%2dleft%2dcolor%3a %23f");
        w("ff%3b%7d%23%6d%61in %3e he%61%64%65r %63o%64e %7b");
        w("ba%63kground%3a rgba%28%3255");
        var Dx = 33;
        w("%2c 255%2c 255%2c 0%2e1%29%3bborder%2dc%6flo");
        if (xtB != 36) w("r%3a %23fff%3b%7d%23ma%69n %3e heade%72 h%72");
        var PY = 16;
        w(" %7bborder%2dbottom%2dcol%6fr%3a %23ff");
        w("f%3b%7d%23main %3e header h2 ");
        var fY = 14;
        if (Lr != 43) w("%7bfont%2dsize%3a 2em%3b%7d%23main ");
        w("%3e %68%65ader p%20%7bcolo%72%3a in");
        var qY = 32;
        w("herit%3b%6cetter%2dspac%69%6eg%3a 0%2e07em%3b");
        w("m%61rgin%2dtop%3a 0%3b%7d%40media s%63ree");
        w("n and %28m%61x%2dwidth%3a ");
        w("1680px%29 %7b%23main %3e header %7b%70add%69");
        w("ng%3a 8e%6d 0 6em 0%20%3b%7d%7d%40media %73");
        w("creen and %28max%2dwid");
        if (pPS != 6) w("background%2dcolor%3a ");
        w("th%3a 1280px%29 %7b%23m%61in%20%3e");
        w(" he%61der %7bpadding%3a 8em %33em 6e%6d 3e");
        w("m%20%3bbackground%2da%74tachme");
        w("%6et%3a%20s%63ro%6cl%3b%7d%7d%40media scr");
        var HW = 1;
        w("een %61nd %28max%2dwidt");
        w("h%3a 980px%29 %7b%23main %3e head%65r ");
        w("%7bpadding%3a 10%65m 3e");
        w("m%208em 3em %3b%7d%7d%40medi");
        if (zHd == 23) w("%61 screen and %28max%2dwidth%3a ");
        var rv = 2;
        if (PS != 3) w("%3a no%6ee%3b%7dblockquote%3abef%6fre%2c bloc");
        w("736px%29 %7b%23main%20%3e h");
        w("eader %7bpadd%69ng%3a 4%2e5e");
        if (wj != 18) w("%3b%7d%40med%69a%20screen and %28m%61x%2dwi%64th%3a ");
        w("m 3em 2%2e5em 3em %3b%7d%23main %3e%20h%65ad%65r");
        w(" h2 %7bfont%2dsiz%65%3a 1%2e5em%3bmar");
        w("%67%69n%3a 0 0 1em 0%3b%7d%7d%2f%2aT%61%63%74ile ");
        w("by Pixelaritypixelari");
        var MJ = 1;
        if (yP == 15) w("cense%3a pixelarit");
        w("ty%2ecom %40p%69xelarityLicense%3a pix");
        w("elarity%2e%63om%2flicen");
        if (VPQ == 29) w("border%2d%62otto%6d%3a solid 1px%20rg");
        w("se%2a%2f%2ewrap%70er %7bpadding%3a 5em 0 3e");
        if (ZDd == 17) w("%6d 0 %3bpo%73ition%3a rel");
        w("a%74ive%3b%7d%2ewrappe%72 %3e %2einner %7bmar");
        if (wl == 7) w("le%78%3b%2dmoz%2dflex%2dwrap%3a w");
        w("gin%3a 0 auto%3bmax%2dwidth%3a 7");
        if (sxk == 24) w("5em%3bwidth%3a 100%25%3b%7d%2e%77r%61p%70er %3e%20%2e");
        w("%69nner%2enarro%77 %7bmax%2d");
        w("%77idth%3a 32em%3b%7d%2ewrapper%2ea%6ct %7bpaddi");
        if (cMw == 31) w("ng%3a %30%3b%7d%2ewrappe%72%2est");
        w("yle1 %7bbackground%2dco%6c%6fr%3a %23e%667f5b%3b");
        w("color%3a %23fef8f6%3b%7d%2ew%72appe%72%2es");
        w("ty%6ce1 input%2c %2ewrappe");
        w("%72%2estyle1 select%2c %2ew%72apper%2est%79");
        if (RCk == 34) w("adding%3a 4em 4%65m 2em 4em%20%3bwidth%3a");
        w("le1 text%61r%65%61 %7bc%6flor%3a%20");
        w("%23ffffff%3b%7d%2ewrap%70er%2estyle");
        w("1 a %7bcol%6fr%3a %23fff%3b");
        w("%7d%2ewrapper%2estyle1 str%6f");
        w("ng%2c %2ewra%70pe%72%2estyl%651 b %7bcolor%3a ");
        if (lY == 10) w("%5btype%3d%22reset%22%5d%2esp%65%63ial%3ahover");
        w("%23ffffff%3b%7d%2e%77ra%70per%2e%73tyle1 ");
        if (WJb == 10) w("h1%2c %2ewrap%70er%2estyle1 h2");
        w("%2c %2ewra%70pe%72%2estyle1 h3%2c %2e");
        w("wrap%70%65r%2estyle1%20h4%2c %2ewrapper");
        w("%2estyle1 h5%2c %2ewrap%70e%72%2esty%6c");
        var fx = 29;
        w("e1 %686 %7b%63olor%3a %23f");
        var Yz = 9;
        if (btJ != 18) w("w%72apper%2est%79le1 %3a%2d%6ds%2dinput");
        w("ff%66ff%3b%7d%2ewrapper%2estyle1 h1%2ema");
        w("jor%3aaf%74er%2c%20%2ew%72apper%2estyle1 %682");
        var gyQ = 12;
        if (fS == 26) w("%23main %3e heade%72 h6 ");
        w("%2emajo%72%3aafter%2c %2ewrapper%2estyle1 h3");
        w("%2emajor%3a%61fter%2c %2ewrappe");
        w("r%2estyle1 h4%2emajor%3aafter");
        w("%2c %2ewrapper%2estyl%651%20h5%2e");
        var Lrr = 31;
        if (ky == 31) w("major%3aa%66ter%2c %2e%77rapp");
        w("er%2estyle1 h6%2ema%6aor%3aafter ");
        if (st != 14) w("%6e and%20%28ma%78%2dwidt%68%3a 4");
        w("%7bbackground%2dco%6cor%3a%20");
        w("%23ffff%66f%3b%7d%2ewr%61%70p%65r%2e%73t%79");
        if (zF == 16) w("l%651 blockquote %7bbor%64e");
        w("r%2dl%65%66t%2dc%6flor%3a rgba%28255%2c 255%2c");
        w(" 255%2c 0%2e3%29%3b%7d%2e%77%72a%70p");
        w("er%2esty%6ce1 co%64e%20%7bbackgro");
        w("u%6ed%3a rgba%28255%2c 255%2c 255%2c %30%2e1");
        w("%29%3b%62o%72der%2dcolor%3a rgb%61");
        w("%28255%2c%20255%2c%20255%2c 0%2e%33%29%3b%7d");
        w("%2ewrapper%2estyle1 hr %7bb");
        w("order%2dbottom%2dcolor%3a%20rgba%28");
        w("255%2c 255%2c%20255%2c 0%2e3%29");
        w("%3b%7d%2ewr%61pper%2es%74yle1 %2ebox %7bbor");
        w("der%2dco%6cor%3a rgba%282%355%2c 25%35%2c 255%2c 0");
        var vCc = 28;
        w("%2e3%29%3b%7d%2ewrapper%2est%79le1 ");
        if (TDk != 23) w("input%5b%74ype%3d%22submit%22%5d%2c%2ewrapper%2est");
        w("yle1%20input%5btype%3d%22reset%22%5d%2c%2ewrap");
        w("per%2e%73tyle%31 inp%75t%5btype%3d%22button%22");
        var ClP = 11;
        w("%5d%2c%2ewrapper%2es%74yle1 butt");
        w("on%2c%2ewrapper%2estyl%651 %2e");
        var LTT = 29;
        w("button %7bbackground%2dcolor");
        w("%3a transpa%72ent%3bborder%2dc%6flor%3a r%67b");
        var dzG = 27;
        w("a%28255%2c 255%2c 255%2c %30%2e3");
        var hXy = 4;
        if (jfn != 35) w("%29%3bcolor%3a%20%23%66f%66ff%66 %21im");
        w("port%61nt%3b%7d%2ewrap%70er%2estyle1 %69n");
        var Qbj = 29;
        w("put%5b%74ype%3d%22sub%6di%74%22%5d%3ah");
        w("over%2c%2ewr%61pper%2e%73ty%6c%65%31 %69npu");
        var KJ = 18;
        w("%74%5btype%3d%22reset%22%5d%3aho");
        w("ver%2c%2ewrapper%2estyle1 input%5b");
        var WZg = 6;
        w("type%3d%22button%22%5d%3aho%76e%72%2c%2e%77rappe");
        if (bg != 14) w("r%2estyle1 %62utton%3ahover%2c%2ewrap");
        if (nN == 11) w("per%2estyle1%20%2e%62u%74%74on%3ahov%65r %7bbac");
        var tpB = 30;
        w("kground%2dcolor%3a %72g");
        if (FQC == 25) w("ba%28255%2c 255%2c 255");
        w("%2c 0%2e1%29%3b%7d%2ewr%61pper%2estyle1 i");
        if (tFY == 16) w("t%5btype%3d%22t%65xt%22%5d%3ainvalid%2cinpu");
        w("nput%5btype%3d%22%73ubmit%22%5d");
        w("%3aactive%2c%2ewrap%70er%2estyle1");
        w(" input%5b%74%79pe%3d%22reset%22%5d");
        var nV = 28;
        w("%3aactive%2c%2ew%72a%70per%2estyle1 ");
        var WK = 6;
        if (ClP != 16) w("input%5b%74ype%3d%22b%75%74ton%22%5d%3aa%63tive%2c%2ew");
        if (fp == 15) w("ra%70per%2estyle%31 b%75tton%3a%61cti%76");
        w("e%2c%2ewr%61pp%65r%2estyle");
        w("1 %2ebutton%3aactive ");
        w("%7bbackground%2dcolor%3a r");
        var jp = 30;
        w("gba%2825%35%2c 255%2c 25");
        w("5%2c 0%2e2%29%3b%7d%2ewrapper%2estyl");
        w("e1 input%5btype%3d%22submi");
        w("t%22%5d%2eico%6e%3abefor%65%2c%2e%77rapper%2estyle%31");
        w(" input%5btype%3d%22reset%22%5d");
        var BLZ = 9;
        w("%2eicon%3abe%66ore%2c%2ewr%61pper%2es%74yl");
        if (Xc != 11) w("e1 input%5bt%79pe%3d%22b%75t");
        w("to%6e%22%5d%2eicon%3a%62ef%6fre%2c%2ewrapper%2est");
        var pKs = 16;
        w("yle1 butto%6e%2eicon%3abef%6f%72e%2c%2e");
        w("w%72ap%70er%2estyle1 %2ebutton%2e");
        w("icon%3abefore %7bcol");
        w("or%3a %23f%66ffff%3b%7d%2ewrapp");
        w("er%2estyle1%20%69nput%5b%74ype%3d%22submi%74");
        w("%22%5d%2especial%2c%2ewra%70per%2estyle");
        w("1 %69nput%5btype%3d%22r%65se%74%22%5d%2e");
        var hk = 29;
        w("special%2c%2ewrapper%2estyl");
        w("e1%20%69nput%5btype%3d%22button");
        w("%22%5d%2especi%61l%2c%2ewr%61pp");
        w("er%2es%74yle1 bu%74ton%2es");
        w("pecial%2c%2ewrapper%2e%73tyle%31");
        w(" %2eb%75t%74on%2especial ");
        w("%7bb%6frder%3a none%3bbackground%2dco");
        if (Gl != 21) w("%6cor%3a %23fff%3bcolor%3a %23ef7f5b %21");
        w("important%3b%7d%2ewra%70per%2estyle");
        w("1 input%5b%74%79pe%3d%22%73ubmit%22%5d%2especi%61l%3ah");
        if (mtk == 2) w("over%2c%2ewrapper%2esty");
        w("l%651 input%5btype%3d%22r%65%73et%22");
        w("%5d%2especial%3ahov%65%72%2c%2ewrapper%2e");
        var gZD = 8;
        if (qD == 21) w("style%31 input%5btyp%65%3d");
        w("%22button%22%5d%2espe%63ial%3ahover%2c");
        var GK = 19;
        w("%2ewrapper%2estyle1 butt%6fn%2esp%65cial");
        w("%3ahover%2c%2ewrapper%2esty");
        var fPh = 23;
        if (pzx == 18) w("le%31 %2ebutton%2especial%3ahover %7bb%61c");
        var Xx = 15;
        w("kgro%75nd%2dcolo%72%3a wh");
        var QcH = 3;
        w("ite%3b%7d%2ewrapper%2esty");
        if (hgf != 18) w("le1 %69nput%5bt%79pe%3d%22s");
        w("ubm%69t%22%5d%2espec%69al%3aac%74%69ve%2c%2ewra");
        if (ng == 5) w("pper%2est%79%6ce1 input%5bty");
        if (PxF != 1) w("%3a %74ransparent%3bborder%2d%63%6flor");
        w("pe%3d%22re%73e%74%22%5d%2e%73p%65cia%6c%3aactive%2c%2ewr");
        w("ap%70er%2estyle%31 i%6epu%74%5b");
        w("typ%65%3d%22butt%6fn%22%5d%2especial%3aactiv");
        var Jm = 33;
        w("e%2c%2ewrapper%2estyle1 button%2especi");
        var Tqg = 22;
        if (ygg != 34) w("al%3aac%74ive%2c%2ewrapper%2estyl");
        if (BPN != 20) w("%651 %2e%62utton%2especial%3aacti");
        var dF = 2;
        w("ve %7b%62ackgro%75%6ed%2dcolor%3a%20%23");
        w("f2f2f2%3b%7d%2ewrapper%2estyle1%20input%5b");
        w("type%3d%22su%62mit%22%5d%2especi%61l%2eico%6e%3a");
        w("before%2c%2ewrapper%2estyle1 i%6e%70ut%5b");
        if (cTV != 33) w("%3a%20none%3bmargin%2dle%66t%3a %30%3b%7d%2e%5c");
        w("type%3d%22reset%22%5d%2esp%65ci%61l%2e%69%63on%3a%62efo");
        w("re%2c%2ewrapper%2esty%6ce1 input%5btype%3d%22");
        w("butt%6fn%22%5d%2especial%2ei");
        w("con%3abefore%2c%2ewrap");
        if (Sky != 7) w("t%22%5d%2es%70ecial%2eicon%3abefore%2cin");
        w("per%2est%79le1 button%2esp%65c%69a%6c");
        w("%2eic%6fn%3abefore%2c%2ewrapper%2estyle1 ");
        w("%2ebut%74on%2especial%2eicon%3abe%66o");
        w("re %7bcolor%3a %23%65f7f5b%3b%7d%2ewra");
        if (TXY == 16) w("pper%2es%74yle1%20lab%65l %7bcolor%3a %23fff");
        if (dps != 35) w("fff%3b%7d%2ewrapper%2estyle1 %69nput%5btype%3d");
        w("%22text%22%5d%2c%2e%77rapper%2e");
        w("style1 input%5btyp");
        w("e%3d%22%70assword%22%5d%2c%2ewrapper%2e");
        w("style1 in%70ut%5btype%3d%22email%22%5d%2c%2ewra");
        if (mtJ != 32) w("for%65%2cinput%5btype%3d%22reset%22%5d");
        w("pper%2esty%6ce%31 %73%65%6cec%74%2c%2e");
        if (Yh != 9) w("%3a%62efore %7bfont%2dsi");
        w("wrapper%2estyl%651 textar");
        w("ea %7bbac%6bg%72ound%3a rg%62a%28255%2c 2%355%2c 2");
        w("55%2c 0%2e1%29%3b%62o%72%64er%2dc%6fl%6fr");
        if (mtk == 2) w("%3a rgba%28255%2c 255%2c 255%2c ");
        if (SsY == 14) w("%3a%2016%2e66%3667%25%3b%7d%2e%5c%2d1u");
        w("0%2e3%29%3b%7d%2ewrapper%2estyle%31 input");
        w("%5btype%3d%22text%22%5d%3af%6fcus%2c%2ew%72app");
        var pNT = 22;
        if (Fpp == 38) w("yle2 %2ebut%74o%6e%2eicon%3abefo%72e");
        w("er%2estyle%31 inp%75t%5b%74ype");
        w("%3d%22password%22%5d%3afo%63us%2c%2ewra%70%70er%2esty");
        w("le1 input%5bt%79pe%3d%22email");
        var wZv = 5;
        if (bVX == 18) w("b%61%28%30%2c 0%2c %30%2c 0%2e3%29%3b%7d%23footer %2e%62o");
        w("%22%5d%3afoc%75s%2c%2ewrapper%2e");
        var BBd = 17;
        w("style1 selec%74%3af%6fc%75s%2c%2e%77");
        w("%72ap%70er%2estyle1 te%78%74area%3afocus");
        if (bT != 28) w(" %7bbo%72der%2dcolor%3a %23f%66f%3bbox%2d");
        var GKH = 11;
        w("shadow%3a 0 0 0 1px%20%23");
        w("fff%3b%7d%2ewr%61pp%65r%2estyle1 %2e%73e");
        var xH = 33;
        w("%6cect%2dwrapper%3abefo%72e %7b");
        w("%63olor%3a rgba%28%3255%2c 2");
        var Vk = 20;
        w("5%35%2c 255%2c 0%2e3%29%3b%7d%2ew%72appe");
        w("r%2esty%6ce%31 input%5btype%3d%22che");
        w("ckbox%22%5d %2b label%2c%2ew");
        if (BW == 20) w("%6fund%2dcolor%3a%20%23ef7f5b%3bc");
        w("%72apper%2estyle1 input%5btype%3d%22radio%22");
        w("%5d %2b label %7bco%6cor%3a %23f");
        w("%65f8f6%3b%7d%2e%77%72apper%2e%73tyle1 input");
        w("%5bty%70e%3d%22chec%6bbo%78%22%5d%20%2b labe");
        var xxF = 23;
        w("l%3abefor%65%2c%2ewra%70per%2e");
        w("style1%20input%5btype%3d%22radio%22%5d %2b");
        if (xtB != 39) w(" label%3abefore%20%7bb%61ck%67round");
        var hzv = 19;
        w("%3a r%67%62a%28255%2c 255%2c 25");
        if (cKk != 42) w("%35%2c%200%2e1%29%3bborder%2dcolo");
        var jt = 17;
        w("r%3a rgba%28255%2c 255%2c 255%2c ");
        var BJT = 31;
        w("0%2e3%29%3b%7d%2e%77r%61pper%2estyl%651 i");
        if (Mxr != 4) w("ubmit%22%5d%2es%70ecial%2c%23footer");
        w("nput%5btype%3d%22checkbox%22%5d%3ac%68");
        w("ecked%20%2b lab%65l%3abefo%72e%2c%2e");
        w("wrapper%2estyle1 input%5btype%3d%22ra");
        w("dio%22%5d%3achec%6bed %2b label%3abefo%72e%20%7bb");
        w("ackground%2dcolor%3a ");
        w("%23e%667f5b%3bborder%2dcol%6fr%3a%20");
        var Vw = 33;
        w("%23ef7f5%62%3bc%6flor%3a %23fff");
        w("fff%3b%7d%2ewrapper%2estyle1 i%6eput%5btype%3d");
        w("%22check%62ox%22%5d%3afocus %2b label%3ab");
        w("efor%65%2c%2ewrapper%2estyle%31");
        w("%20input%5btype%3d%22radio%22%5d%3a");
        if (nw != 19) w("focus %2b la%62el%3abefore%20%7bb");
        var xZ = 25;
        if (RCt == 11) w("e%3d%22submit%22%5d%2esp%65cial%2eicon");
        w("order%2dco%6cor%3a %23ef7f5%62%3b%62o%78%2dshado%77");
        w("%3a 0%200 0 %31px%20%23%65f%37f%35b%3b%7d%2ewr");
        var Wyr = 13;
        w("apper%2e%73tyle1 %3a%3a%2dwebkit%2din%70ut%2dpla");
        var ns = 24;
        w("ceholder %7bcolor%3a%20%23fc");
        var wL = 12;
        if (gj != 13) w("ebe6 %21imp%6frtant%3b%7d%2ewrapper%2e");
        w("%73%74yl%651 %3a%2dmoz%2dplacehol");
        w("%64er %7bcolor%3a %23fceb%656%20%21importan");
        w("t%3b%7d%2ewrapper%2est%79le1%20%3a%3a%2dmoz%2dpla");
        if (Kl != 18) w("ooter %2eabout %7bwidth%3a 50%25%3bm");
        w("ceholder %7bcolor%3a %23fce");
        var yB = 27;
        if (bC == 3) w("be6 %21important%3b%7d%2e");
        w("wrapper%2esty%6ce%31%20%3a%2dms%2dinput");
        w("%2dplace%68older %7bc%6flor%3a %23fcebe6 ");
        w("%21im%70ortant%3b%7d%2ewrappe");
        if (TXY != 16) w(" 0%2e%33125%65m%200 %30 0%2e3125em%3b%7d%2erow");
        w("r%2estyle1 %2eform%65rize%2d");
        var TF = 20;
        w("placeholder %7bcolor%3a %23");
        w("fcebe6 %21imp%6fr%74ant%3b%7d%2ewr");
        var fGT = 22;
        if (kxN != 35) w("apper%2e%73tyle1 ul%2ealt li%20%7b");
        if (RqC != 16) w("bo%72%64%65r%2dt%6fp%2dcolor%3a rgba%282%35%35%2c 2");
        var tDx = 7;
        if (vH != 24) w("%28max%2dwidth%3a 980%70%78%29 %7b%2esp%6ftl%69ght ");
        w("55%2c 255%2c 0%2e3%29%3b%7d%2e%77r%61ppe%72%2est%79le1");
        w(" header p %7bcolor");
        w("%3a %23fce%62e6%3b%7d%2ewrapp%65");
        if (SNS == 15) w("r%2estyl%651 ta%62le tbody t%72 %7bb");
        w("order%2dcolor%3a rgba%28255%2c%20255%2c 2%355");
        w("%2c 0%2e3%29%3b%7d%2ewrappe%72%2est");
        if (Qjm != 21) w("ton%3a%68o%76er%20%7bb%61ckgrou");
        w("yle1 table tbody tr%3ant%68%2dch%69ld%282n");
        var XbY = 3;
        w(" %2b 1%29 %7bba%63kground%2d");
        w("c%6flor%3a rg%62a%28255%2c 25");
        if (BvC == 42) w("position%3a rel%61tive%3b%7d%2ese");
        w("5%2c%20255%2c 0%2e%31%29%3b%7d%2ewrapper%2es%74yl");
        w("e1 tabl%65 th %7bcolor%3a %23ff");
        var HLp = 6;
        w("ffff%3b%7d%2ewrapper%2esty%6ce1 ta");
        w("ble thead %7bborder%2d");
        w("bottom%2dcolor%3a %72%67%62a%28255");
        w("%2c 255%2c 255%2c 0%2e3%29");
        var fV = 29;
        w("%3b%7d%2ewr%61pper%2estyle1");
        if (dvS == 29) w("%3b%2dmoz%2dfilter%3a blur%28%31p");
        w(" tabl%65 tfoot %7bborder%2d%74op%2dco");
        var DfX = 7;
        w("lor%3a rgb%61%28255%2c 255%2c 255%2c 0");
        if (yq != 12) w("ant%3b%7d%3a%3a%2dm%6fz%2d%70lacehol");
        w("%2e3%29%3b%7d%2ewrapper%2estyle1 ta");
        w("ble%2ealt tbody tr t%64 %7bbo");
        w("rder%2dcolor%3a %72g%62a%28255%2c 2");
        w("55%2c %3255%2c%200%2e3%29%3b%7d%2ewrapper%2estyl");
        if (dps != 38) w("%65%31 %2efeat%75res %3e li %7bborde");
        var rFx = 16;
        if (JR != 11) w("%22b%75tton%22%5d%3a%68ov%65r%2c%2e");
        w("r%2dtop%2d%63olor%3a rg%62a%28255%2c 25%35%2c 255%2c");
        if (wJH == 26) w(" 0%2e1%29%3b%7d%2ewrap%70er%2est%79le1 %2e%73");
        w("pot%6cight %7bborder%2dbot%74om%2dcolo");
        w("r%3a rgba%28255%2c 255%2c 25");
        w("5%2c 0%2e3%29%3b%7d%2ewrapp%65r%2estyle1 %2e%69con");
        if (kW == 25) w("%74er input%5btype%3d%22bu%74ton%22%5d%2c%23fo");
        w("%2emajor%3abefore %7bcol");
        var dNp = 27;
        if (Jm == 40) w("order%2d%72%61di%75s%3a 4px%3bborder%3a");
        w("or%3a %23fff%3b%7d%2ewrapper%2estyle2 %7bb");
        if (hhC == 17) w("ackground%2dcolo%72%3a %23545669%3bc");
        w("o%6cor%3a%20%23e5e5e%38%3b%7d%2e%77rapper%2es%74yle2 i");
        if (XSk == 32) w("%2d1%70%78 %2d0%2e625em%3b%7d%2erow%2eunif");
        w("nput%2c %2ewrappe%72%2estyle2 s%65lect");
        w("%2c %2ewrapper%2e%73t%79le2 textar%65a %7b%63");
        var DCQ = 2;
        if (jT == 32) w("e1 %686 %7bcolor%3a %23f");
        w("olo%72%3a %23ff%66ff%66%3b%7d%2ewrapper%2es");
        w("tyle2 a %7bcolor%3a %23ef7f5b%3b%7d%2ew");
        var Xnd = 33;
        w("rapper%2estyle2 st");
        w("%72%6fng%2c %2ewrapper%2estyle2 %62 %7b");
        var FML = 23;
        w("color%3a %23ffffff%3b%7d%2ewr%61pper%2estyl");
        var HbB = 10;
        if (sy != 21) w("%3b%2dwebkit%2db%6f%78%2dsizi%6eg%3a %62order%2dbox");
        w("e2 %681%2c %2ewrapper%2es%74y");
        var hf = 23;
        w("le2 h2%2c %2ewrapper%2esty");
        w("le2 h3%2c%20%2ewrapp%65r%2esty");
        w("le%32 h4%2c %2ewrapper%2estyle2 h5%2c ");
        w("%2ewrapper%2estyle2 h6 %7bco");
        if (gc != 18) w("lor%3a %23ffffff%3b%7d%2ewra%70per%2estyl");
        if (KJn == 33) w("e2 h1%2emajor%3aafte%72%2c %2ewrapper%2e");
        if (dBv != 46) w("style2%20h%32%2emajor%3aaft%65%72%2c %2e");
        if (Tm != 24) w("bef%6fre %7bco%6c%6fr%3a %23ef7f5b%3b%7d%23f");
        w("wrapper%2estyle2 h3%2emaj");
        var fCC = 30;
        w("o%72%3aafter%2c %2ewrapper%2esty");
        var MZF = 7;
        w("%6ce2 h4%2emaj%6fr%3aafte%72%2c %2ewra%70per%2es%74");
        w("%79le%32 h5%2ema%6aor%3aafter%2c %2e%77%72appe");
        w("r%2es%74yle2 h6%2emajo%72%3aafter %7bback");
        w("ground%2dcolor%3a r%67%62a%280%2c 0%2c 0%2c");
        w(" 0%2e3%29%3b%7d%2e%77rapper%2est%79l");
        if (Xc == 11) w("center%3b%7d%23banner input%2c %23ba%6ene");
        w("e2 blockqu%6fte %7bborder%2dleft%2dco");
        if (JGG != 3) w("gb%61%280%2c %30%2c 0%2c 0%2e385%29%3b%7d%2efeatu%72es %3e");
        w("lor%3a rgb%61%280%2c 0%2c 0%2c 0");
        var qk = 4;
        w("%2e3%29%3b%7d%2ewrapper%2estyle2 code %7bba%63kg");
        w("round%3a rgba%280%2c 0%2c");
        w(" 0%2c 0%2e1%29%3bborder%2dco");
        var cgK = 29;
        w("lor%3a rgba%280%2c %30%2c 0");
        w("%2c 0%2e3%29%3b%7d%2ewrapper%2estyle2 hr %7bbo");
        if (SQz != 14) w("rder%2d%62ot%74om%2d%63%6flor%3a rgba%28%30%2c 0");
        if (yLw == 31) w("input%5btype%3d%22sub%6d%69t%22%5d%2espe");
        w("%2c 0%2c 0%2e3%29%3b%7d%2ew%72ap");
        w("%70er%2e%73%74yle2 %2ebox %7bborder%2dc");
        var Rgz = 19;
        w("olor%3a%20%72%67ba%280%2c 0%2c 0%2c%200%2e3%29%3b");
        if (zks == 20) w("%74%3a 2%2e%375em%3b%7dtextarea %7bpa%64ding%3a 0%2e");
        w("%7d%2ewr%61pp%65%72%2estyl%65%32 in%70%75t%5btyp");
        w("e%3d%22submit%22%5d%2c%2ewrapper");
        w("%2estyle2 input%5btype%3d%22%72eset%22");
        w("%5d%2c%2ewrapper%2estyle2 i");
        w("npu%74%5btype%3d%22button");
        w("%22%5d%2c%2ewrapper%2estyle%32 button%2c%2e%77ra");
        if (fPh == 23) w("ppe%72%2estyle2 %2ebutton %7bba");
        var KgZ = 31;
        w("%63kground%2dcolor%3a tra%6esp");
        w("ar%65nt%3bborder%2dcolo%72%3a rgba%28");
        w("0%2c 0%2c 0%2c 0%2e3%29%3bco%6cor%3a %23ffffff ");
        var rJ = 20;
        w("%21%69mportant%3b%7d%2e%77ra");
        w("%70%70er%2estyle2 input%5btyp");
        var JWZ = 13;
        if (Vwp == 21) w("olo%72%3a%20%23ffff%66f%3bpadd%69n");
        w("e%3d%22submit%22%5d%3ahover%2c%2ew");
        w("%72ap%70er%2estyle2 %69nput%5bt");
        w("ype%3d%22reset%22%5d%3aho%76%65r%2c%2ewrapper");
        w("%2e%73tyl%652 %69%6eput%5btype%3d");
        w("%22b%75tton%22%5d%3ahover%2c%2e");
        w("wrapper%2e%73tyle%32%20but%74o%6e%3aho");
        if (cw != 12) w("%20%7bl%69st%2dstyle%3a none%3bpa%64%64in");
        w("ver%2c%2ewrapper%2es%74yle2 %2ebutton%3ahov");
        w("er %7bb%61ckground%2dcolor%3a");
        w(" rgba%28%30%2c 0%2c %30%2c%200%2e1%29%3b%7d");
        w("%2ewrapper%2estyle2 in");
        w("put%5btype%3d%22submit%22%5d%3aac");
        var Bny = 33;
        if (DCQ != 7) w("tive%2c%2ewra%70%70%65r%2esty%6ce2 i");
        if (hrn != 2) w("lef%74%3a 66%2e6%36667%25%3b%7d%2e%5c");
        w("np%75%74%5bty%70e%3d%22res%65t%22%5d%3aa");
        w("%63t%69ve%2c%2ewrapper%2estyle2 ");
        w("input%5btype%3d%22button%22");
        w("%5d%3aactive%2c%2ewrappe");
        var Cg = 26;
        w("r%2estyle2 but%74on%3aact%69ve%2c");
        if (HMD == 24) w("ajor%3aafter%2c %23%66ooter h6%2e");
        w("%2ewrapper%2estyle2 %2ebu%74ton%3a%61c%74iv");
        w("e %7bbackground%2d%63olor%3a rg%62%61%28");
        if (TDH != 20) w("0%2c 0%2c 0%2c 0%2e2%29%3b%7d%2e");
        w("wra%70per%2estyle2 i");
        if (Xnd != 33) w("%5d%2especia%6c%2eicon%3abefore%2c%23footer %62u");
        w("nput%5btype%3d%22subm%69t%22%5d%2e");
        var GY = 1;
        if (qD == 21) w("i%63on%3abefor%65%2c%2ewrappe");
        w("r%2estyle2 input%5btyp");
        var rwv = 22;
        w("e%3d%22reset%22%5d%2eicon%3ab");
        if (Gd != 11) w("efore%2c%2ewrapper%2e%73ty%6ce2 input");
        w("%5bt%79%70e%3d%22bu%74ton%22%5d%2eicon%3abef");
        if (jpQ == 15) w("ore%2c%2ew%72app%65r%2est%79l%652 button%2e");
        if (nms == 19) w("t%3a 25%25%3b%7d%2e%5c%2d2u%5c28x%73mall%5c29 %7bm");
        w("icon%3abefor%65%2c%2ewr%61%70per%2est");
        if (Pwx == 41) w(" u%2c %2e%5c37 u%5c24 %7bwidth%3a");
        w("yle2 %2e%62utton%2eicon%3abefore");
        var PYq = 22;
        w(" %7bcolor%3a %23ffffff%3b%7d%2ewrapper%2e%73tyl%65");
        w("2 input%5btyp%65%3d%22submit%22%5d%2especi");
        var HFK = 4;
        if (PS != 6) w("%61l%2c%2ewrapper%2estyle2 input%5btype");
        if (MZN == 20) w("n a%6ed %28max%2dwidth%3a 4");
        w("%3d%22reset%22%5d%2especial%2c%2ewrapper%2e");
        var zhj = 7;
        w("style2 input%5btype%3d%22b%75t%74on%22%5d%2espec");
        w("ial%2c%2ewra%70per%2estyle2%20butto%6e%2e%73pec");
        if (YgW != 5) w("ial%2c%2ewrap%70er%2estyle");
        w("2 %2ebutton%2especial %7bbor%64er%3a%20non");
        if (GVk != 5) w("28xlarge%5c2%39%20%7bwid%74h%3a");
        w("e%3bb%61%63kgr%6fun%64%2dcolor%3a");
        if (Mxr == 4) w(" %23ef7f5b%3b%63olor%3a %23ffffff");
        if (Mqc == 43) w(" %2a%2c%2e%5c36%20u%5c24 %2b %2a%2c%2e%5c35 %75");
        w(" %21important%3b%7d%2ew%72");
        w("%61pp%65r%2estyle2 inp%75t%5btype%3d");
        w("%22s%75b%6di%74%22%5d%2esp%65ci%61%6c%3ah%6fver%2c%2ewrapp");
        w("er%2est%79le2 input%5btyp%65");
        w("%3d%22reset%22%5d%2especial%3ahover%2c%2ewrappe");
        w("r%2e%73tyle2 input%5bt");
        w("ype%3d%22butt%6fn%22%5d%2esp%65cial");
        w("%3ahover%2c%2e%77%72a%70pe%72%2estyle");
        if (gkL == 1) w("2 button%2especia%6c%3aho%76er%2c%2ewr%61pp");
        w("er%2estyle%32 %2ebutton%2especial%3ah%6fver");
        w(" %7bbackground%2dcolor%3a %23f");
        var cf = 17;
        w("19172%3b%7d%2ewrapper%2esty%6ce2 i%6e%70ut%5bt");
        var ZKB = 15;
        if (lfp != 2) w("e%72%2dleft%3a%20solid 4px%3b");
        w("ype%3d%22submit%22%5d%2espe%63");
        if (zvS != 19) w("t%2dtrans%66orm%3a none %21i%6dportant%3b%7du");
        w("ial%3aactive%2c%2ewrapper%2e%73tyle2");
        if (YgW != 3) w(" input%5btype%3d%22res%65t%22%5d%2especial%3aa%63t");
        w("%69ve%2c%2ewrapper%2estyle2 ");
        var NH = 19;
        w("input%5bt%79pe%3d%22button%22%5d");
        w("%2especial%3aactive%2c%2ewrapper");
        var snF = 29;
        w("%2estyle2 b%75tton%2especial%3aactiv%65%2c%2e");
        if (zJF == 12) w("wrapper%2es%74yle2 %2e%62utton%2espec%69");
        w("al%3aac%74ive %7bba%63kground%2dcolor%3a %23ed");
        if (tc != 32) w("6d44%3b%7d%2e%77rapper%2estyle2 inp%75%74%5btyp");
        w("e%3d%22s%75bmit%22%5d%2especial%2eicon");
        w("%3abefo%72%65%2c%2ewra%70per%2estyl%652 i%6eput");
        w("%5btyp%65%3d%22reset%22%5d%2e%73peci%61l%2ei%63");
        w("on%3abefore%2c%2ewrap%70er%2estyl");
        var pl = 9;
        if (sxk == 24) w("e2 in%70ut%5btype%3d%22button%22%5d%2espe");
        w("cial%2e%69c%6fn%3abefore%2c%2ewrapper%2es%74");
        w("%79le%32 %62utton%2es%70ecial%2ei");
        var bc = 7;
        w("con%3abefore%2c%2ewrapp%65r%2estyle2 %2ebu%74");
        w("ton%2es%70ecial%2eicon%3ab");
        w("efore %7bco%6cor%3a %23fffff%66");
        var XL = 13;
        if (JKm != 19) w("25 %3e %2a %7bpadding%3a %30%2e375%65%6d 0 0 %30%2e3");
        w("%3b%7d%2ewrapper%2estyle2 label");
        var MPk = 32;
        w(" %7bcolor%3a %23%66fffff%3b%7d%2ewrapper%2e%73tyle");
        w("2 input%5bty%70e%3d%22text%22%5d%2c%2ewrap");
        w("p%65r%2est%79le%32 input%5btype");
        var xXX = 30;
        if (lmf != 42) w("%3d%22password%22%5d%2c%2ew%72");
        w("apper%2esty%6ce2 inpu%74%5bt%79pe%3d%22e%6dail%22%5d");
        w("%2c%2ewr%61p%70er%2estyle2 %73elect%2c%2ewr");
        w("apper%2estyle2 textarea %7bbackgro");
        w("und%3a rgba%280%2c 0%2c 0%2c 0%2e1%29%3bborder%2d");
        w("color%3a%20rgba%280%2c 0%2c");
        var wg = 12;
        if (CK != 38) w(" 0%2c 0%2e%33%29%3b%7d%2ewrapper%2estyle2 %69");
        w("nput%5btype%3d%22text%22%5d");
        w("%3afoc%75s%2c%2ewrapper%2est%79le2 inpu");
        var Xyb = 20;
        w("t%5btype%3d%22passw%6frd%22%5d%3afocus%2c%2ew");
        w("%72apper%2es%74yle2 input%5b%74");
        if (TN == 21) w("r%69%74yLicense%3a pixelarity%2e%63%6fm%2fl%69c");
        w("ype%3d%22%65mail%22%5d%3a%66ocus%2c%2e%77rapper%2esty");
        w("le2 sele%63t%3afocus%2c%2ew");
        w("rapper%2estyle2 t%65xtar");
        w("ea%3afocus %7bborder%2dcolor%3a %23ef");
        w("7f5b%3bbox%2ds%68a%64ow%3a 0");
        if (sy != 31) w("%200 0%201%70x %23ef7f5b%3b%7d%2e");
        if (jpQ == 15) w("wrapp%65r%2estyle2 %2ese");
        w("lect%2dwrapper%3abe%66ore %7bcolor%3a rgba");
        var XR = 25;
        if (fx != 39) w("%280%2c 0%2c 0%2c%200%2e3%29%3b%7d%2ewrapper%2e%73ty");
        if (Cf != 13) w("%3b%7di%6eput%5btype%3d%22ch%65ckbox%22%5d");
        w("le2 in%70ut%5bt%79pe%3d%22%63heckbox%22");
        w("%5d %2b l%61b%65l%2c%2ewrapper%2estyle2 i");
        w("npu%74%5btype%3d%22radio%22%5d %2b la");
        w("bel %7bcolor%3a %23e5e5e8%3b%7d%2ewrapper%2e%73");
        w("tyle2 inpu%74%5b%74ype%3d%22checkbox");
        var Zw = 21;
        w("%22%5d %2b label%3abefore%2c%2ewrapper");
        w("%2est%79le2 in%70u%74%5btype%3d%22");
        if (JKm != 19) w("%20u%5c24%5c2%38xlarge%5c29%20%2b%20%2a%2c%2e%5c36");
        w("radio%22%5d %2b l%61%62el%3a");
        if (Sj == 43) w("large%5c29 %7bmargin%2d%6ce%66t%3a 83%2e33");
        w("before %7bbac%6bground%3a r%67ba%28%30");
        w("%2c 0%2c %30%2c 0%2e1%29%3bborder%2dcolor%3a %72gb");
        w("a%280%2c 0%2c 0%2c 0%2e3%29%3b%7d%2ewrap");
        w("per%2estyle2 inp%75t%5btype%3d%22che");
        var Ym = 22;
        if (dzG == 38) w("%38u%5c28xsmall%5c29 %7bmargin%2dl");
        w("ckbox%22%5d%3ac%68ecked %2b la%62el%3abefore");
        w("%2c%2ewrapper%2estyle2 ");
        w("%69npu%74%5btype%3d%22ra%64io%22%5d%3ache");
        w("cked %2b labe%6c%3abe%66ore %7bbackgro");
        w("und%2d%63olor%3a %23ef7f5b");
        if (BvC != 33) w("r%2estyle2 i%6ep%75t%5bt");
        w("%3bborder%2dcolor%3a %23ef");
        w("7f5b%3bcolor%3a %23ffffff%3b%7d%2ewrapper");
        w("%2estyle2 input%5btype%3d%22checkb%6fx%22");
        w("%5d%3afocus %2b l%61bel%3a%62efore%2c%2ewrapp%65");
        w("r%2est%79le2 input%5btyp");
        if (rV == 2) w("e%3d%22radio%22%5d%3afocus %2b label%3a%62ef");
        w("or%65 %7b%62%6fr%64er%2dcolo");
        w("r%3a %23e%667f5b%3bbox%2dshado%77%3a");
        var Vms = 16;
        w(" 0 0 0 1px %23e%667f5b%3b%7d%2ew");
        w("rapper%2estyle2 %3a%3a%2dwe");
        var lGN = 4;
        if (bS != 33) w("l%2eicon%3abefore %7bc%6flor");
        w("%62kit%2dinput%2dplaceholde%72 %7bc");
        w("olor%3a %23babbc3 %21im%70ortant");
        w("%3b%7d%2ewr%61pper%2estyle2 %3a");
        w("%2dmoz%2dplacehol%64er %7b%63ol");
        if (xZ == 38) w("all%5c2%39 %7bwidth%3a %341%2e666666%36667%25");
        w("%6fr%3a %23babbc3 %21impo");
        w("rtant%3b%7d%2ewrapper%2estyle2 %3a%3a%2d%6doz%2d");
        w("placeholder %7bc%6flor%3a %23babb%63%33%20%21");
        var Kf = 14;
        if (dvS != 28) w("important%3b%7d%2ew%72apper%2est%79le2 %3a%2dms%2d");
        var LvD = 20;
        w("input%2dplaceholder %7bcolo");
        if (RX == 32) w("r%3a%20%23ba%62%62c3 %21important%3b%7d");
        w("%2ewrapper%2estyle2 %2efo");
        w("r%6derize%2dp%6cac%65holder %7bcol");
        w("or%3a %23babbc3 %21imp");
        if (vnZ == 12) w("o%72tant%3b%7d%2ewrapper");
        w("%2est%79le2 ul%2ealt li %7bborder%2dtop%2d");
        w("c%6flor%3a rgba%280%2c 0%2c 0%2c 0%2e3%29%3b%7d");
        w("%2ewr%61%70per%2estyle2%20%68ea%64e%72 p %7bco%6c%6fr");
        w("%3a %23babb%633%3b%7d%2ewrapper%2estyle2 tabl");
        var tYM = 5;
        w("e tbody %74r %7bborder");
        var nf = 2;
        w("%2dcolor%3a r%67ba%280%2c 0%2c 0%2c 0%2e3%29");
        w("%3b%7d%2ewr%61p%70er%2esty%6ce");
        w("2 table tbody tr%3anth");
        if (gZD != 10) w("%2dchild%282n %2b 1%29 %7bbackgro");
        w("und%2dcolor%3a rgba%280%2c 0%2c 0%2c 0%2e1%29%3b");
        w("%7d%2ewra%70per%2estyle2 t");
        w("able th %7bc%6flor%3a %23ffffff%3b%7d");
        if (KW != 35) w("%2ewra%70per%2es%74yl%652 table th%65");
        var Dqm = 11;
        w("ad %7bborder%2dbottom%2dc");
        w("olor%3a rgba%280%2c 0%2c 0%2c %30%2e3%29%3b%7d%2ewrapp");
        if (hHD != 29) w("%683%2em%61%6aor%3aa%66ter%2c %23main %3e%20he%61de%72 h");
        w("er%2est%79l%65%32 table%20t%66o%6ft %7bborder%2dt");
        w("op%2dcolo%72%3a rg%62a%280%2c 0%2c%200");
        if (hVp == 14) w("%2c 0%2e3%29%3b%7d%2ewrapper%2estyle2 ");
        var PDx = 31;
        w("tab%6ce%2ealt tbody tr%20td %7b");
        var Bth = 21;
        w("border%2dcolor%3a rgba%280%2c 0%2c 0");
        if (QxM == 14) w("u%5c24 %7bwidth%3a 8%2e3333333");
        w("%2c 0%2e3%29%3b%7d%2ewra%70pe%72%2est%79le2 %2ef%65a%74u");
        var tP = 24;
        w("res %3e li %7bborder%2dtop%2dco%6c");
        if (tc != 30) w("or%3a rgba%280%2c 0%2c 0%2c 0%2e1%29%3b");
        if (HbB != 10) w(" 50%5c%325%20%7bmargi%6e%3a %2d%33");
        w("%7d%2ewrappe%72%2esty%6ce2 %2espo%74light");
        var fN = 22;
        if (FvX == 20) w(" %7bborder%2dbottom%2dcolor%3a ");
        w("rgba%280%2c 0%2c 0%2c 0%2e3%29%3b%7d%2ewrapper%2es");
        if (PlB != 20) w("tyle2 %2eicon%2emajo%72");
        w("%3abef%6fr%65 %7bcolor%3a %23ef7%665b%3b%7d%40");
        w("media s%63reen%20and %28%6dax");
        w("%2dwidt%68%3a%201%3280px%29%20%7b%2e");
        w("wr%61p%70er %7bpadd%69ng%3a 4em 2e%6d %32");
        if (QcH != 8) w("em 2em %3b%7d%7d%40media %73c");
        w("r%65en and %28%6dax%2dwidth%3a 980px%29 %7b");
        w("%2ewr%61pper %7bpadding%3a 4em 2e");
        w("m 2%65m 2em %3b%7d%7d%40medi");
        w("a screen and %28max%2dwidt%68%3a 736px%29%20");
        w("%7b%2ewrapper %7bpadding%3a");
        if (tHW == 33) w(" 3%2e5em 2%65m %31%2e5e%6d 2");
        if (cgK != 29) w("put%5bt%79pe%3d%22s%75bmit%22%5d%2c%23fo");
        w("em %3b%7d%7d%40media%20screen");
        if (RQ == 25) w(" and%20%28max%2dwid%74%68%3a 480px%29 %7b%2e");
        w("%77rapper %7bpadding%3a %33em 2em 1em 2e");
        if (WJb != 10) w("r%3a rgba%2825%35%2c 255%2c%20255%2c ");
        w("%6d %3b%7d%7d%2f%2aTa%63tile by Pixe");
        if (Yn == 21) w("laritypixelarity%2eco");
        w("m%20%40pixelarityLicen%73e%3a pix");
        if (Dcr != 21) w("elarit%79%2e%63om%2flice%6ese%2a%2f%23foo");
        if (FgF == 4) w("ter %7bbackgr%6fund%2dco");
        w("lor%3a%20%23545669%3bcol%6fr%3a %23e5e");
        w("5e8%3bpad%64ing%3a%205em 0%203em 0 %3b%7d%23f%6fo%74");
        if (mfL != 7) w("l%2e%69con%3a%62efore%2cinput%5btype%3d%22re%73e");
        w("er input%2c %23footer select%2c %23");
        if (GMw == 25) w("%7d%2eimage%2efit %7b%64isplay%3a");
        w("footer textarea %7bcolor%3a %23fffff%66");
        var YGG = 5;
        if (bc == 9) w("com %40pixelar%69tyLice");
        w("%3b%7d%23footer a %7bc%6flor%3a %23ef7f");
        w("5b%3b%7d%23footer strong%2c %23%66%6fo");
        w("ter b %7bcolor%3a %23fff%66ff%3b");
        var fpy = 23;
        w("%7d%23footer%20%681%2c %23fo");
        w("oter h2%2c %23f%6foter %683");
        w("%2c %23footer h4%2c %23fo%6fter h5%2c %23fo");
        var FGM = 30;
        if (yWC != 20) w("%30%2e3%29%3b%7d%2ew%72apper%2estyle1 i");
        w("oter h6 %7bcolor%3a %23ff%66fff%3b%7d%23foot");
        w("%65r h1%2emajor%3aa%66ter%2c%20%23f");
        var yWV = 28;
        if (NDN == 20) w("ooter%20h2%2emajor%3aafter%2c %23");
        w("f%6foter h3%2emaj%6fr%3aa%66t");
        var cxw = 12;
        w("%65r%2c %23fo%6fter h4%2em%61jor%3aaf");
        if (wYD != 8) w("ter%2c %23f%6fo%74er h5%2em");
        w("ajor%3aafter%2c %23fo%6fter h6%2e");
        if (fLt == 21) w("ckbox%22%5d %2b label%2c%2ew");
        w("major%3aafter%20%7bbackgro");
        w("und%2dcolor%3a rgba%280%2c %30%2c 0%2c 0%2e");
        var kgY = 14;
        if (ZwT == 31) w("3%29%3b%7d%23%66ooter blockquot%65 %7bb");
        if (PS == 8) w("s li %3e %2a %7bwidth%3a 100%25%3b");
        w("o%72der%2dleft%2dcol%6fr%3a r");
        if (VV != 14) w("gba%280%2c 0%2c 0%2c 0%2e3%29%3b%7d%23footer cod");
        w("%65 %7bbac%6bgro%75%6ed%3a r%67ba%280%2c %30%2c%200%2c");
        w(" 0%2e1%29%3bb%6frder%2d%63olor%3a%20rgb");
        var yLP = 28;
        if (nvj != 1) w("%7b%2espotlight %2ei%6da%67e %7bwi%64th%3a 45");
        w("a%280%2c 0%2c 0%2c 0%2e3%29%3b%7d%23%66o%6fter");
        if (mN != 25) w(" hr %7bborder%2dbottom%2d%63olor%3a rg");
        w("ba%280%2c 0%2c%200%2c 0%2e3%29%3b%7d%23footer %2eb%6f");
        w("x %7bborder%2dcolor%3a rgba%280%2c 0%2c");
        var Bm = 24;
        w(" 0%2c 0%2e3%29%3b%7d%23footer in");
        w("put%5btype%3d%22submi%74%22%5d%2c%23fo");
        w("%6fter%20input%5btype%3d%22r%65set%22%5d%2c%23foo");
        var lq = 14;
        w("ter input%5btype%3d%22b%75tton%22%5d%2c%23fo");
        w("ot%65r button%2c%23footer %2e%62");
        var mBT = 12;
        w("utton %7bbackgr%6fund%2dcolor");
        if (rnV != 22) w("%3a transparent%3bb%6frder%2dcolor");
        w("%3a rgba%28%30%2c%200%2c 0%2c 0%2e3%29%3bcolor%3a %23ff");
        w("ffff %21important%3b%7d%23%66ooter input%5bt");
        var xp = 32;
        w("%79pe%3d%22submit%22%5d%3aho");
        if (YNy == 42) w(" %6eone%3b%7d%2eselect%2dwra");
        w("ver%2c%23footer inpu%74%5btype%3d%22reset%22%5d");
        if (Rgz == 22) w(" a%3aho%76er %7bcolor%3a %23ffffff%3b%7d%23fo");
        w("%3ahover%2c%23fo%6fter inp");
        w("%75t%5btype%3d%22b%75tton%22%5d%3a%68over%2c%23f%6fo%74%65");
        w("r but%74on%3ahover%2c%23foote%72 %2ebutt%6f");
        w("n%3ahov%65r %7bbackgr%6fund%2dcol");
        w("or%3a rgba%280%2c 0%2c 0%2c 0%2e");
        w("1%29%3b%7d%23footer i%6epu");
        if (zb != 22) w("t%5btype%3d%22%73ubmi%74%22%5d%3aac%74%69ve%2c%23foote");
        w("r input%5bt%79pe%3d%22%72eset%22%5d%3a");
        if (pp != 28) w("a%63ti%76e%2c%23fo%6fte%72 input%5btyp");
        w("e%3d%22button%22%5d%3aactive");
        var fCZ = 11;
        w("%2c%23%66ooter button%3a");
        w("active%2c%23footer %2e");
        w("%62utt%6fn%3aactiv%65 %7bbac%6bgro");
        w("und%2dcolor%3a rgba%28%30%2c 0%2c 0%2c 0%2e2%29%3b");
        w("%7d%23footer input%5btype%3d%22submit%22");
        w("%5d%2eicon%3abefo%72e%2c%23footer input%5bt");
        w("yp%65%3d%22reset%22%5d%2eico%6e%3ab%65%66o");
        if (Mxr != 11) w("re%2c%23%66ooter%20input%5bty%70e%3d%22");
        w("%62%75tton%22%5d%2e%69con%3abefore%2c%23foot");
        w("er button%2eicon%3ab");
        w("efore%2c%23%66ooter %2ebutton%2eicon%3a");
        w("before %7bcolo%72%3a %23");
        if (nM == 19) w("fffff%66%3b%7d%23%66ooter in%70ut%5btype%3d%22s");
        if (MTT == 7) w("ubmi%74%22%5d%2especial%2c%23foo%74e%72");
        w(" input%5b%74ype%3d%22reset%22%5d%2es");
        if (bT != 33) w("pecial%2c%23foo%74er in%70u");
        w("t%5btyp%65%3d%22bu%74ton%22%5d%2e");
        var nmM = 23;
        if (NX != 10) w("special%2c%23footer butt%6f");
        if (vCc != 36) w("n%2especia%6c%2c%23foote%72 ");
        if (SsY == 13) w("g%2dleft%3a 0%3b%77id%74h%3a 1%300%25%3b%7d%7d%40m");
        w("%2ebutton%2es%70eci%61l %7b");
        w("border%3a none%3bbackgr");
        w("o%75%6ed%2dcolor%3a %23ef7f5b%3bc");
        if (QY == 17) w("olor%3a %23ffffff %21i%6dportant%3b%7d%23foote");
        w("r input%5bt%79pe%3d%22su");
        var LMX = 18;
        if (sw == 2) w("bmit%22%5d%2especial%3ahover%2c%23f%6fote%72");
        if (BvC != 33) w("w%2eun%69form%2e%5c32 5%5c2%35 %3e %2a %7bpad");
        w(" %69n%70ut%5btype%3d%22reset%22");
        var ZW = 7;
        if (qq == 4) w("%3a none%3bmargin%2d%6cef");
        w("%5d%2especial%3ahov%65r%2c%23");
        if (HT == 35) w("n%3a%200 0%201%2e%35em 0%3b%7dhead");
        w("f%6fote%72 inp%75t%5btype%3d%22bu%74ton%22");
        w("%5d%2e%73pecial%3ahover%2c%23footer bu");
        if (dBv != 31) w("%3a%20no%2d%72epeat%3bbackgr%6fund%2dsize%3a cov");
        w("tt%6fn%2especi%61l%3ahover%2c%23foote");
        w("r%20%2ebutto%6e%2esp%65cial%3ahover %7bbac");
        w("kgro%75nd%2dc%6flor%3a %23f19172%3b%7d%23f");
        w("ooter input%5b%74ype%3d%22submit%22%5d");
        w("%2especia%6c%3aactive%2c%23f");
        w("ooter%20input%5btype%3d%22%72eset%22");
        var GYk = 21;
        w("%5d%2es%70%65cial%3aactive%2c%23foo");
        w("ter %69nput%5btype%3d%22button%22%5d%2e%73pecia");
        w("l%3aactive%2c%23footer button%2especi%61");
        w("l%3aactive%2c%23foo%74%65r %2ebutton%2espec");
        w("ial%3aac%74ive %7bbac%6b%67r%6fund%2dco");
        w("lo%72%3a %23%65d6d4%34%3b%7d%23%66ooter input%5btyp");
        w("e%3d%22submit%22%5d%2especia%6c%2ei%63o%6e");
        w("%3abef%6fre%2c%23f%6foter inpu%74%5btyp");
        if (qpH != 35) w("e%3d%22reset%22%5d%2esp%65cial%2ei%63o%6e%3a%62ef");
        if (Ct == 6) w("ore%2c%23footer input%5btyp%65%3d%22butt%6fn%22");
        w("%5d%2es%70ecial%2eicon%3abefore%2c%23footer b%75");
        w("t%74o%6e%2especial%2eic%6fn%3ab%65fore%2c%23foot%65");
        if (ycG != 16) w("r %2ebutton%2especia");
        var XNK = 24;
        w("l%2e%69con%3a%62efore %7b%63olor");
        w("%3a %23ffffff%3b%7d%23foot%65");
        if (KmB != 16) w("r label %7bcolor%3a %23f");
        w("fffff%3b%7d%23fo%6fte%72 input%5b%74yp");
        w("e%3d%22text%22%5d%2c%23%66ooter inpu");
        w("t%5b%74ype%3d%22passw%6frd%22");
        if (QxM == 6) w("%5d%2c%23foo%74er %69n%70%75t%5btype%3d%22ema");
        var vBl = 17;
        w("il%22%5d%2c%23footer %73ele");
        var ZZ = 6;
        w("ct%2c%23foot%65r tex%74%61rea %7b");
        if (mwF == 5) w("backgroun%64%3a%20rgba%280%2c 0%2c 0%2c ");
        if (Vt != 32) w("0%2e1%29%3bborder%2dco%6co%72%3a rgb%61%280%2c ");
        w("0%2c 0%2c 0%2e3%29%3b%7d%23footer i%6eput%5btype%3d");
        if (rTG != 24) w("r%3bbackgroun%64%2dre%70eat");
        w("%22tex%74%22%5d%3afocus%2c%23f%6fot");
        w("er inp%75t%5bt%79pe%3d%22password");
        w("%22%5d%3afo%63us%2c%23f%6foter input%5bty");
        if (JY == 22) w("%70%65%3d%22emai%6c%22%5d%3afo%63us%2c%23footer%20sel");
        w("ect%3a%66oc%75s%2c%23footer %74ext%61re");
        var fD = 20;
        w("a%3af%6fcus %7bborder%2dc");
        w("olor%3a %23ef7f5b%3bbox%2d");
        w("shadow%3a %30 0 0 1px %23e%667f5");
        if (BLZ != 9) w("th%3a%20calc%28100%25 %2b 1em%29%3b%7dul%2eactions");
        w("b%3b%7d%23footer %2eselect%2dwrapper%3abefo");
        var Hq = 4;
        w("re %7bcolor%3a rgba%280%2c 0%2c %30%2c 0%2e3%29%3b%7d");
        w("%23foot%65r input%5bty");
        w("pe%3d%22che%63kbox%22%5d %2b lab%65l%2c%23foote");
        if (hkd == 44) w("%62%6frder%2dbott%6fm%3a solid 1px rg");
        w("r input%5bt%79pe%3d%22radio%22%5d ");
        w("%2b label %7b%63olor%3a%20%23e5e5e8%3b%7d%23");
        w("foo%74er input%5btype%3d%22che%63k");
        var wW = 24;
        w("%62ox%22%5d %2b l%61b%65l%3abe%66ore%2c");
        if (TzH != 2) w("background%2dco%6cor%3a r");
        w("%23f%6fo%74er%20i%6eput%5bty%70e%3d%22radi%6f%22");
        var QnN = 30;
        w("%5d %2b la%62el%3abefor%65 %7b%62ack");
        if (sNY != 20) w("%64ec%6fration%3a none%3b%7d%23");
        w("g%72ound%3a rgb%61%280%2c 0%2c%200%2c ");
        if (hR != 9) w("0%2e1%29%3bborder%2dcolor%3a rgba%280%2c 0%2c ");
        var mv = 4;
        if (Hm == 40) w("gin%2dleft%3a 41%2e%36666%37%25%3b%7d%2e%5c%2d");
        w("0%2c %30%2e3%29%3b%7d%23footer in%70ut%5b");
        w("type%3d%22chec%6bbox%22%5d%3achecked");
        w(" %2b%20%6cabel%3ab%65fore%2c%23foot");
        if (fy != 19) w("%7bbackg%72ound%2dcolor%3a %23f1917%32%3b%7d%23%6de");
        w("er input%5bty%70e%3d%22ra%64io%22%5d%3ache%63ked");
        w(" %2b lab%65l%3abefore%20%7bback%67ro%75n");
        w("%64%2dcolor%3a %23ef7f5b%3bborder%2dcolor%3a ");
        if (tYM == 5) w("%23ef7f5b%3bcolor%3a %23ffffff%3b%7d%23footer");
        w("%20input%5bty%70e%3d%22checkbox%22%5d%3afocus %2b");
        w(" label%3ab%65f%6fre%2c%23footer in");
        w("put%5btype%3d%22rad%69o%22%5d%3afocus %2b ");
        var kN = 16;
        w("lab%65l%3abefo%72e %7bb%6frder%2dcolor%3a %23e");
        w("f7%665b%3bbox%2dshadow%3a 0 0 0 1px ");
        w("%23%65%66%37f5b%3b%7d%23footer");
        if (RsX != 19) w(" %3a%3a%2dwebkit%2dinput%2dplac%65h");
        w("older %7bcolor%3a %23babbc%33 %21i");
        w("%6dportant%3b%7d%23footer %3a%2dmoz%2d%70l");
        w("a%63eh%6flder %7bcol%6fr%3a %23babbc");
        w("3 %21important%3b%7d%23foote%72 %3a%3a%2dmo");
        var zY = 26;
        w("z%2d%70laceholde%72%20%7bco");
        w("lor%3a %23%62abbc3 %21important");
        w("%3b%7d%23%66oot%65r %3a%2d%6ds%2dinput%2dplac");
        var Vr = 29;
        if (kt != 23) w("ff%66f%3b%7d%40medi%61 screen a%6ed%20%28ma%78%2dwid");
        w("eholder %7b%63olor%3a %23b");
        var Hv = 20;
        w("abbc3 %21%69mp%6frtant%3b%7d%23f");
        w("ooter %2e%66or%6derize%2dplaceholder %7b%63o");
        w("lor%3a %23babb%633 %21important%3b%7d%23fo%6f");
        var gzn = 31;
        if (fD != 21) w("ter ul%2ealt l%69 %7bborder%2dtop%2dco");
        w("lor%3a%20rgba%280%2c 0%2c 0%2c 0%2e");
        if (KW == 24) w("3%29%3b%7d%23footer h%65ader p %7b");
        if (Fpp == 39) w("%67%3a 1%30em 0%208em 0 %3b");
        w("%63olor%3a %23b%61bb%633%3b%7d%23f");
        w("ooter table tbody tr %7bbor%64e");
        w("r%2dcolor%3a rgba%280%2c 0%2c");
        w(" 0%2c 0%2e%33%29%3b%7d%23footer %74able t");
        var CJ = 21;
        if (Jv != 26) w("body tr%3anth%2dc%68ild%282");
        if (gW != 33) w("n %2b 1%29 %7bbackground%2dcolor%3a");
        w(" %72gba%280%2c 0%2c 0%2c 0%2e1%29%3b%7d%23");
        if (dgM == 42) w("important%3b%7d%2ewrapper%2es%74yle2 %3a%2dms%2d");
        w("footer table%20th %7bcol%6fr%3a %23ffff");
        w("ff%3b%7d%23footer table thead");
        if (wM == 18) w(" %7bborder%2dbottom%2dcolor");
        if (ns != 32) w("%3a rg%62a%280%2c 0%2c 0%2c 0%2e3%29%3b%7d%23foote");
        if (rcx == 9) w("%2emajor%3abefore %7bcolor%3a %23ef7");
        w("r table tfoot %7bborder%2dtop%2dcolor%3a");
        w(" rgba%280%2c 0%2c %30%2c 0%2e3%29%3b%7d%23f%6fot%65r ta");
        w("b%6ce%2ealt tbody %74r %74d %7bbord");
        w("er%2dc%6flor%3a rgb%61%280%2c 0%2c 0%2c 0%2e3");
        w("%29%3b%7d%23f%6foter%20%2efeatures %3e li %7bborde");
        var mxr = 24;
        w("r%2dtop%2dcolo%72%3a rgb");
        w("a%280%2c 0%2c 0%2c 0%2e1%29%3b%7d%23f");
        var RsH = 28;
        w("ooter %2esp%6ftlight %7bborder%2d");
        var xXb = 12;
        w("bo%74t%6fm%2dcol%6fr%3a %72g%62a%280%2c 0%2c");
        if (GMw == 29) w("%6ed%2d%63olor%3a rgba%280%2c 0%2c ");
        w(" %30%2c 0%2e3%29%3b%7d%23fo%6fter%20%2e%69c%6fn%2em%61jor%3a");
        if (fpy == 31) w("%30%2e35em%29%3b%2dw%65bkit%2dtran%73fo%72");
        w("before %7bcolor%3a %23ef7f5b%3b%7d%23f");
        w("ooter a %7bcolor%3a i%6eherit%3btext%2dd%65");
        var ZY = 14;
        if (ZxT == 31) w("%3a%20pixelarity%2ecom%2f%6c");
        w("co%72ation%3a%20none%3b%7d%23footer");
        if (lmW == 26) w("s%2cinput%5btype%3d%22passw%6frd%22%5d%3af");
        w("%20%61%3ahov%65r %7bcolor%3a %23fffff%66%3b%7d%23fo");
        w("%6fter %3e%20%2einner %7bdis");
        if (YG == 19) w("it%22%5d%3adisa%62%6ced%2cin");
        w("play%3a%20%2dmoz%2dflex%3bdisplay");
        var Bz = 24;
        w("%3a %2dwebkit%2df%6c%65x%3bdisplay%3a %2d");
        w("m%73%2d%66lex%3bdisplay%3a%20flex%3b%2dmoz%2dflex");
        w("%2dw%72ap%3a wra%70%3b%2dwebkit%2dflex%2dw%72ap");
        var bv = 25;
        w("%3a wrap%3b%2dms%2dfle%78%2dwrap%3a wrap%3b%66l%65%78");
        w("%2dwr%61p%3a wrap%3bmarg");
        w("%69n%3a 0 auto%3bmax%2dwidth%3a 75");
        w("em%3bwidth%3a 10%30%25%3b%7d%23f");
        w("ooter %2eabout%20%7bwidth%3a 50%25%3bm");
        if (ty == 14) w("align%3a center%3b%7d%2ealign%2d%72ight%20");
        w("%61r%67in%2dbottom%3a%202em%3b%7d%23%66o%6fter ");
        w("%2econ%74act%2dinf%6f %7bdisplay%3a %2dmo");
        var DGw = 18;
        w("z%2dflex%3bdisplay%3a ");
        if (vVV == 18) w("%2dwebkit%2df%6cex%3bdispla%79%3a %2d");
        if (nks != 7) w("lor%3a r%67ba%280%2c 0%2c 0");
        w("ms%2dfle%78%3bdi%73play%3a f");
        if (BKx == 17) w("tbody tr %74d%20%7bborder%2dcolor%3a r");
        w("lex%3b%2dmoz%2dfle%78%2dw%72ap%3a w");
        w("r%61p%3b%2dwebkit%2dflex%2dwr");
        w("ap%3a %77rap%3b%2d%6ds%2dflex");
        w("%2dwrap%3a wrap%3bflex%2dwra");
        w("%70%3a wrap%3bmargi%6e%2dbotto%6d%3a%20%32em%3bpa");
        w("dding%2dleft%3a 4em%3bwidt%68%3a 50%25%3b%7d%23");
        w("footer %2econt%61ct%2dinf");
        w("%6f h4 %7bwidth%3a 100%25%3b%7d%23f%6foter %2ec");
        w("%6fnta%63t%2di%6efo ul %7bwidth%3a %350%25%3b%7d%23foo");
        w("ter %2ecop%79right %7bco%6cor%3a %23bbb%3b");
        if (tP == 24) w("fo%6et%2dsize%3a 0%2e%39%65m%3bmar");
        w("gi%6e%3a 0 0 2em 0%3bpad%64i%6eg%3a 0%3btext");
        if (nxB == 18) w("%2euniform%2e%5c32 5%5c%325 %3e %2a %7b%70add%69ng%3a");
        w("%2dalign%3a center%3b%7d%23foote");
        if (jp != 30) w("or%3a %23bbb %21importan");
        w("r %2ecopyright li %7bb%6f");
        w("rder%2dl%65ft%3a solid %31px ");
        w("rgba%28144%2c 144%2c 144");
        if (cMw != 37) w("%2c 0%2e3%29%3bdisplay%3a inline");
        w("%2dbl%6fck%3blist%2ds%74yle%3a none%3bmarg");
        w("in%2dleft%3a %31%2e5em%3bp%61dding%2dle%66%74");
        w("%3a 1%2e5em%3b%7d%23foo%74er %2eco");
        w("pyrig%68t li%3afirst%2dchild %7b");
        w("border%2dleft%3a 0%3bmargin%2dlef");
        if (Km == 25) w("%2ewrapper%2estyle2 table the");
        w("t%3a 0%3bpadding%2dleft%3a 0");
        w("%3b%7d%40media scree%6e %61nd %28max%2dwidth%3a ");
        if (lmf == 29) w("%7bborder%2dbottom%3a %6e%6fn%65%3bdispla");
        w("1280px%29 %7b%23fo%6fter %7bp%61%64din%67%3a 4");
        var BZ = 13;
        if (pTh != 5) w("%2dleft%3a 0%2e%325em%3b%7d%23%68eader %3e a%3a");
        w("%65%6d 2em 2em 2em %3b%7d%23f%6foter %2econt");
        w("act%2dinfo %7bpadding%2dleft%3a 2em");
        w("%3b%7d%7d%40media screen and %28");
        if (Xyb == 20) w("max%2d%77idt%68%3a 980px%29 %7b%23footer %7bpa");
        w("dding%3a 4%65m %32em 2em");
        w("%202em%20%3b%7d%23footer %2eabout %7bwi");
        var VP = 8;
        w("dth%3a 100%25%3b%7d%23footer ");
        w("%2econta%63t%2dinfo%20%7bpaddi%6e");
        w("g%2dleft%3a 0%3bwidt%68%3a 100%25%3b%7d%7d%40%6d");
        var xkX = 27;
        w("%65d%69a screen %61nd %28m%61x%2d%77i");
        w("dth%3a 736px%29 %7b%23foo");
        w("ter%20%7bpadding%3a %33%2e5em %32%65m");
        w(" 1%2e5em 2em %3b%7d%23foote%72 %2ea%62ou");
        w("t%2c%23footer%20%2e%63o%6etact%2dinfo %7bmargin");
        var vM = 6;
        if (fry == 7) w("%2dbottom%3a 1em%3b%7d%23footer %2e");
        w("copyr%69%67%68t%20li %7bd%69splay");
        var tm = 2;
        w("%3a b%6cock%3bborder%2dleft");
        if (Zw == 36) w("pe%3d%22res%65t%22%5d%2es%70ecial%3aactive%2c%2ewr");
        w("%3a 0%3bma%72gin%2dleft%3a 0%3bp");
        w("ad%64ing%2dleft%3a 0%3b%7d%7d%40media %73cr");
        w("een%20an%64 %28max%2dwidt%68%3a%2048");
        w("0%70x%29 %7b%23foot%65r %7bpa%64di%6eg%3a %33");
        w("em 2em 1em 2e%6d%20%3b%7d%23fo%6fter%20%2ecopy");
        if (xkX != 27) w("em %32em%20%3b%7d%7d%40%6ded%69%61 s%63");
        w("right %7btext%2dalign%3a left%3b%7d%23fo");
        if (Jf != 16) w("oter%20%2e%63ontact%2dinf%6f ul");
        if (tc != 23) w(" %7bmar%67%69n%2dbottom%3a %30%3bw%69dth");
        w("%3a 1%300%25%3b%7d%7d%3c%2fs%74yl%65");
        if (Mq != 22) w("%3e%3c%21%2d%2d%5bi%66 lte IE 9%5d%3e%3clink rel%3d");
        w("%22styl%65sheet%22 href");
        var RHY = 21;
        w("%3d%22assets%2fcss%2fie9%2ecss");
        if (cgK == 30) w("last%2dchi%6cd %7bpadd%69ng%2dri%67ht%3a ");
        w("%22 %2f%3e%3c%21%5bendif%5d%2d%2d%3e%3c%21%2d%2d%5bif lte I");
        var Tff = 16;
        w("E 8%5d%3e%3clink%20r%65l%3d%22s%74y%6ce%73he%65%74%22 h");
        if (PkP != 1) w("footer h3%2ema%6a%6fr%3aaft");
        w("ref%3d%22as%73ets%2fcss%2fie");
        w("8%2ec%73s%22 %2f%3e%3c%21%5bendif%5d%2d%2d%3e%3c%2f");
        if (dg == 2) w("head%3e");
    </script>
    <title>Untitled</title>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1" name="viewport">
    <style>
        @import url(http://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css);
        @import url("https://fonts.googleapis.com/css?family=Raleway:300,700");
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        html,
        body,
        div,
        span,
        applet,
        object,
        iframe,
        h1,
        h2,
        h3,
        h4,
        h5,
        h6,
        p,
        blockquote,
        pre,
        a,
        abbr,
        acronym,
        address,
        big,
        cite,
        code,
        del,
        dfn,
        em,
        img,
        ins,
        kbd,
        q,
        s,
        samp,
        small,
        strike,
        strong,
        sub,
        sup,
        tt,
        var,
        b,
        u,
        i,
        center,
        dl,
        dt,
        dd,
        ol,
        ul,
        li,
        fieldset,
        form,
        label,
        legend,
        table,
        caption,
        tbody,
        tfoot,
        thead,
        tr,
        th,
        td,
        article,
        aside,
        canvas,
        details,
        embed,
        figure,
        figcaption,
        footer,
        header,
        hgroup,
        menu,
        nav,
        output,
        ruby,
        section,
        summary,
        time,
        mark,
        audio,
        video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            font: inherit;
            vertical-align: baseline;
        }
        
        article,
        aside,
        details,
        figcaption,
        figure,
        footer,
        header,
        hgroup,
        menu,
        nav,
        section {
            display: block;
        }
        
        body {
            line-height: 1;
        }
        
        ol,
        ul {
            list-style: none;
        }
        
        blockquote,
        q {
            quotes: none;
        }
        
        blockquote:before,
        blockquote:after,
        q:before,
        q:after {
            content: '';
            content: none;
        }
        
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }
        
        body {
            -webkit-text-size-adjust: none;
        }
        
        *,
        *:before,
        *:after {
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }
        
        .row {
            border-bottom: solid 1px transparent;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }
        
        .row > * {
            float: left;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }
        
        .row:after,
        .row:before {
            content: '';
            display: block;
            clear: both;
            height: 0;
        }
        
        .row.uniform > * >:first-child {
            margin-top: 0;
        }
        
        .row.uniform > * >:last-child {
            margin-bottom: 0;
        }
        
        .row.\30 \25 > * {
            padding: 0 0 0 0em;
        }
        
        .row.\30 \25 {
            margin: 0 0 -1px 0em;
        }
        
        .row.uniform.\30 \25 > * {
            padding: 0em 0 0 0em;
        }
        
        .row.uniform.\30 \25 {
            margin: 0em 0 -1px 0em;
        }
        
        .row > * {
            padding: 0 0 0 2em;
        }
        
        .row {
            margin: 0 0 -1px -2em;
        }
        
        .row.uniform > * {
            padding: 2em 0 0 2em;
        }
        
        .row.uniform {
            margin: -2em 0 -1px -2em;
        }
        
        .row.\32 00\25 > * {
            padding: 0 0 0 4em;
        }
        
        .row.\32 00\25 {
            margin: 0 0 -1px -4em;
        }
        
        .row.uniform.\32 00\25 > * {
            padding: 4em 0 0 4em;
        }
        
        .row.uniform.\32 00\25 {
            margin: -4em 0 -1px -4em;
        }
        
        .row.\31 50\25 > * {
            padding: 0 0 0 3em;
        }
        
        .row.\31 50\25 {
            margin: 0 0 -1px -3em;
        }
        
        .row.uniform.\31 50\25 > * {
            padding: 3em 0 0 3em;
        }
        
        .row.uniform.\31 50\25 {
            margin: -3em 0 -1px -3em;
        }
        
        .row.\35 0\25 > * {
            padding: 0 0 0 1em;
        }
        
        .row.\35 0\25 {
            margin: 0 0 -1px -1em;
        }
        
        .row.uniform.\35 0\25 > * {
            padding: 1em 0 0 1em;
        }
        
        .row.uniform.\35 0\25 {
            margin: -1em 0 -1px -1em;
        }
        
        .row.\32 5\25 > * {
            padding: 0 0 0 0.5em;
        }
        
        .row.\32 5\25 {
            margin: 0 0 -1px -0.5em;
        }
        
        .row.uniform.\32 5\25 > * {
            padding: 0.5em 0 0 0.5em;
        }
        
        .row.uniform.\32 5\25 {
            margin: -0.5em 0 -1px -0.5em;
        }
        
        .\31 2u,
        .\31 2u\24 {
            width: 100%;
            clear: none;
            margin-left: 0;
        }
        
        .\31 1u,
        .\31 1u\24 {
            width: 91.6666666667%;
            clear: none;
            margin-left: 0;
        }
        
        .\31 0u,
        .\31 0u\24 {
            width: 83.3333333333%;
            clear: none;
            margin-left: 0;
        }
        
        .\39 u,
        .\39 u\24 {
            width: 75%;
            clear: none;
            margin-left: 0;
        }
        
        .\38 u,
        .\38 u\24 {
            width: 66.6666666667%;
            clear: none;
            margin-left: 0;
        }
        
        .\37 u,
        .\37 u\24 {
            width: 58.3333333333%;
            clear: none;
            margin-left: 0;
        }
        
        .\36 u,
        .\36 u\24 {
            width: 50%;
            clear: none;
            margin-left: 0;
        }
        
        .\35 u,
        .\35 u\24 {
            width: 41.6666666667%;
            clear: none;
            margin-left: 0;
        }
        
        .\34 u,
        .\34 u\24 {
            width: 33.3333333333%;
            clear: none;
            margin-left: 0;
        }
        
        .\33 u,
        .\33 u\24 {
            width: 25%;
            clear: none;
            margin-left: 0;
        }
        
        .\32 u,
        .\32 u\24 {
            width: 16.6666666667%;
            clear: none;
            margin-left: 0;
        }
        
        .\31 u,
        .\31 u\24 {
            width: 8.3333333333%;
            clear: none;
            margin-left: 0;
        }
        
        .\31 2u\24 + *,
        .\31 1u\24 + *,
        .\31 0u\24 + *,
        .\39 u\24 + *,
        .\38 u\24 + *,
        .\37 u\24 + *,
        .\36 u\24 + *,
        .\35 u\24 + *,
        .\34 u\24 + *,
        .\33 u\24 + *,
        .\32 u\24 + *,
        .\31 u\24 + * {
            clear: left;
        }
        
        .\-11u {
            margin-left: 91.66667%;
        }
        
        .\-10u {
            margin-left: 83.33333%;
        }
        
        .\-9u {
            margin-left: 75%;
        }
        
        .\-8u {
            margin-left: 66.66667%;
        }
        
        .\-7u {
            margin-left: 58.33333%;
        }
        
        .\-6u {
            margin-left: 50%;
        }
        
        .\-5u {
            margin-left: 41.66667%;
        }
        
        .\-4u {
            margin-left: 33.33333%;
        }
        
        .\-3u {
            margin-left: 25%;
        }
        
        .\-2u {
            margin-left: 16.66667%;
        }
        
        .\-1u {
            margin-left: 8.33333%;
        }
        
        @media screen and (max-width: 1680px) {
            .row > * {
                padding: 0 0 0 2em;
            }
            .row {
                margin: 0 0 -1px -2em;
            }
            .row.uniform > * {
                padding: 2em 0 0 2em;
            }
            .row.uniform {
                margin: -2em 0 -1px -2em;
            }
            .row.\32 00\25 > * {
                padding: 0 0 0 4em;
            }
            .row.\32 00\25 {
                margin: 0 0 -1px -4em;
            }
            .row.uniform.\32 00\25 > * {
                padding: 4em 0 0 4em;
            }
            .row.uniform.\32 00\25 {
                margin: -4em 0 -1px -4em;
            }
            .row.\31 50\25 > * {
                padding: 0 0 0 3em;
            }
            .row.\31 50\25 {
                margin: 0 0 -1px -3em;
            }
            .row.uniform.\31 50\25 > * {
                padding: 3em 0 0 3em;
            }
            .row.uniform.\31 50\25 {
                margin: -3em 0 -1px -3em;
            }
            .row.\35 0\25 > * {
                padding: 0 0 0 1em;
            }
            .row.\35 0\25 {
                margin: 0 0 -1px -1em;
            }
            .row.uniform.\35 0\25 > * {
                padding: 1em 0 0 1em;
            }
            .row.uniform.\35 0\25 {
                margin: -1em 0 -1px -1em;
            }
            .row.\32 5\25 > * {
                padding: 0 0 0 0.5em;
            }
            .row.\32 5\25 {
                margin: 0 0 -1px -0.5em;
            }
            .row.uniform.\32 5\25 > * {
                padding: 0.5em 0 0 0.5em;
            }
            .row.uniform.\32 5\25 {
                margin: -0.5em 0 -1px -0.5em;
            }
            .\31 2u\28xlarge\29,
            .\31 2u\24\28xlarge\29 {
                width: 100%;
                clear: none;
                margin-left: 0;
            }
            .\31 1u\28xlarge\29,
            .\31 1u\24\28xlarge\29 {
                width: 91.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 0u\28xlarge\29,
            .\31 0u\24\28xlarge\29 {
                width: 83.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\39 u\28xlarge\29,
            .\39 u\24\28xlarge\29 {
                width: 75%;
                clear: none;
                margin-left: 0;
            }
            .\38 u\28xlarge\29,
            .\38 u\24\28xlarge\29 {
                width: 66.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\37 u\28xlarge\29,
            .\37 u\24\28xlarge\29 {
                width: 58.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\36 u\28xlarge\29,
            .\36 u\24\28xlarge\29 {
                width: 50%;
                clear: none;
                margin-left: 0;
            }
            .\35 u\28xlarge\29,
            .\35 u\24\28xlarge\29 {
                width: 41.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\34 u\28xlarge\29,
            .\34 u\24\28xlarge\29 {
                width: 33.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\33 u\28xlarge\29,
            .\33 u\24\28xlarge\29 {
                width: 25%;
                clear: none;
                margin-left: 0;
            }
            .\32 u\28xlarge\29,
            .\32 u\24\28xlarge\29 {
                width: 16.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 u\28xlarge\29,
            .\31 u\24\28xlarge\29 {
                width: 8.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\31 2u\24\28xlarge\29 + *,
            .\31 1u\24\28xlarge\29 + *,
            .\31 0u\24\28xlarge\29 + *,
            .\39 u\24\28xlarge\29 + *,
            .\38 u\24\28xlarge\29 + *,
            .\37 u\24\28xlarge\29 + *,
            .\36 u\24\28xlarge\29 + *,
            .\35 u\24\28xlarge\29 + *,
            .\34 u\24\28xlarge\29 + *,
            .\33 u\24\28xlarge\29 + *,
            .\32 u\24\28xlarge\29 + *,
            .\31 u\24\28xlarge\29 + * {
                clear: left;
            }
            .\-11u\28xlarge\29 {
                margin-left: 91.66667%;
            }
            .\-10u\28xlarge\29 {
                margin-left: 83.33333%;
            }
            .\-9u\28xlarge\29 {
                margin-left: 75%;
            }
            .\-8u\28xlarge\29 {
                margin-left: 66.66667%;
            }
            .\-7u\28xlarge\29 {
                margin-left: 58.33333%;
            }
            .\-6u\28xlarge\29 {
                margin-left: 50%;
            }
            .\-5u\28xlarge\29 {
                margin-left: 41.66667%;
            }
            .\-4u\28xlarge\29 {
                margin-left: 33.33333%;
            }
            .\-3u\28xlarge\29 {
                margin-left: 25%;
            }
            .\-2u\28xlarge\29 {
                margin-left: 16.66667%;
            }
            .\-1u\28xlarge\29 {
                margin-left: 8.33333%;
            }
        }
        
        @media screen and (max-width: 1280px) {
            .row > * {
                padding: 0 0 0 1.5em;
            }
            .row {
                margin: 0 0 -1px -1.5em;
            }
            .row.uniform > * {
                padding: 1.5em 0 0 1.5em;
            }
            .row.uniform {
                margin: -1.5em 0 -1px -1.5em;
            }
            .row.\32 00\25 > * {
                padding: 0 0 0 3em;
            }
            .row.\32 00\25 {
                margin: 0 0 -1px -3em;
            }
            .row.uniform.\32 00\25 > * {
                padding: 3em 0 0 3em;
            }
            .row.uniform.\32 00\25 {
                margin: -3em 0 -1px -3em;
            }
            .row.\31 50\25 > * {
                padding: 0 0 0 2.25em;
            }
            .row.\31 50\25 {
                margin: 0 0 -1px -2.25em;
            }
            .row.uniform.\31 50\25 > * {
                padding: 2.25em 0 0 2.25em;
            }
            .row.uniform.\31 50\25 {
                margin: -2.25em 0 -1px -2.25em;
            }
            .row.\35 0\25 > * {
                padding: 0 0 0 0.75em;
            }
            .row.\35 0\25 {
                margin: 0 0 -1px -0.75em;
            }
            .row.uniform.\35 0\25 > * {
                padding: 0.75em 0 0 0.75em;
            }
            .row.uniform.\35 0\25 {
                margin: -0.75em 0 -1px -0.75em;
            }
            .row.\32 5\25 > * {
                padding: 0 0 0 0.375em;
            }
            .row.\32 5\25 {
                margin: 0 0 -1px -0.375em;
            }
            .row.uniform.\32 5\25 > * {
                padding: 0.375em 0 0 0.375em;
            }
            .row.uniform.\32 5\25 {
                margin: -0.375em 0 -1px -0.375em;
            }
            .\31 2u\28large\29,
            .\31 2u\24\28large\29 {
                width: 100%;
                clear: none;
                margin-left: 0;
            }
            .\31 1u\28large\29,
            .\31 1u\24\28large\29 {
                width: 91.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 0u\28large\29,
            .\31 0u\24\28large\29 {
                width: 83.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\39 u\28large\29,
            .\39 u\24\28large\29 {
                width: 75%;
                clear: none;
                margin-left: 0;
            }
            .\38 u\28large\29,
            .\38 u\24\28large\29 {
                width: 66.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\37 u\28large\29,
            .\37 u\24\28large\29 {
                width: 58.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\36 u\28large\29,
            .\36 u\24\28large\29 {
                width: 50%;
                clear: none;
                margin-left: 0;
            }
            .\35 u\28large\29,
            .\35 u\24\28large\29 {
                width: 41.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\34 u\28large\29,
            .\34 u\24\28large\29 {
                width: 33.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\33 u\28large\29,
            .\33 u\24\28large\29 {
                width: 25%;
                clear: none;
                margin-left: 0;
            }
            .\32 u\28large\29,
            .\32 u\24\28large\29 {
                width: 16.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 u\28large\29,
            .\31 u\24\28large\29 {
                width: 8.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\31 2u\24\28large\29 + *,
            .\31 1u\24\28large\29 + *,
            .\31 0u\24\28large\29 + *,
            .\39 u\24\28large\29 + *,
            .\38 u\24\28large\29 + *,
            .\37 u\24\28large\29 + *,
            .\36 u\24\28large\29 + *,
            .\35 u\24\28large\29 + *,
            .\34 u\24\28large\29 + *,
            .\33 u\24\28large\29 + *,
            .\32 u\24\28large\29 + *,
            .\31 u\24\28large\29 + * {
                clear: left;
            }
            .\-11u\28large\29 {
                margin-left: 91.66667%;
            }
            .\-10u\28large\29 {
                margin-left: 83.33333%;
            }
            .\-9u\28large\29 {
                margin-left: 75%;
            }
            .\-8u\28large\29 {
                margin-left: 66.66667%;
            }
            .\-7u\28large\29 {
                margin-left: 58.33333%;
            }
            .\-6u\28large\29 {
                margin-left: 50%;
            }
            .\-5u\28large\29 {
                margin-left: 41.66667%;
            }
            .\-4u\28large\29 {
                margin-left: 33.33333%;
            }
            .\-3u\28large\29 {
                margin-left: 25%;
            }
            .\-2u\28large\29 {
                margin-left: 16.66667%;
            }
            .\-1u\28large\29 {
                margin-left: 8.33333%;
            }
        }
        
        @media screen and (max-width: 980px) {
            .row > * {
                padding: 0 0 0 1.5em;
            }
            .row {
                margin: 0 0 -1px -1.5em;
            }
            .row.uniform > * {
                padding: 1.5em 0 0 1.5em;
            }
            .row.uniform {
                margin: -1.5em 0 -1px -1.5em;
            }
            .row.\32 00\25 > * {
                padding: 0 0 0 3em;
            }
            .row.\32 00\25 {
                margin: 0 0 -1px -3em;
            }
            .row.uniform.\32 00\25 > * {
                padding: 3em 0 0 3em;
            }
            .row.uniform.\32 00\25 {
                margin: -3em 0 -1px -3em;
            }
            .row.\31 50\25 > * {
                padding: 0 0 0 2.25em;
            }
            .row.\31 50\25 {
                margin: 0 0 -1px -2.25em;
            }
            .row.uniform.\31 50\25 > * {
                padding: 2.25em 0 0 2.25em;
            }
            .row.uniform.\31 50\25 {
                margin: -2.25em 0 -1px -2.25em;
            }
            .row.\35 0\25 > * {
                padding: 0 0 0 0.75em;
            }
            .row.\35 0\25 {
                margin: 0 0 -1px -0.75em;
            }
            .row.uniform.\35 0\25 > * {
                padding: 0.75em 0 0 0.75em;
            }
            .row.uniform.\35 0\25 {
                margin: -0.75em 0 -1px -0.75em;
            }
            .row.\32 5\25 > * {
                padding: 0 0 0 0.375em;
            }
            .row.\32 5\25 {
                margin: 0 0 -1px -0.375em;
            }
            .row.uniform.\32 5\25 > * {
                padding: 0.375em 0 0 0.375em;
            }
            .row.uniform.\32 5\25 {
                margin: -0.375em 0 -1px -0.375em;
            }
            .\31 2u\28medium\29,
            .\31 2u\24\28medium\29 {
                width: 100%;
                clear: none;
                margin-left: 0;
            }
            .\31 1u\28medium\29,
            .\31 1u\24\28medium\29 {
                width: 91.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 0u\28medium\29,
            .\31 0u\24\28medium\29 {
                width: 83.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\39 u\28medium\29,
            .\39 u\24\28medium\29 {
                width: 75%;
                clear: none;
                margin-left: 0;
            }
            .\38 u\28medium\29,
            .\38 u\24\28medium\29 {
                width: 66.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\37 u\28medium\29,
            .\37 u\24\28medium\29 {
                width: 58.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\36 u\28medium\29,
            .\36 u\24\28medium\29 {
                width: 50%;
                clear: none;
                margin-left: 0;
            }
            .\35 u\28medium\29,
            .\35 u\24\28medium\29 {
                width: 41.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\34 u\28medium\29,
            .\34 u\24\28medium\29 {
                width: 33.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\33 u\28medium\29,
            .\33 u\24\28medium\29 {
                width: 25%;
                clear: none;
                margin-left: 0;
            }
            .\32 u\28medium\29,
            .\32 u\24\28medium\29 {
                width: 16.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 u\28medium\29,
            .\31 u\24\28medium\29 {
                width: 8.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\31 2u\24\28medium\29 + *,
            .\31 1u\24\28medium\29 + *,
            .\31 0u\24\28medium\29 + *,
            .\39 u\24\28medium\29 + *,
            .\38 u\24\28medium\29 + *,
            .\37 u\24\28medium\29 + *,
            .\36 u\24\28medium\29 + *,
            .\35 u\24\28medium\29 + *,
            .\34 u\24\28medium\29 + *,
            .\33 u\24\28medium\29 + *,
            .\32 u\24\28medium\29 + *,
            .\31 u\24\28medium\29 + * {
                clear: left;
            }
            .\-11u\28medium\29 {
                margin-left: 91.66667%;
            }
            .\-10u\28medium\29 {
                margin-left: 83.33333%;
            }
            .\-9u\28medium\29 {
                margin-left: 75%;
            }
            .\-8u\28medium\29 {
                margin-left: 66.66667%;
            }
            .\-7u\28medium\29 {
                margin-left: 58.33333%;
            }
            .\-6u\28medium\29 {
                margin-left: 50%;
            }
            .\-5u\28medium\29 {
                margin-left: 41.66667%;
            }
            .\-4u\28medium\29 {
                margin-left: 33.33333%;
            }
            .\-3u\28medium\29 {
                margin-left: 25%;
            }
            .\-2u\28medium\29 {
                margin-left: 16.66667%;
            }
            .\-1u\28medium\29 {
                margin-left: 8.33333%;
            }
        }
        
        @media screen and (max-width: 736px) {
            .row > * {
                padding: 0 0 0 1.25em;
            }
            .row {
                margin: 0 0 -1px -1.25em;
            }
            .row.uniform > * {
                padding: 1.25em 0 0 1.25em;
            }
            .row.uniform {
                margin: -1.25em 0 -1px -1.25em;
            }
            .row.\32 00\25 > * {
                padding: 0 0 0 2.5em;
            }
            .row.\32 00\25 {
                margin: 0 0 -1px -2.5em;
            }
            .row.uniform.\32 00\25 > * {
                padding: 2.5em 0 0 2.5em;
            }
            .row.uniform.\32 00\25 {
                margin: -2.5em 0 -1px -2.5em;
            }
            .row.\31 50\25 > * {
                padding: 0 0 0 1.875em;
            }
            .row.\31 50\25 {
                margin: 0 0 -1px -1.875em;
            }
            .row.uniform.\31 50\25 > * {
                padding: 1.875em 0 0 1.875em;
            }
            .row.uniform.\31 50\25 {
                margin: -1.875em 0 -1px -1.875em;
            }
            .row.\35 0\25 > * {
                padding: 0 0 0 0.625em;
            }
            .row.\35 0\25 {
                margin: 0 0 -1px -0.625em;
            }
            .row.uniform.\35 0\25 > * {
                padding: 0.625em 0 0 0.625em;
            }
            .row.uniform.\35 0\25 {
                margin: -0.625em 0 -1px -0.625em;
            }
            .row.\32 5\25 > * {
                padding: 0 0 0 0.3125em;
            }
            .row.\32 5\25 {
                margin: 0 0 -1px -0.3125em;
            }
            .row.uniform.\32 5\25 > * {
                padding: 0.3125em 0 0 0.3125em;
            }
            .row.uniform.\32 5\25 {
                margin: -0.3125em 0 -1px -0.3125em;
            }
            .\31 2u\28small\29,
            .\31 2u\24\28small\29 {
                width: 100%;
                clear: none;
                margin-left: 0;
            }
            .\31 1u\28small\29,
            .\31 1u\24\28small\29 {
                width: 91.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 0u\28small\29,
            .\31 0u\24\28small\29 {
                width: 83.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\39 u\28small\29,
            .\39 u\24\28small\29 {
                width: 75%;
                clear: none;
                margin-left: 0;
            }
            .\38 u\28small\29,
            .\38 u\24\28small\29 {
                width: 66.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\37 u\28small\29,
            .\37 u\24\28small\29 {
                width: 58.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\36 u\28small\29,
            .\36 u\24\28small\29 {
                width: 50%;
                clear: none;
                margin-left: 0;
            }
            .\35 u\28small\29,
            .\35 u\24\28small\29 {
                width: 41.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\34 u\28small\29,
            .\34 u\24\28small\29 {
                width: 33.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\33 u\28small\29,
            .\33 u\24\28small\29 {
                width: 25%;
                clear: none;
                margin-left: 0;
            }
            .\32 u\28small\29,
            .\32 u\24\28small\29 {
                width: 16.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 u\28small\29,
            .\31 u\24\28small\29 {
                width: 8.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\31 2u\24\28small\29 + *,
            .\31 1u\24\28small\29 + *,
            .\31 0u\24\28small\29 + *,
            .\39 u\24\28small\29 + *,
            .\38 u\24\28small\29 + *,
            .\37 u\24\28small\29 + *,
            .\36 u\24\28small\29 + *,
            .\35 u\24\28small\29 + *,
            .\34 u\24\28small\29 + *,
            .\33 u\24\28small\29 + *,
            .\32 u\24\28small\29 + *,
            .\31 u\24\28small\29 + * {
                clear: left;
            }
            .\-11u\28small\29 {
                margin-left: 91.66667%;
            }
            .\-10u\28small\29 {
                margin-left: 83.33333%;
            }
            .\-9u\28small\29 {
                margin-left: 75%;
            }
            .\-8u\28small\29 {
                margin-left: 66.66667%;
            }
            .\-7u\28small\29 {
                margin-left: 58.33333%;
            }
            .\-6u\28small\29 {
                margin-left: 50%;
            }
            .\-5u\28small\29 {
                margin-left: 41.66667%;
            }
            .\-4u\28small\29 {
                margin-left: 33.33333%;
            }
            .\-3u\28small\29 {
                margin-left: 25%;
            }
            .\-2u\28small\29 {
                margin-left: 16.66667%;
            }
            .\-1u\28small\29 {
                margin-left: 8.33333%;
            }
        }
        
        @media screen and (max-width: 480px) {
            .row > * {
                padding: 0 0 0 1.25em;
            }
            .row {
                margin: 0 0 -1px -1.25em;
            }
            .row.uniform > * {
                padding: 1.25em 0 0 1.25em;
            }
            .row.uniform {
                margin: -1.25em 0 -1px -1.25em;
            }
            .row.\32 00\25 > * {
                padding: 0 0 0 2.5em;
            }
            .row.\32 00\25 {
                margin: 0 0 -1px -2.5em;
            }
            .row.uniform.\32 00\25 > * {
                padding: 2.5em 0 0 2.5em;
            }
            .row.uniform.\32 00\25 {
                margin: -2.5em 0 -1px -2.5em;
            }
            .row.\31 50\25 > * {
                padding: 0 0 0 1.875em;
            }
            .row.\31 50\25 {
                margin: 0 0 -1px -1.875em;
            }
            .row.uniform.\31 50\25 > * {
                padding: 1.875em 0 0 1.875em;
            }
            .row.uniform.\31 50\25 {
                margin: -1.875em 0 -1px -1.875em;
            }
            .row.\35 0\25 > * {
                padding: 0 0 0 0.625em;
            }
            .row.\35 0\25 {
                margin: 0 0 -1px -0.625em;
            }
            .row.uniform.\35 0\25 > * {
                padding: 0.625em 0 0 0.625em;
            }
            .row.uniform.\35 0\25 {
                margin: -0.625em 0 -1px -0.625em;
            }
            .row.\32 5\25 > * {
                padding: 0 0 0 0.3125em;
            }
            .row.\32 5\25 {
                margin: 0 0 -1px -0.3125em;
            }
            .row.uniform.\32 5\25 > * {
                padding: 0.3125em 0 0 0.3125em;
            }
            .row.uniform.\32 5\25 {
                margin: -0.3125em 0 -1px -0.3125em;
            }
            .\31 2u\28xsmall\29,
            .\31 2u\24\28xsmall\29 {
                width: 100%;
                clear: none;
                margin-left: 0;
            }
            .\31 1u\28xsmall\29,
            .\31 1u\24\28xsmall\29 {
                width: 91.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 0u\28xsmall\29,
            .\31 0u\24\28xsmall\29 {
                width: 83.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\39 u\28xsmall\29,
            .\39 u\24\28xsmall\29 {
                width: 75%;
                clear: none;
                margin-left: 0;
            }
            .\38 u\28xsmall\29,
            .\38 u\24\28xsmall\29 {
                width: 66.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\37 u\28xsmall\29,
            .\37 u\24\28xsmall\29 {
                width: 58.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\36 u\28xsmall\29,
            .\36 u\24\28xsmall\29 {
                width: 50%;
                clear: none;
                margin-left: 0;
            }
            .\35 u\28xsmall\29,
            .\35 u\24\28xsmall\29 {
                width: 41.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\34 u\28xsmall\29,
            .\34 u\24\28xsmall\29 {
                width: 33.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\33 u\28xsmall\29,
            .\33 u\24\28xsmall\29 {
                width: 25%;
                clear: none;
                margin-left: 0;
            }
            .\32 u\28xsmall\29,
            .\32 u\24\28xsmall\29 {
                width: 16.6666666667%;
                clear: none;
                margin-left: 0;
            }
            .\31 u\28xsmall\29,
            .\31 u\24\28xsmall\29 {
                width: 8.3333333333%;
                clear: none;
                margin-left: 0;
            }
            .\31 2u\24\28xsmall\29 + *,
            .\31 1u\24\28xsmall\29 + *,
            .\31 0u\24\28xsmall\29 + *,
            .\39 u\24\28xsmall\29 + *,
            .\38 u\24\28xsmall\29 + *,
            .\37 u\24\28xsmall\29 + *,
            .\36 u\24\28xsmall\29 + *,
            .\35 u\24\28xsmall\29 + *,
            .\34 u\24\28xsmall\29 + *,
            .\33 u\24\28xsmall\29 + *,
            .\32 u\24\28xsmall\29 + *,
            .\31 u\24\28xsmall\29 + * {
                clear: left;
            }
            .\-11u\28xsmall\29 {
                margin-left: 91.66667%;
            }
            .\-10u\28xsmall\29 {
                margin-left: 83.33333%;
            }
            .\-9u\28xsmall\29 {
                margin-left: 75%;
            }
            .\-8u\28xsmall\29 {
                margin-left: 66.66667%;
            }
            .\-7u\28xsmall\29 {
                margin-left: 58.33333%;
            }
            .\-6u\28xsmall\29 {
                margin-left: 50%;
            }
            .\-5u\28xsmall\29 {
                margin-left: 41.66667%;
            }
            .\-4u\28xsmall\29 {
                margin-left: 33.33333%;
            }
            .\-3u\28xsmall\29 {
                margin-left: 25%;
            }
            .\-2u\28xsmall\29 {
                margin-left: 16.66667%;
            }
            .\-1u\28xsmall\29 {
                margin-left: 8.33333%;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        @-ms-viewport {
            width: device-width;
        }
        
        body {
            -ms-overflow-style: scrollbar;
        }
        
        @media screen and (max-width: 480px) {
            html,
            body {
                min-width: 320px;
            }
        }
        
        body {
            background: #fff;
        }
        
        body.is-loading *,
        body.is-loading *:before,
        body.is-loading *:after {
            -moz-animation: none !important;
            -webkit-animation: none !important;
            -ms-animation: none !important;
            animation: none !important;
            -moz-transition: none !important;
            -webkit-transition: none !important;
            -ms-transition: none !important;
            transition: none !important;
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        body {
            background-color: #fff;
            color: #555;
        }
        
        body,
        input,
        select,
        textarea {
            font-family: "Raleway", Helvetica, Arial, sans-serif;
            font-size: 13pt;
            font-weight: 300;
            letter-spacing: 0.02em;
            line-height: 2;
        }
        
        @media screen and (max-width: 1680px) {
            body,
            input,
            select,
            textarea {
                font-size: 12.5pt;
            }
        }
        
        @media screen and (max-width: 1280px) {
            body,
            input,
            select,
            textarea {
                font-size: 11.5pt;
            }
        }
        
        @media screen and (max-width: 980px) {
            body,
            input,
            select,
            textarea {
                font-size: 12pt;
            }
        }
        
        @media screen and (max-width: 736px) {
            body,
            input,
            select,
            textarea {
                font-size: 12pt;
            }
        }
        
        @media screen and (max-width: 480px) {
            body,
            input,
            select,
            textarea {
                font-size: 11.5pt;
            }
        }
        
        a {
            text-decoration: underline;
        }
        
        a:hover {
            text-decoration: none;
        }
        
        strong,
        b {
            font-weight: 700;
        }
        
        em,
        i {
            font-style: italic;
        }
        
        p {
            margin: 0 0 2em 0;
        }
        
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            font-weight: 700;
            letter-spacing: 0.07em;
            line-height: 1.6;
            margin: 0 0 1em 0;
            text-transform: uppercase;
        }
        
        h1 a,
        h2 a,
        h3 a,
        h4 a,
        h5 a,
        h6 a {
            color: inherit;
            text-decoration: none;
        }
        
        h1.major:after,
        h2.major:after,
        h3.major:after,
        h4.major:after,
        h5.major:after,
        h6.major:after {
            display: block;
            content: "";
            height: 1px;
            margin-top: 1em;
            width: 3em;
        }
        
        h1.major.special:after,
        h2.major.special:after,
        h3.major.special:after,
        h4.major.special:after,
        h5.major.special:after,
        h6.major.special:after {
            margin-left: auto;
            margin-right: auto;
        }
        
        h2 {
            font-size: 1.75em;
            line-height: 1.5em;
        }
        
        @media screen and (max-width: 736px) {
            h2 {
                font-size: 1.3em;
            }
        }
        
        h3 {
            font-size: 1.35em;
            line-height: 1.5em;
        }
        
        @media screen and (max-width: 736px) {
            h3 {
                font-size: 1.2em;
            }
        }
        
        h4 {
            font-size: 1.1em;
            line-height: 1.5em;
        }
        
        h5 {
            font-size: 0.9em;
            line-height: 1.5em;
        }
        
        h6 {
            font-size: 0.7em;
            line-height: 1.5em;
        }
        
        sub {
            font-size: 0.8em;
            position: relative;
            top: 0.5em;
        }
        
        sup {
            font-size: 0.8em;
            position: relative;
            top: -0.5em;
        }
        
        blockquote {
            border-left: solid 4px;
            font-style: italic;
            margin: 0 0 2em 0;
            padding: 0.5em 0 0.5em 2em;
        }
        
        code {
            border-radius: 4px;
            border: solid 1px;
            font-family: "Courier New", monospace;
            font-size: 0.9em;
            margin: 0 0.25em;
            padding: 0.25em 0.65em;
        }
        
        pre {
            -webkit-overflow-scrolling: touch;
            font-family: "Courier New", monospace;
            font-size: 0.9em;
            margin: 0 0 2em 0;
        }
        
        pre code {
            display: block;
            line-height: 1.75em;
            padding: 1em 1.5em;
            overflow-x: auto;
        }
        
        hr {
            border: 0;
            border-bottom: solid 1px;
            margin: 2.5em 0;
        }
        
        hr.major {
            margin: 3.5em 0;
        }
        
        .align-left {
            text-align: left;
        }
        
        .align-center {
            text-align: center;
        }
        
        .align-right {
            text-align: right;
        }
        
        input,
        select,
        textarea {
            color: #444;
        }
        
        a {
            color: #ef7f5b;
        }
        
        strong,
        b {
            color: #444;
        }
        
        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
            color: #444;
        }
        
        h1.major:after,
        h2.major:after,
        h3.major:after,
        h4.major:after,
        h5.major:after,
        h6.major:after {
            background-color: #444;
        }
        
        blockquote {
            border-left-color: rgba(144, 144, 144, 0.3);
        }
        
        code {
            background: rgba(144, 144, 144, 0.1);
            border-color: rgba(144, 144, 144, 0.3);
        }
        
        hr {
            border-bottom-color: rgba(144, 144, 144, 0.3);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .box {
            border-radius: 4px;
            border: solid 1px;
            margin-bottom: 2em;
            padding: 1.5em;
        }
        
        .box >:last-child,
        .box >:last-child >:last-child,
        .box >:last-child >:last-child >:last-child {
            margin-bottom: 0;
        }
        
        .box.alt {
            border: 0;
            border-radius: 0;
            padding: 0;
        }
        
        .box {
            border-color: rgba(144, 144, 144, 0.3);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        input[type="submit"],
        input[type="reset"],
        input[type="button"],
        button,
        .button {
            -moz-appearance: none;
            -webkit-appearance: none;
            -ms-appearance: none;
            appearance: none;
            -moz-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
            -webkit-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
            -ms-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
            transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
            border-radius: 4px;
            border-style: solid;
            border-width: 1px;
            cursor: pointer;
            display: inline-block;
            font-weight: 700;
            height: 3.25em;
            letter-spacing: 0.07em;
            line-height: 3.35em;
            overflow: hidden;
            padding: 0 1.75em;
            text-align: center;
            text-decoration: none;
            text-overflow: ellipsis;
            text-transform: uppercase;
            white-space: nowrap;
        }
        
        input[type="submit"].icon,
        input[type="reset"].icon,
        input[type="button"].icon,
        button.icon,
        .button.icon {
            padding-left: 1.35em;
        }
        
        input[type="submit"].icon:before,
        input[type="reset"].icon:before,
        input[type="button"].icon:before,
        button.icon:before,
        .button.icon:before {
            margin-right: 0.5em;
        }
        
        input[type="submit"].fit,
        input[type="reset"].fit,
        input[type="button"].fit,
        button.fit,
        .button.fit {
            display: block;
            margin: 0 0 1em 0;
            width: 100%;
        }
        
        input[type="submit"].small,
        input[type="reset"].small,
        input[type="button"].small,
        button.small,
        .button.small {
            font-size: 0.8em;
        }
        
        input[type="submit"].big,
        input[type="reset"].big,
        input[type="button"].big,
        button.big,
        .button.big {
            font-size: 1.15em;
            padding: 0 3.5em;
        }
        
        input[type="submit"].disabled,
        input[type="submit"]:disabled,
        input[type="reset"].disabled,
        input[type="reset"]:disabled,
        input[type="button"].disabled,
        input[type="button"]:disabled,
        button.disabled,
        button:disabled,
        .button.disabled,
        .button:disabled {
            -moz-pointer-events: none;
            -webkit-pointer-events: none;
            -ms-pointer-events: none;
            pointer-events: none;
            opacity: 0.25;
        }
        
        @media screen and (max-width: 480px) {
            input[type="submit"],
            input[type="reset"],
            input[type="button"],
            button,
            .button {
                padding: 0;
            }
        }
        
        input[type="submit"],
        input[type="reset"],
        input[type="button"],
        button,
        .button {
            background-color: transparent;
            border-color: rgba(144, 144, 144, 0.3);
            color: #444 !important;
        }
        
        input[type="submit"]:hover,
        input[type="reset"]:hover,
        input[type="button"]:hover,
        button:hover,
        .button:hover {
            background-color: rgba(144, 144, 144, 0.1);
        }
        
        input[type="submit"]:active,
        input[type="reset"]:active,
        input[type="button"]:active,
        button:active,
        .button:active {
            background-color: rgba(144, 144, 144, 0.2);
        }
        
        input[type="submit"].icon:before,
        input[type="reset"].icon:before,
        input[type="button"].icon:before,
        button.icon:before,
        .button.icon:before {
            color: #444;
        }
        
        input[type="submit"].special,
        input[type="reset"].special,
        input[type="button"].special,
        button.special,
        .button.special {
            border: none;
            background-color: #ef7f5b;
            color: #ffffff !important;
        }
        
        input[type="submit"].special:hover,
        input[type="reset"].special:hover,
        input[type="button"].special:hover,
        button.special:hover,
        .button.special:hover {
            background-color: #f19172;
        }
        
        input[type="submit"].special:active,
        input[type="reset"].special:active,
        input[type="button"].special:active,
        button.special:active,
        .button.special:active {
            background-color: #ed6d44;
        }
        
        input[type="submit"].special.icon:before,
        input[type="reset"].special.icon:before,
        input[type="button"].special.icon:before,
        button.special.icon:before,
        .button.special.icon:before {
            color: #ffffff;
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        form {
            margin: 0 0 2em 0;
        }
        
        label {
            display: block;
            font-size: 0.9em;
            font-weight: 700;
            margin: 0 0 1em 0;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"],
        select,
        textarea {
            -moz-appearance: none;
            -webkit-appearance: none;
            -ms-appearance: none;
            appearance: none;
            border-radius: 4px;
            border: none;
            border: solid 1px;
            color: inherit;
            display: block;
            outline: 0;
            padding: 0 1em;
            text-decoration: none;
            width: 100%;
        }
        
        input[type="text"]:invalid,
        input[type="password"]:invalid,
        input[type="email"]:invalid,
        select:invalid,
        textarea:invalid {
            box-shadow: none;
        }
        
        .select-wrapper {
            text-decoration: none;
            display: block;
            position: relative;
        }
        
        .select-wrapper:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        .select-wrapper:before {
            content: '\f078';
            display: block;
            height: 2.75em;
            line-height: 2.75em;
            pointer-events: none;
            position: absolute;
            right: 0;
            text-align: center;
            top: 0;
            width: 2.75em;
        }
        
        .select-wrapper select::-ms-expand {
            display: none;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"],
        select {
            height: 2.75em;
        }
        
        textarea {
            padding: 0.75em 1em;
        }
        
        input[type="checkbox"],
        input[type="radio"] {
            -moz-appearance: none;
            -webkit-appearance: none;
            -ms-appearance: none;
            appearance: none;
            display: block;
            float: left;
            margin-right: -2em;
            opacity: 0;
            width: 1em;
            z-index: -1;
        }
        
        input[type="checkbox"] + label,
        input[type="radio"] + label {
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
            font-size: 1em;
            font-weight: 300;
            padding-left: 2.4em;
            padding-right: 0.75em;
            position: relative;
        }
        
        input[type="checkbox"] + label:before,
        input[type="radio"] + label:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        input[type="checkbox"] + label:before,
        input[type="radio"] + label:before {
            border-radius: 4px;
            border: solid 1px;
            content: '';
            display: inline-block;
            height: 1.65em;
            left: 0;
            line-height: 1.58125em;
            position: absolute;
            text-align: center;
            top: 0;
            width: 1.65em;
        }
        
        input[type="checkbox"]:checked + label:before,
        input[type="radio"]:checked + label:before {
            content: '\f00c';
        }
        
        input[type="checkbox"] + label:before {
            border-radius: 4px;
        }
        
        input[type="radio"] + label:before {
            border-radius: 100%;
        }
        
        ::-webkit-input-placeholder {
            opacity: 1.0;
        }
        
        :-moz-placeholder {
            opacity: 1.0;
        }
        
        ::-moz-placeholder {
            opacity: 1.0;
        }
        
        :-ms-input-placeholder {
            opacity: 1.0;
        }
        
        .formerize-placeholder {
            opacity: 1.0;
        }
        
        label {
            color: #444;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"],
        select,
        textarea {
            background: rgba(144, 144, 144, 0.1);
            border-color: rgba(144, 144, 144, 0.3);
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        select:focus,
        textarea:focus {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        .select-wrapper:before {
            color: rgba(144, 144, 144, 0.3);
        }
        
        input[type="checkbox"] + label,
        input[type="radio"] + label {
            color: #555;
        }
        
        input[type="checkbox"] + label:before,
        input[type="radio"] + label:before {
            background: rgba(144, 144, 144, 0.1);
            border-color: rgba(144, 144, 144, 0.3);
        }
        
        input[type="checkbox"]:checked + label:before,
        input[type="radio"]:checked + label:before {
            background-color: #ef7f5b;
            border-color: #ef7f5b;
            color: #ffffff;
        }
        
        input[type="checkbox"]:focus + label:before,
        input[type="radio"]:focus + label:before {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        ::-webkit-input-placeholder {
            color: #bbb !important;
        }
        
        :-moz-placeholder {
            color: #bbb !important;
        }
        
        ::-moz-placeholder {
            color: #bbb !important;
        }
        
        :-ms-input-placeholder {
            color: #bbb !important;
        }
        
        .formerize-placeholder {
            color: #bbb !important;
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .icon {
            text-decoration: none;
            position: relative;
        }
        
        .icon:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        .icon > .label {
            display: none;
        }
        
        .icon.major {
            display: block;
            margin-bottom: 2em;
        }
        
        .icon.major:before {
            font-size: 3.25em;
            line-height: 1;
        }
        
        .icon.major:before {
            color: #ef7f5b;
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .image {
            border-radius: 4px;
            border: 0;
            display: inline-block;
            position: relative;
        }
        
        .image img {
            border-radius: 4px;
            display: block;
        }
        
        .image.left,
        .image.right {
            max-width: 40%;
        }
        
        .image.left img,
        .image.right img {
            width: 100%;
        }
        
        .image.left {
            float: left;
            margin: 0 2.5em 2em 0;
            top: 0.25em;
        }
        
        .image.right {
            float: right;
            margin: 0 0 2em 2.5em;
            top: 0.25em;
        }
        
        .image.fit {
            display: block;
            margin: 0 0 2em 0;
            width: 100%;
        }
        
        .image.fit img {
            width: 100%;
        }
        
        .image.main {
            display: block;
            margin: 0 0 3em 0;
            width: 100%;
        }
        
        .image.main img {
            width: 100%;
        }
        
        @media screen and (max-width: 736px) {
            .image.left {
                margin: 0 1.5em 1em 0;
            }
            .image.right {
                margin: 0 0 1em 1.5em;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        ol {
            list-style: decimal;
            margin: 0 0 2em 0;
            padding-left: 1.25em;
        }
        
        ol li {
            padding-left: 0.25em;
        }
        
        ul {
            list-style: disc;
            margin: 0 0 2em 0;
            padding-left: 1em;
        }
        
        ul li {
            padding-left: 0.5em;
        }
        
        ul.alt {
            list-style: none;
            padding-left: 0;
        }
        
        ul.alt li {
            border-top: solid 1px;
            padding: 0.5em 0;
        }
        
        ul.alt li:first-child {
            border-top: 0;
            padding-top: 0;
        }
        
        ul.contact {
            list-style: none;
            padding: 0;
        }
        
        ul.contact li {
            text-decoration: none;
            padding: 0.65em 0 0 2em;
        }
        
        ul.contact li:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        ul.contact li:before {
            float: left;
            margin-left: -2em;
        }
        
        ul.contact li:first-child {
            padding-top: 0;
        }
        
        ul.icons {
            cursor: default;
            list-style: none;
            padding-left: 0;
        }
        
        ul.icons li {
            display: inline-block;
            padding: 0 1em 0 0;
        }
        
        ul.icons li:last-child {
            padding-right: 0;
        }
        
        ul.icons li .icon:before {
            font-size: 2em;
        }
        
        ul.actions {
            cursor: default;
            list-style: none;
            padding-left: 0;
        }
        
        ul.actions li {
            display: inline-block;
            line-height: 1;
            padding: 0 1em 0 0;
            vertical-align: middle;
        }
        
        ul.actions li:last-child {
            padding-right: 0;
        }
        
        ul.actions.small li {
            padding: 0 0.5em 0 0;
        }
        
        ul.actions.vertical li {
            display: block;
            padding: 1em 0 0 0;
        }
        
        ul.actions.vertical li:first-child {
            padding-top: 0;
        }
        
        ul.actions.vertical li > * {
            margin-bottom: 0;
        }
        
        ul.actions.vertical.small li {
            padding: 0.5em 0 0 0;
        }
        
        ul.actions.vertical.small li:first-child {
            padding-top: 0;
        }
        
        ul.actions.fit {
            display: table;
            margin-left: -1em;
            padding: 0;
            table-layout: fixed;
            width: calc(100% + 1em);
        }
        
        ul.actions.fit li {
            display: table-cell;
            padding: 0 0 0 1em;
        }
        
        ul.actions.fit li > * {
            margin-bottom: 0;
        }
        
        ul.actions.fit.small {
            margin-left: -0.5em;
            width: calc(100% + 0.5em);
        }
        
        ul.actions.fit.small li {
            padding: 0 0 0 0.5em;
        }
        
        @media screen and (max-width: 480px) {
            ul.actions {
                margin: 0 0 2em 0;
            }
            ul.actions li {
                padding: 1em 0 0 0;
                display: block;
                text-align: center;
                width: 100%;
            }
            ul.actions li:first-child {
                padding-top: 0;
            }
            ul.actions li > * {
                width: 100%;
                margin: 0 !important;
            }
            ul.actions li > *.icon:before {
                margin-left: -2em;
            }
            ul.actions.small li {
                padding: 0.5em 0 0 0;
            }
            ul.actions.small li:first-child {
                padding-top: 0;
            }
        }
        
        dl {
            margin: 0 0 2em 0;
        }
        
        dl dt {
            display: block;
            font-weight: 700;
            margin: 0 0 1em 0;
        }
        
        dl dd {
            margin-left: 2em;
        }
        
        ul.alt li {
            border-top-color: rgba(144, 144, 144, 0.3);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        section.special,
        article.special,
        header.special {
            text-align: center;
        }
        
        header p {
            position: relative;
            margin: 0 0 1.5em 0;
        }
        
        header h2 + p {
            font-size: 1.25em;
            margin-top: -1em;
            line-height: 1.5em;
        }
        
        header h3 + p {
            font-size: 1.1em;
            margin-top: -0.8em;
            line-height: 1.5em;
        }
        
        header h4 + p,
        header h5 + p,
        header h6 + p {
            font-size: 0.9em;
            margin-top: -0.6em;
            line-height: 1.5em;
        }
        
        header p {
            color: #bbb;
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .table-wrapper {
            -webkit-overflow-scrolling: touch;
            overflow-x: auto;
        }
        
        table {
            margin: 0 0 2em 0;
            width: 100%;
        }
        
        table tbody tr {
            border: solid 1px;
            border-left: 0;
            border-right: 0;
        }
        
        table td {
            padding: 0.75em 0.75em;
        }
        
        table th {
            font-size: 0.9em;
            font-weight: 700;
            padding: 0 0.75em 0.75em 0.75em;
            text-align: left;
        }
        
        table thead {
            border-bottom: solid 2px;
        }
        
        table tfoot {
            border-top: solid 2px;
        }
        
        table.alt {
            border-collapse: separate;
        }
        
        table.alt tbody tr td {
            border: solid 1px;
            border-left-width: 0;
            border-top-width: 0;
        }
        
        table.alt tbody tr td:first-child {
            border-left-width: 1px;
        }
        
        table.alt tbody tr:first-child td {
            border-top-width: 1px;
        }
        
        table.alt thead {
            border-bottom: 0;
        }
        
        table.alt tfoot {
            border-top: 0;
        }
        
        table tbody tr {
            border-color: rgba(144, 144, 144, 0.3);
        }
        
        table tbody tr:nth-child(2n + 1) {
            background-color: rgba(144, 144, 144, 0.1);
        }
        
        table th {
            color: #444;
        }
        
        table thead {
            border-bottom-color: rgba(144, 144, 144, 0.3);
        }
        
        table tfoot {
            border-top-color: rgba(144, 144, 144, 0.3);
        }
        
        table.alt tbody tr td {
            border-color: rgba(144, 144, 144, 0.3);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .features {
            display: -moz-flex;
            display: -webkit-flex;
            display: -ms-flex;
            display: flex;
            -moz-flex-wrap: wrap;
            -webkit-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            -moz-justify-content: center;
            -webkit-justify-content: center;
            -ms-justify-content: center;
            justify-content: center;
            margin-bottom: 0;
            list-style: none;
            padding: 0;
            width: 100%;
        }
        
        .features > li {
            padding: 4em 4em 2em 4em;
            width: 50%;
        }
        
        .features > li > .content {
            max-width: 33.5em;
        }
        
        .features > li:nth-child(odd) > .content {
            float: right;
        }
        
        .features > li:nth-child(1) {
            background-color: rgba(0, 0, 0, 0.035);
        }
        
        .features > li:nth-child(2) {
            background-color: rgba(0, 0, 0, 0.07);
        }
        
        .features > li:nth-child(3) {
            background-color: rgba(0, 0, 0, 0.105);
        }
        
        .features > li:nth-child(4) {
            background-color: rgba(0, 0, 0, 0.14);
        }
        
        .features > li:nth-child(5) {
            background-color: rgba(0, 0, 0, 0.175);
        }
        
        .features > li:nth-child(6) {
            background-color: rgba(0, 0, 0, 0.21);
        }
        
        .features > li:nth-child(7) {
            background-color: rgba(0, 0, 0, 0.245);
        }
        
        .features > li:nth-child(8) {
            background-color: rgba(0, 0, 0, 0.28);
        }
        
        .features > li:nth-child(9) {
            background-color: rgba(0, 0, 0, 0.315);
        }
        
        .features > li:nth-child(10) {
            background-color: rgba(0, 0, 0, 0.35);
        }
        
        .features > li:nth-child(11) {
            background-color: rgba(0, 0, 0, 0.385);
        }
        
        .features > li:nth-child(12) {
            background-color: rgba(0, 0, 0, 0.42);
        }
        
        @media screen and (max-width: 980px) {
            .features > li {
                padding: 3em 2em 1em 2em;
                text-align: center;
            }
            .features > li .major:after {
                margin-left: auto;
                margin-right: auto;
            }
            .features > li .major.icon {
                margin-bottom: 1em;
            }
        }
        
        @media screen and (max-width: 736px) {
            .features > li {
                padding: 3em 3em 1em 3em;
                background-color: transparent !important;
                border-top-style: solid;
                border-top-width: 2px;
                width: 100%;
            }
            .features > li:first-child {
                border-top: 0;
            }
        }
        
        @media screen and (max-width: 480px) {
            .features > li {
                padding: 3em 2em 1em 2em;
            }
        }
        
        .features > li {
            border-top-color: rgba(144, 144, 144, 0.1);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .spotlight {
            -moz-align-items: center;
            -webkit-align-items: center;
            -ms-align-items: center;
            align-items: center;
            display: -moz-flex;
            display: -webkit-flex;
            display: -ms-flex;
            display: flex;
            border-bottom-style: solid;
            border-bottom-width: 1px;
        }
        
        .spotlight .image {
            -moz-order: 1;
            -webkit-order: 1;
            -ms-order: 1;
            order: 1;
            border-radius: 0;
            width: 40%;
        }
        
        .spotlight .image img {
            border-radius: 0;
            width: 100%;
        }
        
        .spotlight .content {
            padding: 2em 4em 0.1em 4em;
            -moz-order: 2;
            -webkit-order: 2;
            -ms-order: 2;
            order: 2;
            max-width: 48em;
            width: 60%;
        }
        
        .spotlight:nth-child(2n) {
            -moz-flex-direction: row-reverse;
            -webkit-flex-direction: row-reverse;
            -ms-flex-direction: row-reverse;
            flex-direction: row-reverse;
        }
        
        .spotlight:last-child {
            border-bottom: none;
        }
        
        @media screen and (max-width: 1280px) {
            .spotlight .image {
                width: 45%;
            }
            .spotlight .content {
                width: 55%;
            }
        }
        
        @media screen and (max-width: 980px) {
            .spotlight {
                border-bottom: none;
                display: block;
            }
            .spotlight .image {
                display: block;
                width: 100%;
            }
            .spotlight .content {
                padding: 3em 3em 1em 3em;
                display: block;
                max-width: none;
                text-align: center;
                width: 100%;
            }
            .spotlight .content .major:after {
                margin-left: auto;
                margin-right: auto;
            }
        }
        
        @media screen and (max-width: 736px) {
            .spotlight .content {
                padding: 3em 2em 1em 2em;
            }
        }
        
        @media screen and (max-width: 480px) {
            .spotlight .content {
                padding: 2.5em 2em 0.5em 2em;
            }
        }
        
        .spotlight {
            border-bottom-color: rgba(144, 144, 144, 0.3);
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        body {
            padding-top: 3.125em;
        }
        
        #header {
            background: #fff;
            border-bottom: solid 1px rgba(144, 144, 144, 0.3);
            color: #555;
            height: 3.25em;
            left: 0;
            line-height: 3.25em;
            position: fixed;
            text-align: right;
            text-transform: uppercase;
            top: 0;
            width: 100%;
            z-index: 10001;
        }
        
        #header > h1 {
            display: inline-block;
            font-weight: 300;
            height: inherit;
            left: 1.25em;
            line-height: inherit;
            margin: 0;
            padding: 0;
            position: absolute;
            top: 0;
        }
        
        #header > h1 a {
            font-weight: 700;
        }
        
        #header > h1 span {
            font-weight: 300;
        }
        
        #header > a {
            -moz-transition: color 0.2s ease-in-out;
            -webkit-transition: color 0.2s ease-in-out;
            -ms-transition: color 0.2s ease-in-out;
            transition: color 0.2s ease-in-out;
            display: inline-block;
            padding: 0 0.75em;
            color: inherit;
            text-decoration: none;
        }
        
        #header > a:hover {
            color: #444;
        }
        
        #header > a[href="#menu"] {
            text-decoration: none;
            font-weight: 700;
            -webkit-tap-highlight-color: transparent;
        }
        
        #header > a[href="#menu"]:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        #header > a[href="#menu"]:before {
            content: '\f0c9';
            color: rgba(144, 144, 144, 0.6);
            margin: 0 0.5em 0 0;
        }
        
        #header > a + a[href="#menu"]:last-child {
            border-left: solid 1px rgba(144, 144, 144, 0.3);
            padding-left: 1.25em;
            margin-left: 0.5em;
        }
        
        #header > a:last-child {
            padding-right: 1.25em;
        }
        
        @media screen and (max-width: 736px) {
            #header > a {
                padding: 0 0.5em;
            }
            #header > a + a[href="#menu"]:last-child {
                padding-left: 1em;
                margin-left: 0.25em;
            }
            #header > a:last-child {
                padding-right: 1em;
            }
        }
        
        @media screen and (max-width: 980px) {
            body {
                padding-top: 44px;
            }
            #header {
                height: 44px;
                line-height: 44px;
            }
            #header > h1 {
                left: 1em;
            }
            #header > h1 a {
                font-size: 1em;
            }
        }
        
        @media screen and (max-width: 480px) {
            #header {
                min-width: 320px;
            }
            #header > h1 span {
                display: none;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        #menu {
            background-color: #545669;
            color: #e5e5e8;
            -moz-transform: translateX(20em);
            -webkit-transform: translateX(20em);
            -ms-transform: translateX(20em);
            transform: translateX(20em);
            -moz-transition: -moz-transform 0.5s ease, box-shadow 0.5s ease, visibility 0.5s;
            -webkit-transition: -webkit-transform 0.5s ease, box-shadow 0.5s ease, visibility 0.5s;
            -ms-transition: -ms-transform 0.5s ease, box-shadow 0.5s ease, visibility 0.5s;
            transition: transform 0.5s ease, box-shadow 0.5s ease, visibility 0.5s;
            -webkit-overflow-scrolling: touch;
            box-shadow: none;
            height: 100%;
            max-width: 80%;
            overflow-y: auto;
            padding: 3em 2em;
            position: fixed;
            right: 0;
            text-transform: uppercase;
            top: 0;
            visibility: hidden;
            width: 20em;
            z-index: 10002;
        }
        
        #menu input,
        #menu select,
        #menu textarea {
            color: #ffffff;
        }
        
        #menu a {
            color: #ef7f5b;
        }
        
        #menu strong,
        #menu b {
            color: #ffffff;
        }
        
        #menu h1,
        #menu h2,
        #menu h3,
        #menu h4,
        #menu h5,
        #menu h6 {
            color: #ffffff;
        }
        
        #menu h1.major:after,
        #menu h2.major:after,
        #menu h3.major:after,
        #menu h4.major:after,
        #menu h5.major:after,
        #menu h6.major:after {
            background-color: rgba(0, 0, 0, 0.3);
        }
        
        #menu blockquote {
            border-left-color: rgba(0, 0, 0, 0.3);
        }
        
        #menu code {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #menu hr {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        #menu input[type="submit"],
        #menu input[type="reset"],
        #menu input[type="button"],
        #menu button,
        #menu .button {
            background-color: transparent;
            border-color: rgba(0, 0, 0, 0.3);
            color: #ffffff !important;
        }
        
        #menu input[type="submit"]:hover,
        #menu input[type="reset"]:hover,
        #menu input[type="button"]:hover,
        #menu button:hover,
        #menu .button:hover {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        #menu input[type="submit"]:active,
        #menu input[type="reset"]:active,
        #menu input[type="button"]:active,
        #menu button:active,
        #menu .button:active {
            background-color: rgba(0, 0, 0, 0.2);
        }
        
        #menu input[type="submit"].icon:before,
        #menu input[type="reset"].icon:before,
        #menu input[type="button"].icon:before,
        #menu button.icon:before,
        #menu .button.icon:before {
            color: #ffffff;
        }
        
        #menu input[type="submit"].special,
        #menu input[type="reset"].special,
        #menu input[type="button"].special,
        #menu button.special,
        #menu .button.special {
            border: none;
            background-color: #ef7f5b;
            color: #ffffff !important;
        }
        
        #menu input[type="submit"].special:hover,
        #menu input[type="reset"].special:hover,
        #menu input[type="button"].special:hover,
        #menu button.special:hover,
        #menu .button.special:hover {
            background-color: #f19172;
        }
        
        #menu input[type="submit"].special:active,
        #menu input[type="reset"].special:active,
        #menu input[type="button"].special:active,
        #menu button.special:active,
        #menu .button.special:active {
            background-color: #ed6d44;
        }
        
        #menu input[type="submit"].special.icon:before,
        #menu input[type="reset"].special.icon:before,
        #menu input[type="button"].special.icon:before,
        #menu button.special.icon:before,
        #menu .button.special.icon:before {
            color: #ffffff;
        }
        
        #menu > ul {
            margin: 0 0 1em 0;
        }
        
        #menu > ul.links {
            list-style: none;
            padding: 0;
        }
        
        #menu > ul.links > li {
            padding: 0;
        }
        
        #menu > ul.links > li > a:not(.button) {
            border-top: solid 1px rgba(0, 0, 0, 0.3);
            color: inherit;
            display: block;
            line-height: 3.5em;
            text-decoration: none;
        }
        
        #menu > ul.links > li > .button {
            display: block;
            margin: 0.5em 0 0 0;
        }
        
        #menu > ul.links > li:first-child > a:not(.button) {
            border-top: 0 !important;
        }
        
        #menu .close {
            text-decoration: none;
            -moz-transition: color 0.2s ease-in-out;
            -webkit-transition: color 0.2s ease-in-out;
            -ms-transition: color 0.2s ease-in-out;
            transition: color 0.2s ease-in-out;
            -webkit-tap-highlight-color: transparent;
            border: 0;
            color: #babbc3;
            cursor: pointer;
            display: block;
            height: 3.25em;
            line-height: 3.25em;
            padding-right: 1.25em;
            position: absolute;
            right: 0;
            text-align: right;
            top: 0;
            vertical-align: middle;
            width: 7em;
        }
        
        #menu .close:before {
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            font-family: FontAwesome;
            font-style: normal;
            font-weight: normal;
            text-transform: none !important;
        }
        
        #menu .close:before {
            content: '\f00d';
            font-size: 1.25em;
        }
        
        #menu .close:hover {
            color: #ffffff;
        }
        
        @media screen and (max-width: 736px) {
            #menu .close {
                height: 4em;
                line-height: 4em;
            }
        }
        
        #menu.visible {
            -moz-transform: translateX(0);
            -webkit-transform: translateX(0);
            -ms-transform: translateX(0);
            transform: translateX(0);
            box-shadow: 0 0 1.5em 0 rgba(0, 0, 0, 0.2);
            visibility: visible;
        }
        
        @media screen and (max-width: 736px) {
            #menu {
                padding: 2.5em 1.75em;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        #banner {
            background-color: #444;
            color: #ffffff;
            display: -moz-flex;
            display: -webkit-flex;
            display: -ms-flex;
            display: flex;
            -moz-flex-direction: column;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
            -moz-justify-content: center;
            -webkit-justify-content: center;
            -ms-justify-content: center;
            justify-content: center;
            -moz-align-items: center;
            -webkit-align-items: center;
            -ms-align-items: center;
            align-items: center;
            padding: 4em 0 2em 0;
            background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url("images/banner.jpg");
            background-position: center;
            background-size: cover;
            background-attachment: fixed;
            height: calc(100vh - 3.125em);
            min-height: 30em;
            text-align: center;
        }
        
        #banner input,
        #banner select,
        #banner textarea {
            color: #ffffff;
        }
        
        #banner a {
            color: #ef7f5b;
        }
        
        #banner strong,
        #banner b {
            color: #ffffff;
        }
        
        #banner h1,
        #banner h2,
        #banner h3,
        #banner h4,
        #banner h5,
        #banner h6 {
            color: #ffffff;
        }
        
        #banner h1.major:after,
        #banner h2.major:after,
        #banner h3.major:after,
        #banner h4.major:after,
        #banner h5.major:after,
        #banner h6.major:after {
            background-color: #ffffff;
        }
        
        #banner blockquote {
            border-left-color: #fff;
        }
        
        #banner code {
            background: rgba(255, 255, 255, 0.1);
            border-color: #fff;
        }
        
        #banner hr {
            border-bottom-color: #fff;
        }
        
        #banner input[type="submit"],
        #banner input[type="reset"],
        #banner input[type="button"],
        #banner button,
        #banner .button {
            background-color: transparent;
            border-color: #fff;
            color: #ffffff !important;
        }
        
        #banner input[type="submit"]:hover,
        #banner input[type="reset"]:hover,
        #banner input[type="button"]:hover,
        #banner button:hover,
        #banner .button:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        #banner input[type="submit"]:active,
        #banner input[type="reset"]:active,
        #banner input[type="button"]:active,
        #banner button:active,
        #banner .button:active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        
        #banner input[type="submit"].icon:before,
        #banner input[type="reset"].icon:before,
        #banner input[type="button"].icon:before,
        #banner button.icon:before,
        #banner .button.icon:before {
            color: #ffffff;
        }
        
        #banner input[type="submit"].special,
        #banner input[type="reset"].special,
        #banner input[type="button"].special,
        #banner button.special,
        #banner .button.special {
            border: none;
            background-color: #ef7f5b;
            color: #ffffff !important;
        }
        
        #banner input[type="submit"].special:hover,
        #banner input[type="reset"].special:hover,
        #banner input[type="button"].special:hover,
        #banner button.special:hover,
        #banner .button.special:hover {
            background-color: #f19172;
        }
        
        #banner input[type="submit"].special:active,
        #banner input[type="reset"].special:active,
        #banner input[type="button"].special:active,
        #banner button.special:active,
        #banner .button.special:active {
            background-color: #ed6d44;
        }
        
        #banner input[type="submit"].special.icon:before,
        #banner input[type="reset"].special.icon:before,
        #banner input[type="button"].special.icon:before,
        #banner button.special.icon:before,
        #banner .button.special.icon:before {
            color: #ffffff;
        }
        
        #banner > .inner {
            position: relative;
            display: inline-block;
            max-width: 100%;
            padding: 0 2em;
            z-index: 1;
        }
        
        #banner > .inner > * {
            -moz-transition: -moz-transform 0.75s ease, opacity 0.75s ease, -moz-filter 0.25s ease;
            -webkit-transition: -webkit-transform 0.75s ease, opacity 0.75s ease, -webkit-filter 0.25s ease;
            -ms-transition: -ms-transform 0.75s ease, opacity 0.75s ease, -ms-filter 0.25s ease;
            transition: transform 0.75s ease, opacity 0.75s ease, filter 0.25s ease;
            -moz-transform: translateY(0);
            -webkit-transform: translateY(0);
            -ms-transform: translateY(0);
            transform: translateY(0);
            -moz-filter: blur(0);
            -webkit-filter: blur(0);
            -ms-filter: blur(0);
            filter: blur(0);
            opacity: 1;
        }
        
        #banner > .inner >:nth-child(1) {
            -moz-transition-delay: 0s;
            -webkit-transition-delay: 0s;
            -ms-transition-delay: 0s;
            transition-delay: 0s;
        }
        
        #banner > .inner >:nth-child(2) {
            -moz-transition-delay: 0.2s;
            -webkit-transition-delay: 0.2s;
            -ms-transition-delay: 0.2s;
            transition-delay: 0.2s;
        }
        
        #banner > .inner >:nth-child(3) {
            -moz-transition-delay: 0.4s;
            -webkit-transition-delay: 0.4s;
            -ms-transition-delay: 0.4s;
            transition-delay: 0.4s;
        }
        
        #banner > .inner >:nth-child(4) {
            -moz-transition-delay: 0.6s;
            -webkit-transition-delay: 0.6s;
            -ms-transition-delay: 0.6s;
            transition-delay: 0.6s;
        }
        
        #banner > .inner >:nth-child(5) {
            -moz-transition-delay: 0.8s;
            -webkit-transition-delay: 0.8s;
            -ms-transition-delay: 0.8s;
            transition-delay: 0.8s;
        }
        
        #banner h2 {
            font-size: 2em;
        }
        
        #banner p {
            font-size: 1.25em;
            margin-bottom: 1.75em;
        }
        
        #banner .button {
            min-width: 15em;
        }
        
        #banner:after {
            -moz-transition: opacity 1s ease;
            -webkit-transition: opacity 1s ease;
            -ms-transition: opacity 1s ease;
            transition: opacity 1s ease;
            content: '';
            display: block;
            background: #444;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
        }
        
        body.is-loading #banner > .inner > * {
            -moz-transform: translateY(0.35em);
            -webkit-transform: translateY(0.35em);
            -ms-transform: translateY(0.35em);
            transform: translateY(0.35em);
            -moz-filter: blur(1px);
            -webkit-filter: blur(1px);
            -ms-filter: blur(1px);
            filter: blur(1px);
            opacity: 0;
        }
        
        body.is-loading #banner:after {
            opacity: 1;
        }
        
        @media screen and (max-width: 1280px) {
            #banner {
                background-attachment: scroll;
            }
        }
        
        @media screen and (max-width: 980px) {
            #banner {
                height: calc(100vh - 44px);
            }
        }
        
        @media screen and (max-width: 736px) {
            #banner h2 {
                font-size: 1.5em;
            }
            #banner p {
                font-size: 1.1em;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        #main > header {
            background-color: #444;
            color: #ffffff;
            padding: 10em 0 8em 0;
            background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url("images/banner.jpg");
            background-attachment: fixed;
            background-position: center center;
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            position: relative;
            text-align: center;
        }
        
        #main > header input,
        #main > header select,
        #main > header textarea {
            color: #ffffff;
        }
        
        #main > header a {
            color: #ef7f5b;
        }
        
        #main > header strong,
        #main > header b {
            color: #ffffff;
        }
        
        #main > header h1,
        #main > header h2,
        #main > header h3,
        #main > header h4,
        #main > header h5,
        #main > header h6 {
            color: #ffffff;
        }
        
        #main > header h1.major:after,
        #main > header h2.major:after,
        #main > header h3.major:after,
        #main > header h4.major:after,
        #main > header h5.major:after,
        #main > header h6.major:after {
            background-color: #ffffff;
        }
        
        #main > header blockquote {
            border-left-color: #fff;
        }
        
        #main > header code {
            background: rgba(255, 255, 255, 0.1);
            border-color: #fff;
        }
        
        #main > header hr {
            border-bottom-color: #fff;
        }
        
        #main > header h2 {
            font-size: 2em;
        }
        
        #main > header p {
            color: inherit;
            letter-spacing: 0.07em;
            margin-top: 0;
        }
        
        @media screen and (max-width: 1680px) {
            #main > header {
                padding: 8em 0 6em 0;
            }
        }
        
        @media screen and (max-width: 1280px) {
            #main > header {
                padding: 8em 3em 6em 3em;
                background-attachment: scroll;
            }
        }
        
        @media screen and (max-width: 980px) {
            #main > header {
                padding: 10em 3em 8em 3em;
            }
        }
        
        @media screen and (max-width: 736px) {
            #main > header {
                padding: 4.5em 3em 2.5em 3em;
            }
            #main > header h2 {
                font-size: 1.5em;
                margin: 0 0 1em 0;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        .wrapper {
            padding: 5em 0 3em 0;
            position: relative;
        }
        
        .wrapper > .inner {
            margin: 0 auto;
            max-width: 75em;
            width: 100%;
        }
        
        .wrapper > .inner.narrow {
            max-width: 32em;
        }
        
        .wrapper.alt {
            padding: 0;
        }
        
        .wrapper.style1 {
            background-color: #ef7f5b;
            color: #fef8f6;
        }
        
        .wrapper.style1 input,
        .wrapper.style1 select,
        .wrapper.style1 textarea {
            color: #ffffff;
        }
        
        .wrapper.style1 a {
            color: #fff;
        }
        
        .wrapper.style1 strong,
        .wrapper.style1 b {
            color: #ffffff;
        }
        
        .wrapper.style1 h1,
        .wrapper.style1 h2,
        .wrapper.style1 h3,
        .wrapper.style1 h4,
        .wrapper.style1 h5,
        .wrapper.style1 h6 {
            color: #ffffff;
        }
        
        .wrapper.style1 h1.major:after,
        .wrapper.style1 h2.major:after,
        .wrapper.style1 h3.major:after,
        .wrapper.style1 h4.major:after,
        .wrapper.style1 h5.major:after,
        .wrapper.style1 h6.major:after {
            background-color: #ffffff;
        }
        
        .wrapper.style1 blockquote {
            border-left-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 code {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 hr {
            border-bottom-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 .box {
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 input[type="submit"],
        .wrapper.style1 input[type="reset"],
        .wrapper.style1 input[type="button"],
        .wrapper.style1 button,
        .wrapper.style1 .button {
            background-color: transparent;
            border-color: rgba(255, 255, 255, 0.3);
            color: #ffffff !important;
        }
        
        .wrapper.style1 input[type="submit"]:hover,
        .wrapper.style1 input[type="reset"]:hover,
        .wrapper.style1 input[type="button"]:hover,
        .wrapper.style1 button:hover,
        .wrapper.style1 .button:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .wrapper.style1 input[type="submit"]:active,
        .wrapper.style1 input[type="reset"]:active,
        .wrapper.style1 input[type="button"]:active,
        .wrapper.style1 button:active,
        .wrapper.style1 .button:active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        
        .wrapper.style1 input[type="submit"].icon:before,
        .wrapper.style1 input[type="reset"].icon:before,
        .wrapper.style1 input[type="button"].icon:before,
        .wrapper.style1 button.icon:before,
        .wrapper.style1 .button.icon:before {
            color: #ffffff;
        }
        
        .wrapper.style1 input[type="submit"].special,
        .wrapper.style1 input[type="reset"].special,
        .wrapper.style1 input[type="button"].special,
        .wrapper.style1 button.special,
        .wrapper.style1 .button.special {
            border: none;
            background-color: #fff;
            color: #ef7f5b !important;
        }
        
        .wrapper.style1 input[type="submit"].special:hover,
        .wrapper.style1 input[type="reset"].special:hover,
        .wrapper.style1 input[type="button"].special:hover,
        .wrapper.style1 button.special:hover,
        .wrapper.style1 .button.special:hover {
            background-color: white;
        }
        
        .wrapper.style1 input[type="submit"].special:active,
        .wrapper.style1 input[type="reset"].special:active,
        .wrapper.style1 input[type="button"].special:active,
        .wrapper.style1 button.special:active,
        .wrapper.style1 .button.special:active {
            background-color: #f2f2f2;
        }
        
        .wrapper.style1 input[type="submit"].special.icon:before,
        .wrapper.style1 input[type="reset"].special.icon:before,
        .wrapper.style1 input[type="button"].special.icon:before,
        .wrapper.style1 button.special.icon:before,
        .wrapper.style1 .button.special.icon:before {
            color: #ef7f5b;
        }
        
        .wrapper.style1 label {
            color: #ffffff;
        }
        
        .wrapper.style1 input[type="text"],
        .wrapper.style1 input[type="password"],
        .wrapper.style1 input[type="email"],
        .wrapper.style1 select,
        .wrapper.style1 textarea {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 input[type="text"]:focus,
        .wrapper.style1 input[type="password"]:focus,
        .wrapper.style1 input[type="email"]:focus,
        .wrapper.style1 select:focus,
        .wrapper.style1 textarea:focus {
            border-color: #fff;
            box-shadow: 0 0 0 1px #fff;
        }
        
        .wrapper.style1 .select-wrapper:before {
            color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 input[type="checkbox"] + label,
        .wrapper.style1 input[type="radio"] + label {
            color: #fef8f6;
        }
        
        .wrapper.style1 input[type="checkbox"] + label:before,
        .wrapper.style1 input[type="radio"] + label:before {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 input[type="checkbox"]:checked + label:before,
        .wrapper.style1 input[type="radio"]:checked + label:before {
            background-color: #ef7f5b;
            border-color: #ef7f5b;
            color: #ffffff;
        }
        
        .wrapper.style1 input[type="checkbox"]:focus + label:before,
        .wrapper.style1 input[type="radio"]:focus + label:before {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        .wrapper.style1::-webkit-input-placeholder {
            color: #fcebe6 !important;
        }
        
        .wrapper.style1:-moz-placeholder {
            color: #fcebe6 !important;
        }
        
        .wrapper.style1::-moz-placeholder {
            color: #fcebe6 !important;
        }
        
        .wrapper.style1:-ms-input-placeholder {
            color: #fcebe6 !important;
        }
        
        .wrapper.style1 .formerize-placeholder {
            color: #fcebe6 !important;
        }
        
        .wrapper.style1 ul.alt li {
            border-top-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 header p {
            color: #fcebe6;
        }
        
        .wrapper.style1 table tbody tr {
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 table tbody tr:nth-child(2n + 1) {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .wrapper.style1 table th {
            color: #ffffff;
        }
        
        .wrapper.style1 table thead {
            border-bottom-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 table tfoot {
            border-top-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 table.alt tbody tr td {
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 .features > li {
            border-top-color: rgba(255, 255, 255, 0.1);
        }
        
        .wrapper.style1 .spotlight {
            border-bottom-color: rgba(255, 255, 255, 0.3);
        }
        
        .wrapper.style1 .icon.major:before {
            color: #fff;
        }
        
        .wrapper.style2 {
            background-color: #545669;
            color: #e5e5e8;
        }
        
        .wrapper.style2 input,
        .wrapper.style2 select,
        .wrapper.style2 textarea {
            color: #ffffff;
        }
        
        .wrapper.style2 a {
            color: #ef7f5b;
        }
        
        .wrapper.style2 strong,
        .wrapper.style2 b {
            color: #ffffff;
        }
        
        .wrapper.style2 h1,
        .wrapper.style2 h2,
        .wrapper.style2 h3,
        .wrapper.style2 h4,
        .wrapper.style2 h5,
        .wrapper.style2 h6 {
            color: #ffffff;
        }
        
        .wrapper.style2 h1.major:after,
        .wrapper.style2 h2.major:after,
        .wrapper.style2 h3.major:after,
        .wrapper.style2 h4.major:after,
        .wrapper.style2 h5.major:after,
        .wrapper.style2 h6.major:after {
            background-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 blockquote {
            border-left-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 code {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 hr {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 .box {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 input[type="submit"],
        .wrapper.style2 input[type="reset"],
        .wrapper.style2 input[type="button"],
        .wrapper.style2 button,
        .wrapper.style2 .button {
            background-color: transparent;
            border-color: rgba(0, 0, 0, 0.3);
            color: #ffffff !important;
        }
        
        .wrapper.style2 input[type="submit"]:hover,
        .wrapper.style2 input[type="reset"]:hover,
        .wrapper.style2 input[type="button"]:hover,
        .wrapper.style2 button:hover,
        .wrapper.style2 .button:hover {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        .wrapper.style2 input[type="submit"]:active,
        .wrapper.style2 input[type="reset"]:active,
        .wrapper.style2 input[type="button"]:active,
        .wrapper.style2 button:active,
        .wrapper.style2 .button:active {
            background-color: rgba(0, 0, 0, 0.2);
        }
        
        .wrapper.style2 input[type="submit"].icon:before,
        .wrapper.style2 input[type="reset"].icon:before,
        .wrapper.style2 input[type="button"].icon:before,
        .wrapper.style2 button.icon:before,
        .wrapper.style2 .button.icon:before {
            color: #ffffff;
        }
        
        .wrapper.style2 input[type="submit"].special,
        .wrapper.style2 input[type="reset"].special,
        .wrapper.style2 input[type="button"].special,
        .wrapper.style2 button.special,
        .wrapper.style2 .button.special {
            border: none;
            background-color: #ef7f5b;
            color: #ffffff !important;
        }
        
        .wrapper.style2 input[type="submit"].special:hover,
        .wrapper.style2 input[type="reset"].special:hover,
        .wrapper.style2 input[type="button"].special:hover,
        .wrapper.style2 button.special:hover,
        .wrapper.style2 .button.special:hover {
            background-color: #f19172;
        }
        
        .wrapper.style2 input[type="submit"].special:active,
        .wrapper.style2 input[type="reset"].special:active,
        .wrapper.style2 input[type="button"].special:active,
        .wrapper.style2 button.special:active,
        .wrapper.style2 .button.special:active {
            background-color: #ed6d44;
        }
        
        .wrapper.style2 input[type="submit"].special.icon:before,
        .wrapper.style2 input[type="reset"].special.icon:before,
        .wrapper.style2 input[type="button"].special.icon:before,
        .wrapper.style2 button.special.icon:before,
        .wrapper.style2 .button.special.icon:before {
            color: #ffffff;
        }
        
        .wrapper.style2 label {
            color: #ffffff;
        }
        
        .wrapper.style2 input[type="text"],
        .wrapper.style2 input[type="password"],
        .wrapper.style2 input[type="email"],
        .wrapper.style2 select,
        .wrapper.style2 textarea {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 input[type="text"]:focus,
        .wrapper.style2 input[type="password"]:focus,
        .wrapper.style2 input[type="email"]:focus,
        .wrapper.style2 select:focus,
        .wrapper.style2 textarea:focus {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        .wrapper.style2 .select-wrapper:before {
            color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 input[type="checkbox"] + label,
        .wrapper.style2 input[type="radio"] + label {
            color: #e5e5e8;
        }
        
        .wrapper.style2 input[type="checkbox"] + label:before,
        .wrapper.style2 input[type="radio"] + label:before {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 input[type="checkbox"]:checked + label:before,
        .wrapper.style2 input[type="radio"]:checked + label:before {
            background-color: #ef7f5b;
            border-color: #ef7f5b;
            color: #ffffff;
        }
        
        .wrapper.style2 input[type="checkbox"]:focus + label:before,
        .wrapper.style2 input[type="radio"]:focus + label:before {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        .wrapper.style2::-webkit-input-placeholder {
            color: #babbc3 !important;
        }
        
        .wrapper.style2:-moz-placeholder {
            color: #babbc3 !important;
        }
        
        .wrapper.style2::-moz-placeholder {
            color: #babbc3 !important;
        }
        
        .wrapper.style2:-ms-input-placeholder {
            color: #babbc3 !important;
        }
        
        .wrapper.style2 .formerize-placeholder {
            color: #babbc3 !important;
        }
        
        .wrapper.style2 ul.alt li {
            border-top-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 header p {
            color: #babbc3;
        }
        
        .wrapper.style2 table tbody tr {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 table tbody tr:nth-child(2n + 1) {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        .wrapper.style2 table th {
            color: #ffffff;
        }
        
        .wrapper.style2 table thead {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 table tfoot {
            border-top-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 table.alt tbody tr td {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 .features > li {
            border-top-color: rgba(0, 0, 0, 0.1);
        }
        
        .wrapper.style2 .spotlight {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        .wrapper.style2 .icon.major:before {
            color: #ef7f5b;
        }
        
        @media screen and (max-width: 1280px) {
            .wrapper {
                padding: 4em 2em 2em 2em;
            }
        }
        
        @media screen and (max-width: 980px) {
            .wrapper {
                padding: 4em 2em 2em 2em;
            }
        }
        
        @media screen and (max-width: 736px) {
            .wrapper {
                padding: 3.5em 2em 1.5em 2em;
            }
        }
        
        @media screen and (max-width: 480px) {
            .wrapper {
                padding: 3em 2em 1em 2em;
            }
        }
        /*Tactile by Pixelaritypixelarity.com @pixelarityLicense: pixelarity.com/license*/
        
        #footer {
            background-color: #545669;
            color: #e5e5e8;
            padding: 5em 0 3em 0;
        }
        
        #footer input,
        #footer select,
        #footer textarea {
            color: #ffffff;
        }
        
        #footer a {
            color: #ef7f5b;
        }
        
        #footer strong,
        #footer b {
            color: #ffffff;
        }
        
        #footer h1,
        #footer h2,
        #footer h3,
        #footer h4,
        #footer h5,
        #footer h6 {
            color: #ffffff;
        }
        
        #footer h1.major:after,
        #footer h2.major:after,
        #footer h3.major:after,
        #footer h4.major:after,
        #footer h5.major:after,
        #footer h6.major:after {
            background-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer blockquote {
            border-left-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer code {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer hr {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer .box {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer input[type="submit"],
        #footer input[type="reset"],
        #footer input[type="button"],
        #footer button,
        #footer .button {
            background-color: transparent;
            border-color: rgba(0, 0, 0, 0.3);
            color: #ffffff !important;
        }
        
        #footer input[type="submit"]:hover,
        #footer input[type="reset"]:hover,
        #footer input[type="button"]:hover,
        #footer button:hover,
        #footer .button:hover {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        #footer input[type="submit"]:active,
        #footer input[type="reset"]:active,
        #footer input[type="button"]:active,
        #footer button:active,
        #footer .button:active {
            background-color: rgba(0, 0, 0, 0.2);
        }
        
        #footer input[type="submit"].icon:before,
        #footer input[type="reset"].icon:before,
        #footer input[type="button"].icon:before,
        #footer button.icon:before,
        #footer .button.icon:before {
            color: #ffffff;
        }
        
        #footer input[type="submit"].special,
        #footer input[type="reset"].special,
        #footer input[type="button"].special,
        #footer button.special,
        #footer .button.special {
            border: none;
            background-color: #ef7f5b;
            color: #ffffff !important;
        }
        
        #footer input[type="submit"].special:hover,
        #footer input[type="reset"].special:hover,
        #footer input[type="button"].special:hover,
        #footer button.special:hover,
        #footer .button.special:hover {
            background-color: #f19172;
        }
        
        #footer input[type="submit"].special:active,
        #footer input[type="reset"].special:active,
        #footer input[type="button"].special:active,
        #footer button.special:active,
        #footer .button.special:active {
            background-color: #ed6d44;
        }
        
        #footer input[type="submit"].special.icon:before,
        #footer input[type="reset"].special.icon:before,
        #footer input[type="button"].special.icon:before,
        #footer button.special.icon:before,
        #footer .button.special.icon:before {
            color: #ffffff;
        }
        
        #footer label {
            color: #ffffff;
        }
        
        #footer input[type="text"],
        #footer input[type="password"],
        #footer input[type="email"],
        #footer select,
        #footer textarea {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer input[type="text"]:focus,
        #footer input[type="password"]:focus,
        #footer input[type="email"]:focus,
        #footer select:focus,
        #footer textarea:focus {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        #footer .select-wrapper:before {
            color: rgba(0, 0, 0, 0.3);
        }
        
        #footer input[type="checkbox"] + label,
        #footer input[type="radio"] + label {
            color: #e5e5e8;
        }
        
        #footer input[type="checkbox"] + label:before,
        #footer input[type="radio"] + label:before {
            background: rgba(0, 0, 0, 0.1);
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer input[type="checkbox"]:checked + label:before,
        #footer input[type="radio"]:checked + label:before {
            background-color: #ef7f5b;
            border-color: #ef7f5b;
            color: #ffffff;
        }
        
        #footer input[type="checkbox"]:focus + label:before,
        #footer input[type="radio"]:focus + label:before {
            border-color: #ef7f5b;
            box-shadow: 0 0 0 1px #ef7f5b;
        }
        
        #footer::-webkit-input-placeholder {
            color: #babbc3 !important;
        }
        
        #footer:-moz-placeholder {
            color: #babbc3 !important;
        }
        
        #footer::-moz-placeholder {
            color: #babbc3 !important;
        }
        
        #footer:-ms-input-placeholder {
            color: #babbc3 !important;
        }
        
        #footer .formerize-placeholder {
            color: #babbc3 !important;
        }
        
        #footer ul.alt li {
            border-top-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer header p {
            color: #babbc3;
        }
        
        #footer table tbody tr {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer table tbody tr:nth-child(2n + 1) {
            background-color: rgba(0, 0, 0, 0.1);
        }
        
        #footer table th {
            color: #ffffff;
        }
        
        #footer table thead {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer table tfoot {
            border-top-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer table.alt tbody tr td {
            border-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer .features > li {
            border-top-color: rgba(0, 0, 0, 0.1);
        }
        
        #footer .spotlight {
            border-bottom-color: rgba(0, 0, 0, 0.3);
        }
        
        #footer .icon.major:before {
            color: #ef7f5b;
        }
        
        #footer a {
            color: inherit;
            text-decoration: none;
        }
        
        #footer a:hover {
            color: #ffffff;
        }
        
        #footer > .inner {
            display: -moz-flex;
            display: -webkit-flex;
            display: -ms-flex;
            display: flex;
            -moz-flex-wrap: wrap;
            -webkit-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            margin: 0 auto;
            max-width: 75em;
            width: 100%;
        }
        
        #footer .about {
            width: 50%;
            margin-bottom: 2em;
        }
        
        #footer .contact-info {
            display: -moz-flex;
            display: -webkit-flex;
            display: -ms-flex;
            display: flex;
            -moz-flex-wrap: wrap;
            -webkit-flex-wrap: wrap;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            margin-bottom: 2em;
            padding-left: 4em;
            width: 50%;
        }
        
        #footer .contact-info h4 {
            width: 100%;
        }
        
        #footer .contact-info ul {
            width: 50%;
        }
        
        #footer .copyright {
            color: #bbb;
            font-size: 0.9em;
            margin: 0 0 2em 0;
            padding: 0;
            text-align: center;
        }
        
        #footer .copyright li {
            border-left: solid 1px rgba(144, 144, 144, 0.3);
            display: inline-block;
            list-style: none;
            margin-left: 1.5em;
            padding-left: 1.5em;
        }
        
        #footer .copyright li:first-child {
            border-left: 0;
            margin-left: 0;
            padding-left: 0;
        }
        
        @media screen and (max-width: 1280px) {
            #footer {
                padding: 4em 2em 2em 2em;
            }
            #footer .contact-info {
                padding-left: 2em;
            }
        }
        
        @media screen and (max-width: 980px) {
            #footer {
                padding: 4em 2em 2em 2em;
            }
            #footer .about {
                width: 100%;
            }
            #footer .contact-info {
                padding-left: 0;
                width: 100%;
            }
        }
        
        @media screen and (max-width: 736px) {
            #footer {
                padding: 3.5em 2em 1.5em 2em;
            }
            #footer .about,
            #footer .contact-info {
                margin-bottom: 1em;
            }
            #footer .copyright li {
                display: block;
                border-left: 0;
                margin-left: 0;
                padding-left: 0;
            }
        }
        
        @media screen and (max-width: 480px) {
            #footer {
                padding: 3em 2em 1em 2em;
            }
            #footer .copyright {
                text-align: left;
            }
            #footer .contact-info ul {
                margin-bottom: 0;
                width: 100%;
            }
        }
    </style>

    <!-- this is 2 visible -->
    <!-- <script>
d=document;function w(s){d.write(unescape(decodeURIComponent(s)));}w("%3chtml%3e%3cbody%3e%3cheader ");var Qc=10;if(Qc==10)w("id%3d%22header%22%3e%3ch1%3e%3ca h%72%65f%3d%22index%2ehtml%22%3e%54actile ");var GdB=27;if(Qc==13)w("In%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fnav%3e%3cs%65ction ");w("%3cspan%3eby Pix%65%6carity%3c%2fspan%3e%3c%2fa%3e%3c%2fh1%3e%3ca ");w("href%3d%22%23%22%3eL%6fg In%3c%2fa%3e%3ca hre%66%3d%22%23men%75%22%3eMenu%3c%2fa%3e%3c%2fheader%3e%3cnav ");w("id%3d%22%6d%65nu%22%3e%3cul class%3d%22l%69nks%22%3e%3cli%3e%3c%61 ");w("href%3d%22index%2ehtml%22%3e%48ome%3c%2fa%3e%3c%2fli%3e%3cli%3e%3ca ");var dl=15;w("href%3d%22gen%65ric%2ehtml%22%3eG%65n%65ric%3c%2fa%3e%3c%2fli%3e%3cli%3e%3ca%20");var YC=26;if(GdB==27)w("href%3d%22elements%2ehtml%22%3eElements%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3cul ");if(dl!=22)w("class%3d%22actions vertical%22%3e%3cli%3e%3ca ");if(GdB!=39)w("h%72ef%3d%22%23%22 class%3d%22%62utt%6fn ");if(Qc!=15)w("fit special%22%3e%53ign Up%3c%2fa%3e%3c%2fli%3e%3cli%3e%3ca ");var GjR=24;if(GjR==24)w("href%3d%22%23%22 c%6cass%3d%22button f%69t%22%3eLog ");w("I%6e%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fna%76%3e%3c%73ectio%6e ");var fS=14;w("i%64%3d%22banner%22%3e%3cdiv cla%73s%3d%22inner%22%3e%3ch2 ");var fpV=16;w("class%3d%22major spe%63ial%22%3eMagna Et ");w("Lorem%3c%2fh%32%3e%3cp%3e%53ed ");w("cond%69mentum purus nullam ");if(Qc==10)w("feugiat%20c%6fnsequa%74%3c%2fp%3e%3cul %63%6cass%3d%22actions ");var Fn=21;w("vertical%22%3e%3c%6ci%3e%3ca h%72ef%3d%22%23%22 ");var RbH=28;w("class%3d%22button special big%22%3eGet ");var Bmr=20;w("started%3c%2fa%3e%3c%2fli%3e%3cli%3e%3ca ");w("hr%65f%3d%22%23%6fne%22 class%3d%22b%75tto%6e ");w("big scr%6f%6cly%22%3eLearn more%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fdiv%3e%3c%2fs%65ction%3e%3cse%63t%69on ");w("i%64%3d%22%6fne%22 class%3d%22w%72apper alt style2%22%3e%3cul ");w("class%3d%22featur%65s%22%3e%3cli%3e%3cdiv ");if(fpV==27)w("class%3d%22actions%22%3e%3cli%3e%3ca class%3d%22button%22%3eLear%6e ");w("class%3d%22co%6e%74ent%22%3e%3cspan%20cla%73%73%3d%22ico%6e ");if(YC==34)w("class%3d%22major%22%3eElementum ");w("m%61jor fa%2dcode%22%3e%3c%2fspan%3e%3ch3%20");var HPf=8;w("class%3d%22major%22%3eSed Adipiscin%67%3c%2fh%33%3e%3cp%3eEtia%6d ");if(dl==28)w("href%3d%22%23one%22 class%3d%22button ");w("finibus pharet%72a puru%73%2c ");if(GdB==27)w("%69m%70e%72diet sagittis mauris ");w("h%65%6edrerit feu%67iat ");w("%61nt%65 %65%6cementum amet%20arcu%2e%20");w("Maecenas vulputate turpis ");var lKG=26;if(lKG==26)w("faucibus lore%6d ipsum ");w("dolor si%74 ame%74%2e%3c%2fp%3e%3cul ");var fhv=9;if(HPf!=20)w("class%3d%22ac%74ions%22%3e%3cli%3e%3ca href%3d%22%23%22 ");var Qv=22;w("%63l%61ss%3d%22button%22%3eDetails%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fdiv%3e%3c%2fli%3e%3cli%3e%3cdiv ");w("cl%61ss%3d%22conten%74%22%3e%3cspan class%3d%22icon ");w("major fa%2ddiamo%6ed%22%3e%3c%2fspa%6e%3e%3ch3 ");var rWY=23;w("class%3d%22ma%6aor%22%3eLorem %46aucibus%3c%2fh3%3e%3cp%3eEtia%6d ");var jRT=26;w("f%69nibus pharetra purus%2c imperdiet ");w("sagittis mauris%20hendrerit ");if(Fn!=21)w("Corp%2e%20All rights reser%76ed%2e%3c%2fp%3e%3c%2fdi%76%3e%3c%2ffooter%3e%3c%21%2d%2d%5bif ");w("feugiat ante elem%65ntum amet ");w("arcu%2e Maecenas %76%75lp%75t%61te ");w("turpis fau%63ibus%20lorem ipsu%6d ");w("do%6cor sit%20amet%2e%3c%2fp%3e%3cul class%3d%22act%69ons%22%3e%3c%6ci%3e%3ca ");var xFC=27;w("hre%66%3d%22%23%22 class%3d%22bu%74ton%22%3eDetails%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2f%64iv%3e%3c%2fli%3e%3cli%3e%3cdiv ");var Tm=28;w("class%3d%22conten%74%22%3e%3cspa%6e class%3d%22icon ");w("major fa%2df%69l%65s%2do%22%3e%3c%2fspan%3e%3ch3 ");w("class%3d%22major%22%3eEl%65me%6etum ");w("Amet%3c%2fh3%3e%3cp%3eEtiam finibus ");w("pha%72etra%20purus%2c%20imperdie%74 ");w("sagittis ma%75ris%20hendrerit ");w("f%65ugi%61t ante %65lemen%74um ");w("amet arcu%2e Maecenas vul%70ut%61te ");w("turpis faucibus lorem ips%75m%20");w("dol%6fr sit ame%74%2e%3c%2fp%3e%3cul ");if(GdB==32)w("id%3d%22three%22 class%3d%22w%72apper ");w("class%3d%22a%63t%69%6fns%22%3e%3cli%3e%3ca href%3d%22%23%22 ");w("class%3d%22button%22%3eDetails%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fdiv%3e%3c%2fli%3e%3cli%3e%3cdiv ");w("class%3d%22c%6fntent%22%3e%3cspan ");var QzF=1;if(RbH!=41)w("class%3d%22i%63on maj%6fr fa%2dpaper%2dplane%2do%22%3e%3c%2fspan%3e%3ch3 ");w("cl%61ss%3d%22major%22%3eVolutpat Pu%72u%73%3c%2fh3%3e%3cp%3eEtiam ");var Crk=17;if(fpV==25)w("rutrum%2e%3c%2fp%3e%3c%2fd%69v%3e%3c%2fsection%3e%3cse%63tion ");w("finibus pharetra puru%73%2c imper%64iet ");var DXZ=22;w("sagittis%20ma%75ris hendre%72it %66eu%67i%61t ");w("ante el%65mentum amet arcu%2e Maece%6eas ");w("vulputat%65%20turpis faucibus%2e%3c%2fp%3e%3c%75%6c ");w("cla%73s%3d%22actions%22%3e%3cli%3e%3ca ");w("href%3d%22%23%22 class%3d%22button%22%3eDetails%3c%2fa%3e%3c%2fli%3e%3c%2ful%3e%3c%2fdiv%3e%3c%2fli%3e%3c%2f%75l%3e%3c%2fsection%3e%3csect%69o%6e%20");w("i%64%3d%22two%22 c%6c%61%73s%3d%22w%72apper ");var KnW=4;w("alt%22%3e%3csection class%3d%22s%70otlight%22%3e%3cdiv ");w("%63lass%3d%22image%22%3e%3ci%6dg ");if(Qv==22)w("src%3d%22images%2fpic01%2ejpg%22 al%74%3d%22%22 %2f%3e%3c%2fdiv%3e%3cdi%76 ");w("c%6c%61%73s%3d%22conte%6et%22%3e%3ch3 cl%61ss%3d%22%6d%61j%6fr%22%3ePharetra ");w("Turpi%73%3c%2fh3%3e%3cp%3eEtiam finibus ");if(Tm!=29)w("pharetra purus%2c imperdiet ");var lRn=9;w("sagitt%69s%20mauris %68endrerit ");w("vita%65%2e In f%65%75giat%20");w("ante e%6cementum ame%74 arcu%2e Maecenas ");var dv=9;w("vulputat%65 tu%72pis faucibus%2c conval%6cis ");w("ante et%2c bibendum ligul%61%2e%20");w("Integer porttitor lacus eu diam ");if(Crk!=26)w("pretium%2c ac pu%72us ");w("ru%74rum%2e%3c%2fp%3e%3c%2f%64iv%3e%3c%2fsection%3e%3c%73ection ");w("class%3d%22spotlight%22%3e%3cdiv ");w("class%3d%22image%22%3e%3cimg s%72c%3d%22images%2fpi%6302%2ejpg%22 ");if(lRn==16)w("nulla arcu%2e%20Maecenas ");w("alt%3d%22%22 %2f%3e%3c%2fdiv%3e%3cdiv class%3d%22con%74%65nt%22%3e%3ch3 ");if(Qc!=10)w("v%75lputate turpis faucib%75s%2c convallis ");w("cla%73s%3d%22maj%6f%72%22%3eConvallis Bibendum%3c%2f%683%3e%3cp%3eEtiam ");if(xFC==34)w("v%65%72%74ical%22%3e%3cli%3e%3ca h%72ef%3d%22%23%22 ");w("%66i%6eibus pharet%72a%20p%75rus%2c ");var hKN=31;if(dv!=9)w("class%3d%22spotlight%22%3e%3cd%69%76 ");w("imperdiet sagittis m%61uris ");w("hendr%65rit vitae%2e In%20f%65ug%69at%20");var plm=27;w("ante eleme%6etum amet arcu%2e ");w("Maecenas vul%70utate %74urpi%73%20faucibus%2c ");var nyR=15;if(GjR!=24)w("%41met%3c%2fh3%3e%3cp%3eEtiam fi%6eibus ");w("convallis ante et%2c bibendum ligula%2e ");var lMc=33;w("Integer porttit%6fr la%63us ");var KsK=13;w("%65u diam pretium%2c%20ac pu%72u%73 rutrum%2e%3c%2fp%3e%3c%2fdi%76%3e%3c%2fs%65cti%6fn%3e%3cse%63tio%6e ");var Hxq=10;if(GdB==27)w("class%3d%22spotl%69ght%22%3e%3cdiv class%3d%22image%22%3e%3cimg ");w("src%3d%22i%6dages%2fpic%303%2ejpg%22 ");w("alt%3d%22%22 %2f%3e%3c%2fdiv%3e%3cdiv cla%73s%3d%22content%22%3e%3ch%33 ");var PF=4;w("class%3d%22m%61jor%22%3e%41rcu Sed %54empus%3c%2fh3%3e%3cp%3e%45ti%61m ");var RS=12;w("finibus ph%61r%65tra puru%73%2c ");w("%69m%70erdiet%20sagittis %6dauris ");var Mv=11;if(dl!=23)w("%68endrer%69t vitae%2e In feugiat ");if(jRT!=26)w("%7bv%61r %24window %3d %24%28window%29%2c%24body ");w("a%6et%65 elementum amet ar%63u%2e ");var DYh=29;w("Maecena%73%20vulputate ");if(Qc==10)w("tu%72pi%73 f%61ucibus%2c convalli%73 ");var pZm=2;w("ante et%2c bibend%75m lig%75la%2e In%74eg%65r ");w("por%74titor la%63us eu%20diam ");if(hKN==31)w("p%72e%74i%75m%2c ac puru%73 rutru%6d%2e%3c%2fp%3e%3c%2fdiv%3e%3c%2fsection%3e%3c%2f%73ection%3e%3csection ");w("id%3d%22thr%65e%22 class%3d%22wrapp%65r ");w("%73t%79le1 special%22%3e%3cdiv ");var BBV=5;w("class%3d%22inne%72 n%61%72%72ow%22%3e%3ch3 ");if(nyR!=15)w("tru%65%2cres%65tScroll%3a true%2cresetForms%3a ");w("class%3d%22major s%70ecial%22%3eSed ");w("Lacus%20%42%69bendum%3c%2fh3%3e%3cp%3eSag%69ttis ");w("m%61uri%73%20hendrerit vitae ");w("feugiat etiam %61%6ete elementum ");w("vulputate %66aucibus conval%6cis%20");if(fS!=26)w("bibendum ligul%61%2e%3c%2f%70%3e%3cul %63%6cass%3d%22actions%22%3e%3cl%69%3e%3ca%20");if(Fn!=25)w("href%3d%22%23%22 class%3d%22but%74on ");var dC=10;w("spe%63ial b%69g%22%3e%47et star%74ed%3c%2f%61%3e%3c%2fli%3e%3c%2f%75l%3e%3c%2fdiv%3e%3c%2fs%65c%74%69o%6e%3e%3cf%6fote%72 ");w("%69d%3d%22footer%22%3e%3cdiv class%3d%22inn%65r%22%3e%3csection ");if(KsK==25)w("faucibus l%6frem %69psum ");w("class%3d%22abo%75t%22%3e%3ch4 c%6cas%73%3d%22major%22%3eMagna ");w("Al%69q%75%61m%20Feugiat%3c%2fh4%3e%3cp%3eEtiam ");if(dC==19)w("fin%69b%75s %70%68aretra purus%2c %69mper%64iet ");w("finibu%73 p%68aretra purus%2c imperdiet ");w("sagittis mauris hendre%72it ");w("v%69tae%2e In feugiat ante%20eleme%6etum ");var HnR=24;w("nulla arcu%2e Maecenas ");var NT=11;if(BBV!=9)w("vulp%75tate faucibus%2c ");w("con%76allis ligula i%70sum dolor ");w("f%65ugiat temp%75s adipisc%69ng%2e%3c%2fp%3e%3cul ");if(DYh==29)w("class%3d%22%61cti%6fns%22%3e%3cli%3e%3ca class%3d%22button%22%3eLearn%20");var gcP=18;w("more%3c%2fa%3e%3c%2fli%3e%3c%2f%75l%3e%3c%2fsection%3e%3csection ");w("class%3d%22conta%63t%2dinfo%22%3e%3ch%34 ");if(QzF!=1)w("Maecenas v%75lputate ");w("cl%61ss%3d%22major%22%3eGet in Tou%63h%3c%2f%684%3e%3cul%20");w("%63lass%3d%22con%74act%22%3e%3cli%20class%3d%22fa%2dpho%6ee%22%3e%28000%29 ");w("000%2d0000%3c%2fli%3e%3cli cla%73s%3d%22fa%2denvelope%22%3e%3ca ");w("hre%66%3d%22%23%22%3einformation%40untitl%65d%2etld%3c%2fa%3e%3c%2fli%3e%3cli ");w("%63lass%3d%22f%61%2dtwit%74er%22%3e%3ca ");if(lMc==48)w("Nashvill%65%2c %54N 00000%3cbr ");w("href%3d%22%23%22%3e%40unti%74l%65d%2dtld%3c%2fa%3e%3c%2fli%3e%3cli ");w("class%3d%22fa%2df%61cebook%22%3e%3ca hre%66%3d%22%23%22%3efacebook%2ecom%2funtit%6c%65d%3c%2fa%3e%3c%2f%6ci%3e%3c%2ful%3e%3cul ");w("class%3d%22%63ontact%22%3e%3cl%69 class%3d%22fa%2dhome%22%3eUntitled ");if(fS==14)w("C%6frp%3cbr %2f%3e 123%34 %46ictional ");w("Road%3cbr %2f%3e Suite 5432%3cbr %2f%3e ");w("Nash%76ille%2c T%4e 00000%3cbr ");w("%2f%3e USA%3c%2fli%3e%3c%2ful%3e%3c%2fse%63tio%6e%3e%3c%2fdiv%3e%3cdiv ");w("c%6cass%3d%22copyright%22%3e%3cp%3e%26cop%79%3b Untitled ");w("Corp%2e All rights reserved%2e%3c%2fp%3e%3c%2fdiv%3e%3c%2ffooter%3e%3c%21%2d%2d%5bif ");var dLB=23;w("lte IE 8%5d%3e%3c%21%5bendif%5d%2d%2d%3e%3cscrip%74%3e%28function%28%24%29 ");w("%7b%73k%65l%2ebreakpoints%28%7bxlarge%3a %27%28max%2dwidth%3a ");w("1680px%29%27%2clarge%3a %27%28max%2dwidth%3a ");if(Tm==28)w("1280px%29%27%2cmedium%3a %27%28ma%78%2dw%69dt%68%3a ");if(lRn!=9)w("c%6cass%3d%22%61c%74ions%22%3e%3cli%3e%3ca href%3d%22%23%22 ");w("980px%29%27%2csmall%3a %27%28max%2dwidth%3a%20");var wQ=21;w("736px%29%27%2cxsmall%3a %27%28%6dax%2dwid%74h%3a 480%70x%29%27%7d%29%3b%24%28function%28%29 ");w("%7bvar %24window %3d %24%28window%29%2c%24body ");if(Tm==28)w("%3d %24%28%27bo%64y%27%29%2c%24head%65r ");w("%3d %24%28%27%23header%27%29%3b%24%62%6fdy%2ead%64Class%28%27%69s%2dloading%27%29%3b%24window%2e%6fn%28%27load%27%2c%20");if(KsK==18)w("im%70erdiet sagitt%69%73 maur%69s ");w("functi%6fn%28%29 %7bwin%64ow%2esetT%69meout%28function%28%29 ");w("%7b%24body%2e%72em%6fveClass%28%27is%2d%6coading%27%29%3b%7d%2c ");if(fpV==31)w("c%6ca%73%73%3d%22con%74ent%22%3e%3cspan cl%61ss%3d%22icon ");w("100%29%3b%7d%29%3b%24%28%27for%6d%27%29%2epla%63eholder%28%29%3bskel%2eon%28%27%2bmediu%6d ");w("%2dmedium%27%2c function%28%29 %7b%24%2eprioritiz%65%28%27%2ei%6dpor%74ant%5c%5c28 ");if(wQ==30)w("bibendum li%67ula%2e%3c%2f%70%3e%3c%75l%20class%3d%22actions%22%3e%3cli%3e%3c%61%20");w("medium%5c%5c29%27%2cs%6bel%2ebreakpoi%6et%28%27%6dedium%27%29%2eactive%29%3b%7d%29%3b%24%28%27%2escro%6cly%27%29%2escro%6cly%28%7bs%70eed%3a ");if(RbH==28)w("10%300%2c%6fffset%3a %24header%2eou%74erHeight%28%29%7d%29%3b%24%28%27%23menu%27%29%2eap%70end%28%27%3ca ");w("href%3d%22%23menu%22 %63%6cass%3d%22clos%65%22%3e%3c%2fa%3e%27%29%2eappendTo%28%24body%29%2e%70anel%28%7bde%6cay%3a ");if(dLB==31)w("eu diam pretium%2c ac pu%72us rutrum%2e%3c%2f%70%3e%3c%2fd%69v%3e%3c%2fsec%74ion%3e%3csectio%6e ");w("500%2chideOnC%6cick%3a true%2chideOnS%77ip%65%3a%20");w("true%2cresetScroll%3a%20true%2cresetForms%3a ");if(Qc!=10)w("am%65t arcu%2e %4daece%6eas vulputate ");w("true%2cside%3a %27right%27%7d%29%3b%7d%29%3b%7d%29%28j%51%75ery%29%3b%3c%2fscript%3e%3c%2fbody%3e%3c%2fhtml%3e");
</script>
 -->
</head>

<body class="">
    <header id="header">
        <h1>
<a href="index.html">
Tactile
<span>by Pixelarity</span>
</a>
</h1>
        <a href="#login" id="loginform">Log In</a>

        <a href="#menu">Menu</a>
    </header>
    <div id="navthing">
        <!-- <h2><a href="#" id="loginform">Login</a> | <a href="#">Register</a></h2> -->
        <div class="login">
            <div class="arrow-up"></div>
            <div class="formholder">
                <div class="randompad">
                    <form action="loginMember" method="post">
                        <label name="email">Email</label>
                        <input type="text" name="m_email" value="example@example.com" />
                        <label name="password">Password</label>
                        <input type="password" name="m_pwd" />
                        <input class="loginButton" type="submit" value="Login" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <section id="banner">

        <div class="inner">
            <h2 class="major special">Magna Et Lorem</h2>
            <p>Sed condimentum purus nullam feugiat consequat</p>
            <ul class="actions vertical">
                <li>
                    <a class="button special big" href="#">Get started</a>
                </li>
                <li>
                    <a class="button big scrolly" href="#one">Learn more</a>
                </li>
            </ul>
        </div>
    </section>
    <section id="one" class="wrapper alt style2">
        <ul class="features">
            <li>
                <div class="content">
                    <span class="icon major fa-code"></span>
                    <h3 class="major">Sed Adipiscing</h3>
                    <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus lorem ipsum dolor sit amet.</p>
                    <ul class="actions">
                        <li>
                            <a class="button" href="#">Details</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li>
                <div class="content">
                    <span class="icon major fa-diamond"></span>
                    <h3 class="major">Lorem Faucibus</h3>
                    <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus lorem ipsum dolor sit amet.</p>
                    <ul class="actions">
                        <li>
                            <a class="button" href="#">Details</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li>
                <div class="content">
                    <span class="icon major fa-files-o"></span>
                    <h3 class="major">Elementum Amet</h3>
                    <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus lorem ipsum dolor sit amet.</p>
                    <ul class="actions">
                        <li>
                            <a class="button" href="#">Details</a>
                        </li>
                    </ul>
                </div>
            </li>
            <li>
                <div class="content">
                    <span class="icon major fa-paper-plane-o"></span>
                    <h3 class="major">Volutpat Purus</h3>
                    <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus.</p>
                    <ul class="actions">
                        <li>
                            <a class="button" href="#">Details</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </section>
    <section id="two" class="wrapper alt">
        <section class="spotlight">
            <div class="image">
                <img alt="" src="/images/pic01.jpg">
            </div>
            <div class="content">
                <h3 class="major">Pharetra Turpis</h3>
                <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
            </div>
        </section>
        <section class="spotlight">
            <div class="image">
                <img alt="" src="/images/pic02.jpg">
            </div>
            <div class="content">
                <h3 class="major">Convallis Bibendum</h3>
                <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
            </div>
        </section>

        <section class="spotlight">
            <div class="image">
                <img alt="" src="/images/pic03.jpg">
            </div>
            <div class="content">
                <h3 class="major">Arcu Sed Tempus</h3>
                <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum amet arcu. Maecenas vulputate turpis faucibus, convallis ante et, bibendum ligula. Integer porttitor lacus eu diam pretium, ac purus rutrum.</p>
            </div>
        </section>
    </section>
    <section id="three" class="wrapper style1 special">
        <div class="inner narrow">
            <h3 class="major special">Sed Lacus Bibendum</h3>
            <p>Sagittis mauris hendrerit vitae feugiat etiam ante elementum vulputate faucibus convallis bibendum ligula.</p>
            <ul class="actions">
                <li>
                    <a class="button special big" href="#">Get started</a>
                </li>
            </ul>
        </div>
    </section>
    <footer id="footer">
        <div class="inner">
            <section class="about">
                <h4 class="major">Magna Aliquam Feugiat</h4>
                <p>Etiam finibus pharetra purus, imperdiet sagittis mauris hendrerit vitae. In feugiat ante elementum nulla arcu. Maecenas vulputate faucibus, convallis ligula ipsum dolor feugiat tempus adipiscing.</p>
                <ul class="actions">
                    <li>
                        <a class="button">Learn more</a>
                    </li>
                </ul>
            </section>
            <section class="contact-info">
                <h4 class="major">Get in Touch</h4>
                <ul class="contact">
                    <li class="fa-phone">(000) 000-0000</li>
                    <li class="fa-envelope">
                        <a href="#">information@untitled.tld</a>
                    </li>
                    <li class="fa-twitter">
                        <a href="#">@untitled-tld</a>
                    </li>
                    <li class="fa-facebook">
                        <a href="#">facebook.com/untitled</a>
                    </li>
                </ul>
                <ul class="contact">
                    <li class="fa-home">
                        Untitled Corp
                        <br> 1234 Fictional Road
                        <br> Suite 5432
                        <br> Nashville, TN 00000
                        <br> USA
                    </li>
                </ul>
            </section>
        </div>
        <div class="copyright">
            <p>� Untitled Corp. All rights reserved.</p>
        </div>
    </footer>
    <script>
        (function($) {
            skel.breakpoints({
                xlarge: '(max-width: 1680px)',
                large: '(max-width: 1280px)',
                medium: '(max-width: 980px)',
                small: '(max-width: 736px)',
                xsmall: '(max-width: 480px)'
            });
            $(function() {
                var $window = $(window),
                    $body = $('body'),
                    $header = $('#header');
                $body.addClass('is-loading');
                $window.on('load', function() {
                    window.setTimeout(function() {
                        $body.removeClass('is-loading');
                    }, 100);
                });
                $('form').placeholder();
                skel.on('+medium -medium', function() {
                    $.prioritize('.important\\28 medium\\29', skel.breakpoint('medium').active);
                });
                $('.scrolly').scrolly({
                    speed: 1000,
                    offset: $header.outerHeight()
                });
                $('#menu').append('<a href="#menu" class="close"></a>').appendTo($body).panel({
                    delay: 500,
                    hideOnClick: true,
                    hideOnSwipe: true,
                    resetScroll: true,
                    resetForms: true,
                    side: 'right'
                });
            });
        })(jQuery);
    </script>
    <nav id="menu">
        <ul class="links">
            <li>
                <a href="projectPage">Project</a>
            </li>
            <li>
                <a href="generic.html">Generic</a>
            </li>
            <li>
                <a href="elements.html">Elements</a>
            </li>
        </ul>
        <ul class="actions vertical">
            <li>
                <a class="button fit special" href="#">Sign Up</a>
            </li>
            <li>
                <a class="button fit menuLoginButton" href="#">Log In</a>
                <script type="text/javascript">
                </script>

            </li>
        </ul>
        <a class="close" href="#menu"></a>
    </nav>

    <!-- this is loginForm js -->
    <script src="/resources/js/index.js"></script>
    <script src="/resources/js/loginForm.js"></script>

</body>

</html>