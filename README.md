# lua-resty-orderedtable
lua-resty-orderedtable - an ordered table with sorted index

Table of Contents
=================

* [Name](#name)
* [Synopsis](#synopsis)
* [Methods](#methods)
    * [new](#new)
    * [add](#add)
    * [pairs](#pairs)
    * [next](#next)
    * [slice](#slice)
    * [count](#count)
* [Installation](#installation)
* [Authors](#authors)
* [Copyright and License](#copyright-and-license)

Synopsis
========
```lua
    lua_package_path "/path/to/lua-resty-orderedtable/lib/?.lua;;";

    server {
        location /test {
            content_by_lua '
            local ot = require('orderedtable')
            local ort = ot:new(true)

            -- add one key-value pair
            ort:add('d', 10)
            ort:add('b', 12)
            ort:add('c', 8)
            ort:add('e', 1222)

            -- iterate ordered table
            for i, key, value in ort:pairs() do
                print(i, key, value)
            end

            -- next ordered table
            local i, key, value = ort:next(2)
            print(i, key, value)

            -- slice subtable from ordered table
            local subTbl = ort:slice(1, 3)
            for i, key, value in subTbl:pairs() do
                print(i, key, value)
            end

            -- count ordered table
            print(ort:count())
            ';
        }
    }
```

Methods
=======

[Back to TOC](#table-of-contents)

new
---
`syntax: ort = orderedtable()`

Create a new ordered table object.

[Back to TOC](#table-of-contents)

add
---
`syntax: ort:add(key, value)`

Add a key-value pair into inner sorted table

[Back to TOC](#table-of-contents)

pairs
---
`syntax: for i, key, value in ort:pairs()`

Iterate inner sorted table

[Back to TOC](#table-of-contents)

next
---
`syntax: local i, key, value = ort:next(index)`

Fetch the specified index element from inner sorted table

[Back to TOC](#table-of-contents)

slice
---
`syntax: local subTbl = ort:slice(first, last, step)`

Fetch sub sorted table from inner sorted table

[Back to TOC](#table-of-contents)

count
---
`syntax: local counter = ort:count()`

Get amount of inner sorted table elements

[Back to TOC](#table-of-contents)

Installation
============

You can install it with [opm](https://github.com/openresty/opm#readme).
Just like that: opm install kwanhur/lua-resty-orderedtable

[Back to TOC](#table-of-contents)

Authors
=======

kwanhur <huang_hua2012@163.com>, VIPS Inc.

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the Apache License Version 2.0 .

Copyright (C) 2016, by kwanhur <huang_hua2012@163.com>, VIPS Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)
