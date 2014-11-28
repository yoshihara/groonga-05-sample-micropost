# groonga_05_sample_micropost

[全文検索エンジンGroongaを囲む夕べ5](http://groonga.doorkeeper.jp/events/15816) の発表にあったサンプルアプリです。

## Dependencies

- ruby > 2.1.3
- rails
- PostgreSQL

## How to run

First, you get this repository with `git clone`.

```
$ cd groonga-sample-micropost
$ bundle update
$ bundle exec rake db:create db:migrate
$ bundle exec rails s
```

and you open `http://localhost:3000`.
