class ApplicationService
  Result = Struct.new(:success?, :value, :error)

  def self.call(**args)
    new(**args).call
  end

  def call
    call_handler
  end

  private

  def success(value = nil)
    Result.new(true, value, nil)
  end

  def failure(error_message)
    Result.new(false, nil, error_message)
  end
end
