
class Pokemon

    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        self.name = name
        self.type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?;
        SQL

        row = db.execute(sql, id).first
        new_pokemon = self.new(id: id, name: row[1], type: row[2], db: db)
    end
end

