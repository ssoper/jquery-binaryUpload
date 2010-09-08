require 'rubygems'
require 'sinatra'
require 'fileutils'
require 'json'

mime_type :json, 'application/json'
set :public, Proc.new { root }
set :views, Proc.new { root }

get '/' do
  erb :index
end

post '/upload' do
  content_type :json
  file, name = params[:uploaded_file].slice(*[:tempfile, :filename]).values
  FileUtils.cp(file.path, "#{uploaded_files_path}/#{name}")
  { :success => true }.to_json
end

get '/uploads' do
  content_type :json
  files = Dir.glob("#{uploaded_files_path}/*").collect do |path|
    { :size => kilo(File.size(path)), :name => path.split('/').last }
  end
  files.to_json
end

def kilo(n)
  count = 0
  while n >= 1024 and count < 4
    n /= 1024.0
    count += 1
  end
  format("%.2f",n) + %w(B KB MB GB TB)[count]
end

def uploaded_files_path
  path = File.join(File.dirname(__FILE__), 'uploaded_files')
  FileUtils.mkdir(path) unless File.exist?(path)
  path
end

class Hash
  def slice(*keys)
    keys = keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
    hash = self.class.new
    keys.each { |k| hash[k] = self[k] if has_key?(k) }
    hash
  end
end
