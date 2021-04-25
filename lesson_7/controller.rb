class Controller

  def initialize
    @all_stations = []
    @trains = []
    @routes = []
    @vagons = []
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
    puts 'Нажмите 10, чтобы занять объем в вагоне или место.' 
  end
  def run 
    loop do 
      print 'Ваше действие:'
      choice = gets.chomp.downcase    
    
      case choice 
      when '1'
        begin
          puts 'Введите название станции(по английски):'
          station_title = gets.chomp
          station = Station.new(station_title)
          @all_stations << station
        rescue => e
          puts e.message
          retry
        end 
        puts "Cтанция #{station_title} успешна создана."

      when '2'
        begin
          puts 'Придумайте номер поезда:'  
          train_number = gets.chomp.downcase

          puts 'Какой тип поезда? ("cargo" или "passanger")'
          train_type = gets.chomp.downcase
          
          if train_type == "cargo"
            train_cargo = CargoTrain.new(train_number)
            @trains << train_cargo
          elsif train_type == "passanger"  
            train_passanger = PassangerTrain.new(train_number)
            @trains << train_passanger
          else
            raise "Неверный тип поезда" if train_type != "cargo" || train_type != "passanger"
          end  

        rescue => e
          puts e.message
          retry
        end    
        puts "Поезд #{train_number} успешно создан."
      
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
          puts 'Укажите общий объем грузового вагона:'
          total_volume = gets.to_i
          cargo_vagon = CargoVagon.new(total_volume)
          user_train.hook_vagon(cargo_vagon)
          @vagons << cargo_vagon
        elsif user_train.is_a?(PassangerTrain)
          puts 'Укажите общее колличество мест в пассажирском вагоне:'
          places = gets.to_i
          passanger_vagon = PassangerVagon.new(places)
          user_train.hook_vagon(passanger_vagon)
          @vagons << passanger_vagon
        else
          puts 'Поезду не прицепить вагон, так как не совпадает тип поезда и вагона.'  
        end  

      when '7'
        if @trains.empty?
          puts 'Еще не создан ни один поезд!'
        else 
          puts 'Список поездов с вагонами:'
          @trains.each.with_index do |train, index|      
          puts "#{index} - поезд #{train.number} тип #{train.type} вагоны #{train.vagons}"
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
          station.train_bypass do |train| 
            puts "-поезд: #{train.number}, тип: #{train.type}, вагонов: #{train.vagons.size}"
            train.vagon_bypass do |vagon| 
              if vagon.type == "passanger"
                puts "-номер: #{vagon.number}, тип: #{vagon.type}"
                puts " кол-во совободных мест #{vagon.count_empty_seats}"
                puts " кол-во занятых мест #{vagon.occupied_places}"
              elsif vagon.type == "cargo"
                puts "-номер: #{vagon.number}, тип: #{vagon.type}"
                puts " общий объем грузового вагона #{vagon.total_volume}"
                puts " занятый объем #{vagon.occupies_volume}"
              else
                puts "Error!"  
              end
            end
          end
        end
      
      when '10'
        begin 
          if @vagons.empty? 
            puts 'Еще не создан ни один вагон!'
          else  
            puts 'Список вагонов:'
            self.show_vagons

            puts 'Выберите вагон которому займем место или объем:'
            index_vagon = gets.to_i
            user_vagon = @vagons[index_vagon] 

            if user_vagon.type == "cargo"
              puts 'Какой объем займем ?'
              volume = gets.to_i
              if user_vagon.occupies_volume + volume > user_vagon.total_volume
                raise
              end
              user_vagon.take_volume(volume)
            elsif user_vagon.type == "passanger"
              if user_vagon.occupied_places >= user_vagon.places
                raise
              end 
              user_vagon.take_the_place
              puts "В вагоне заняли одно место, осталось #{user_vagon.count_empty_seats}."
            else
              puts "Введите корректный номер вагона."
            end   
          end
        rescue => e
          puts 'В вагоне нет места или свободного объема, повторите ввод.'
          retry  
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
      puts "#{index} - поезд #{train.number} тип #{train.type}"
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

  def show_vagons
    @vagons.each.with_index do |vagon, index|
      if vagon.type == "cargo"
        puts "#{index} - номер: #{vagon.number}, тип: #{vagon.type}"
        puts " общий объем грузового вагона #{vagon.total_volume}"
        puts " занятый объем #{vagon.occupies_volume}"
      elsif vagon.type == "passanger"
        puts "#{index} - номер: #{vagon.number}, тип: #{vagon.type}"
        puts " кол-во совободных мест #{vagon.count_empty_seats}"
        puts " кол-во занятых мест #{vagon.occupied_places}"
      end
    end    
  end
end
