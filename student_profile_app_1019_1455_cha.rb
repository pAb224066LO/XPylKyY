# 代码生成时间: 2025-10-19 14:55:05
# 学生画像系统应用
class StudentProfileApp < Sinatra::Application

  # 学生信息的哈希表
  set :students, {}

  # 路由：获取所有学生信息
  get '/students' do
    content_type :json
    settings.students.to_json
  end

  # 路由：添加新学生信息
  post '/students' do
    content_type :json
    student_data = JSON.parse(request.body.read)
    student_id = student_data['id']
    student_name = student_data['name']
    student_age = student_data['age']

    # 错误处理：检查学生ID是否已存在
    if settings.students.has_key?(student_id)
      status 409
      return {
        'error' => "Student with ID #{student_id} already exists."
      }.to_json
    end

    # 添加学生信息到哈希表
    settings.students[student_id] = {
      'name' => student_name,
      'age' => student_age
    }

    {
      'message' => "Student with ID #{student_id} added successfully."
    }.to_json
  end

  # 路由：更新学生信息
  put '/students/:id' do
    content_type :json
    student_data = JSON.parse(request.body.read)
    student_id = params['id']
    student_name = student_data['name']
    student_age = student_data['age']

    # 错误处理：检查学生ID是否存在
    unless settings.students.has_key?(student_id)
      status 404
      return {
        'error' => 