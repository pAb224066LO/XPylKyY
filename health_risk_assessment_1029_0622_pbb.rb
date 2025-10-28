# 代码生成时间: 2025-10-29 06:22:29
# 健康风险评估服务
class HealthRiskAssessment < Sinatra::Base
  # 路由：GET /evaluate-risk
  get '/evaluate-risk' do
    # 获取查询参数
    age = params['age']
    weight = params['weight']
    height = params['height']
    gender = params['gender']

    # 校验参数
    if age.nil? || weight.nil? || height.nil? || gender.nil?
      status 400
      return { error: 'Missing parameters' }.to_json
    end

    # 尝试将参数转换为整数
    begin
      age = Integer(age)
      weight = Integer(weight)
      height = Integer(height)
    rescue ArgumentError
      status 400
      return { error: 'Invalid parameters' }.to_json
    end

    # 计算BMI
    bmi = (weight.to_f / (height / 100) ** 2).round(2)

    # 根据BMI和年龄评估健康风险
    risk_level = assess_risk(age, bmi, gender)

    # 返回评估结果
    {
      age: age,
      weight: weight,
      height: height,
      bmi: bmi,
      risk_level: risk_level
    }.to_json
  end

  private

  # 评估健康风险
  def assess_risk(age, bmi, gender)
    # 根据年龄、BMI和性别确定风险级别
    # 这里只是一个示例，实际应用中需要更复杂的逻辑和数据支持
    if gender == 'male'
      if age >= 18 && age < 45 && bmi >= 18.5 && bmi < 24.9
        'low'
      else
        'high'
      end
    elsif gender == 'female'
      if age >= 18 && age < 45 && bmi >= 18.5 && bmi < 24.9
        'low'
      else
        'high'
      end
    else
      'unknown'
    end
  end
end

# 运行Sinatra服务
run! if app_file == $0