module ContainerHelper
  def no_container?(value)
    return true if value == 'true'
    false
  end
end
