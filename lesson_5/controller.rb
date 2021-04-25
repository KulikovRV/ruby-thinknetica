class Controller
  def initialize
    @all_stations = []
    @trains = []
    @routes = []
  end  

  def help
    puts 'Нажмите 1 для создания станции.'
    puts 'Нажмите 2 для создания поезда.'
    puts 'Нажмите 3 для создания маршрута.'
    puts 'Нажмите 4 для назначения промежуточной станции в маршруте.'
    puts 'Нажмите 5 для назначения маршрута поезду.'
    puts 'Нажмите 6 для добавления вагона к поезду.'
    puts 'Нажмите 7 для чтобы отцепить вагон.'
    puts 'Нажмите 8 для перемещения поезда по маршруту.'
    puts 'Нажмите 9 для просмотра списка станций и поездов на станции.'  
  end

  def run 
    loop do 
      print 'Ваше действие:'
      choice = gets.chomp.downcase    
    
      case choice 
      when '1'
        puts 'Введите название станции(по английски):'
        station_title = gets.chomp
        station = Station.new(station_title)
        @all_stations << station

      when '2'
        puts 'Название поезда:'  
        train_name = gets.chomp.downcase

        puts 'Какой тип поезда? ("cargo" или "passanger")'
        train_type = gets.chomp.downcase

        if train_type == "cargo"
          train_cargo = CargoTrain.new(train_name)
          @trains << train_cargo
        elsif train_type == "passanger"  
          train_passanger = PassangerTrain.new(train_name)
          @trains << train_passanger
        else
          puts 'Вы указали неверный тип поезда.'
        end  
      

      when '3'
        puts 'Список станций:'
        self.show_all_stations

        puts 'Введите номер начальной станции:'
        index_start_station = gets.to_i
        start_station = @all_stations[index_start_station]

        puts 'Введите номер конечной станции:'
        index_finish_station = gets.to_i
        finish_station = @all_stations[index_finish_station]

        route = Route.new(start_station, finish_station)
        @routes << route

      when '4'
        return puts 'Пока не существует созданных маршрутов!' if @routes.empty? 

        puts 'Список известных станций:'
        self.show_all_stations

        puts 'Введите номер промежуточной станции:'
        index_intermediate_station = gets.to_i
        intermediate_station = @all_stations[index_intermediate_station]

        puts 'Список маршрутов:'
        self.show_routes

        puts 'Выберите маршрут, которому добавим промежуточную станцию.'  
        index_route = gets.to_i
        user_route = @routes[index_route]
        user_route.add_intermediate_station(intermediate_station)

      when '5'
        if (@routes.empty? || @trains.empty?) 
          puts 'Создайте поезд и маршрут!'
        else  
          puts 'Список поездов:'
          self.show_list_train 

          puts 'Введите поезд, которому хотите присвоить маршрут:'
          index_train = gets.to_i
          user_train = @trains[index_train]

          puts 'Список маршрутов:'
          self.show_routes

          puts 'Выберите маршрут, который добавим поезду.'  
          index_route = gets.to_i
          user_route = @routes[index_route]
          user_train.take_route(user_route)
        end  

      when '6'  
        return puts 'Пока не существует созданных поездов!' if @trains.empty?

        puts 'Список поездов:'
        self.show_list_train                 

        puts 'Выберите поезд, которому хотите добавить вагон:'
        index_train = gets.to_i
        user_train = @trains[index_train]        

        if user_train.is_a?(CargoTrain)
          cargo_vagon = CargoVagon.new
          user_train.hook_vagon(cargo_vagon)
        elsif user_train.is_a?(PassangerTrain)
          passanger_vagon = PassangerVagon.new
          user_train.hook_vagon(passanger_vagon)
        else
          puts 'Поезду не прицепить вагон, так как не совпадает тип поезда и вагона.'  
        end  

      when '7'
        if @trains.empty?
          puts 'Еще не создан ни один поезд!'
        else 
          puts 'Список поездов с вагонами:'
          @trains.each.with_index do |train, index|      
          puts "#{index} - поезд #{train.name} тип #{train.type} вагоны #{train.vagons}"
          end  

          puts 'Выберите поезд, которому хотите отцепить вагон:'
          index_train = gets.to_i
          user_train = @trains[index_train]         
          user_train.unhook_vagon
        end   

      when '8'      
        if @trains.empty? 
          puts 'Еще не создан ни один поезд!'
        else  
          puts 'Поезд может ехать вперед или назад на одну станцию.'
          puts 'Список поездов:'
          self.show_list_train   

          puts 'Выберите поезд который будет ехать по маршруту:'
          index_train = gets.to_i
          user_train = @trains[index_train] 

          if user_train.route.nil? 
            puts 'У поезда нет маршрута!'
          else  
            puts "Введите 'next' и поезд отправится вперед."
            puts "Введите 'back' и поезд отправится назад." 
            puts "Введите 'showNext' и посмотрите следующую станцию."              
            puts "Введите 'showCurrent' и посмотрите текущую станцию."              
            puts "Введите 'showPrevious' и посмотрите прошлую станцию." 

            puts "Введите действие:"
            user_train_manipulation = gets.chomp.downcase
            
            case user_train_manipulation
            when 'next'
              user_train.go_next_station
            when 'back' 
              user_train.go_previous_station
            when 'shownext'
              puts user_train.show_next_station.title
            when 'showcurrent'
              puts user_train.show_current_station.title
            when 'showprevious'
              puts user_train.show_previous_station.title
            else
              puts "Ошибка ввода, нет такой команды #{user_train_manipulation}." 
            end
          end
        end    

      when '9'
        puts 'Списки станций и поездов на станциях :'
        @all_stations.each do |station|
          puts "\nСтанция #{station.title}"
          station.trains.each do |train|
            puts "-поезд: #{train.name}, вагонов: #{train.vagons.size}"
          end
        end

      when 'help'
        self.help 
 
      else
        puts 'Неправильная команда, используй help для помощи.'  
      end
    end  
  end

  protected

  def show_list_train  
    @trains.each.with_index do |train, index|          
      puts "#{index} - поезд #{train.name} тип #{train.type}"
    end  
  end

  def show_all_stations
    @all_stations.each.with_index do |station, index|
    puts "#{index} - #{station.title}"
    end      
  end

  def show_routes
    @routes.each.with_index do |route, index|  
      puts "#{index} - #{route.name}"
    end
  end
end
