
module Frustrationme
  module Mysql

    def query(sql)
      p sql
      my = Mysql2::Client.new(
        host: "localhost",
        username: "root",
        password: '',
        database: 'frustration_old'
      )
      my.query("set character set utf8")
      res = my.query(sql)
      my.close
      res
    end

  end
end