module ContainerHelper
  def no_container?(value)
    return true if value == 'true'
    puts 'show container'
    false
  end
end
