class Controller
  def run
    add_start_classes
    show_rules
    take_name_from_user
    loop do
      start_game
      show_result
      show_turn_options($user_name)
      save_user_turn_option
      run_turn_option
      compare_points
      show_bank_players
      check_bank_players

      if stop_game
        next
      else
        break
      end
    end
  end
  
  def add_start_classes
    $deck_of_cards = DeckOfCard.new($deck, $cost_of_cards)
    $dealer = Dealer.new
  end  
  
  def take_name_from_user
    print 'Введите ваше имя:'
    $user_name = gets.chomp
    $player = Player.new($user_name)
  end
  
  def start_game
    puts ''
    puts 'Раздаем карты...'
    $deck_of_cards.shuffle_cards

    2.times do
      $player.recive_card($deck_of_cards)
      $dealer.recive_card($deck_of_cards)
    end  
  end

  def show_result
    puts ''
    puts 'Ваши карты:'
    puts $player.cards_hand  
    puts ''
    puts 'Карты дилера:'
    2.times { puts '*' }
    puts ''
    puts 'Ваши очки:'
    $player.score_points($deck_of_cards)
    puts $player.calculate_score
  end
  
  def show_turn_options(user_name)
    puts ''
    puts "#{user_name} выберите действие:"
    puts '1 - Пропустить ход.'
    puts '2 - Взять карту.'
    puts '3 - Открыть карты.'
  end 

  def save_user_turn_option
    $user_option = gets.chomp
  end 

  def take_card(player)
    player.recive_card($deck_of_cards)
  end 

  def open_cards
    puts ''
    puts 'Вскрываем карты...'

    puts 'Ваши карты:'
    puts $player.cards_hand
    puts 'Ваши очки:'
    $player.score_points($deck_of_cards)
    puts $player.calculate_score

    puts ''
    puts 'Карты компьютера:'
    puts $dealer.cards_hand
    puts 'Очки компьютера:'
    $dealer.score_points($deck_of_cards)
    puts $dealer.calculate_score
  end 

  def run_turn_option
    case $user_option
    when '1'
      move_dealer
      open_cards
    when '2'
      take_card($player)
      move_dealer
      open_cards
    when '3'
      open_cards
    end
  end 

  def move_dealer
    puts 'Ход перешел компьютеру!'
    $dealer.score_points($deck_of_cards)
    $dealer.calculate_score
    take_card($dealer) if $dealer.total_points < 17 
  end

  def stop_game
    puts "Введите '1' для продолжения игры или любой знак для завершения партии."
    user_answer = gets.chomp
    if user_answer == '1'
      $player.discard_cards
      $dealer.discard_cards
      true
    else
      false
    end
  end
  
  def compare_points
    text_victory_user = 'Игрок победил!'
    text_victory_dealer = 'Компьютер одержал победу!'
    text_user_money = 'Игрок получил 10 баксов от компьютера!'
    text_dealer_money = 'Компьютер получил 10 баксов от игрока!'

    if $player.total_points > $dealer.total_points && $player.total_points <= 21
      puts text_victory_user
      puts text_user_money
      $player.take_money
      $dealer.give_money
    elsif $dealer.total_points > $player.total_points && $dealer.total_points <= 21
      puts text_victory_dealer
      puts text_dealer_money
      $dealer.take_money 
      $player.give_money
    elsif $player.total_points > 21 && $dealer.total_points <= 21
      puts text_victory_dealer
      puts text_dealer_money
      $dealer.take_money
      $player.give_money
    elsif $dealer.total_points > 21 && $player.total_points <= 21
      puts text_victory_user
      puts text_user_money
      $player.take_money
      $dealer.give_money
    else 
      puts 'Ничья!'
    end
  end

  def show_bank_players
    puts ''
    puts 'Банк игрока:'
    puts $player.bank
    puts 'Банк дилера:'
    puts $dealer.bank
  end

  def check_bank_players
    if $player.bank <= 0 || $dealer.bank <= 0
      puts 'Игра окончена.'
      puts 'Победил игрок!' if $dealer.bank <= 0
      puts 'Победил компьютер!' if $player.bank <= 0
      $player.refresh_money_bank
      $dealer.refresh_money_bank
    end
  end

  def show_rules
    puts "Карточная игра '21'"
    puts 'Правила:'
    puts 'Каждый ход, Вам и компьютеру(Дилер) будут раздавать по две случайные карты из колоды.'
    puts 'В зависимости от стоимости карты, вам подсчитают очки.'

    print "После подсчета очков Вы сможете пропустить ход,"
    puts " взять новую карту в свою 'руку' или открыть карты."

    puts 'За один ход можно взять одну карту.'
    puts 'Выигрывает игрок, у которого сумма очков ближе к 21.'
    puts 'Если у игрока сумма очков больше 21, то он проиграл.'
    puts 'Если сумма очков у игрока и дилера одинаковая, то объявляется ничья и деньги из банка возвращаются игрокам'
    puts 'Победителю раунда присуждается 10$, проигравшему -10$.'
    puts 'Все игроки начинают со 100$ в кармане.'
    puts 'В конце раунда игрок может закончить игру или её продолжить.'
    puts "Для полной победы в игре нужно оставить противника с 'дыркой' в кармане."
    puts 'Удачи игрок!'
  end 
end
