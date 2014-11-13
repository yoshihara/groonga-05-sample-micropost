base_db_path = Rails.root.join(Settings.groonga.database)
db_path = File.join(base_db_path.dirname, base_db_path.basename)

FileUtils.mkdir_p(File.dirname(db_path))

Groonga::Context.default_options = {encoding: :utf8}

if File.exists?(db_path)
  Groonga::Database.open(db_path)
else
  Groonga::Database.create(path: db_path)
  Groonga::Schema.create_table('Microposts', type: :hash) do |t|
    t.text "content"
  end
  Groonga::Schema.create_table('Terms', type: :patricia_trie, default_tokenizer: "TokenBigramSplitSymbolAlphaDigit", normalizer: :NormalizerAuto) do |t|
    t.index "Microposts.content"
  end
end
