# groonga-05-sample-micropost

[全文検索エンジンGroongaを囲む夕べ5](http://groonga.doorkeeper.jp/events/15816) の発表にあったサンプルアプリです。

## Dependencies

- ruby >= 2.1.3
- bunlder ( `gem install bunlder` )
- PostgreSQL

## How to run

```
$ git clone https://github.com/yoshihara/groonga-05-sample-micropost.git
$ cd groonga_05_sample_micropost
$ bundle install
$ bundle exec rake db:create db:migrate
$ bundle exec rails s
```

and you open `http://localhost:3000`.
