MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'fikus_development'
  when :production  then MongoMapper.database = 'fikus_production'
  when :test        then MongoMapper.database = 'fikus_test'
end
