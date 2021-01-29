class Memo
  JSON_FILE_PATH = 'data.json'

<<<<<<< HEAD
require 'json'
require 'securerandom'
require 'pg'

class Memo
  JSON_FILE_PATH = 'data.json'
  CONNECTION = PG::Connection.new(dbname: 'memo')

  attr_reader :id, :title, :content

  def initialize(id: '000', title: 'notitle', content: 'no-content')
    @id = id
    @title = title
    @content = content
  end

  def self.find(id)
    memos = []
    memo_tables = CONNECTION.exec("SELECT * FROM memo_table WHERE id= '#{id}';")
    memo_tables.each do |memo|
      memos << memo
    end
    memos[0]
    Memo.new(id: memos[0]['id'], title: memos[0]['title'], content: memos[0]['content'])
  end

  def self.all
    memos = []
    memo_tables = CONNECTION.exec('SELECT * FROM memo_table;')
    memo_tables.each do |memo|
      memos << Memo.new(id: memo['id'], title: memo['title'], content: memo['content'])
    end
    memos
  end

  def self.create(title: '', content: '')
    id = SecureRandom.uuid
    CONNECTION.exec("INSERT INTO memo_table VALUES('#{id}', '#{title}', '#{content}')")
  end

  def self.update(id, title: '', content: '')
    query = "UPDATE memo_table 
    SET title = '#{title}',
    content = '#{content}'
    WHERE id = '#{id}'"
    CONNECTION.exec(query)
  end

  def self.delete(id)
    CONNECTION.exec("DELETE FROM memo_table WHERE id = '#{id}'")
=======
  attr_reader :id, :title, :content

  def initialize(id: '000', title: 'notitle', content: 'no-content')
    @id = id
    @title = title
    @content = content
  end

  def self.find(id)
    memos = []
    load_json['memos'].each do |memo|
      memos << memo if memo['id'] == id
    end
    memos[0]
    Memo.new(id: memos[0]['id'], title: memos[0]['title'], content: memos[0]['content'])
  end

  def self.all
    memos = []
    load_json['memos'].each do |memo|
      memos << Memo.new(id: memo['id'], title: memo['title'], content: memo['content'])
    end
    memos
  end

  def self.create(title: '', content: '')
    id = SecureRandom.uuid
    json_data = load_json
    json_data['memos'] << { 'id' => id, 'title' => title, 'content' => content }
    save_json(json_data)
  end

  def self.update(id, title: '', content: '')
    json_data = load_json
    json_data['memos'] = load_json['memos'].each do |memo|
      if memo['id'] == id
        memo['title'] = title
        memo['content'] = content
      end
    end
    save_json(json_data)
  end

  def self.delete(id)
    json_data = load_json
    json_data['memos'].delete_if do |memo_hash|
      memo_hash['id'] == id
    end
    save_json(json_data)
  end

  def self.load_json
    File.open(JSON_FILE_PATH) do |f|
      JSON.parse(f.read)
    end
  end

  def self.save_json(json_data)
    File.open(JSON_FILE_PATH, 'w') do |io|
      JSON.dump(json_data, io)
    end
>>>>>>> 162e699... memoをクラス化した
  end
end
