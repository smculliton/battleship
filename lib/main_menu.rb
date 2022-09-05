require 'time'

def main_menu
    puts `clear`
    puts "                             ( O===----- WELCOME TO -----===O )"
    puts'              ____   ___  _____  _____ ___    ____   ____   _   _   ____  _____'
    puts'         ---- | , | |   \|_   _||_   _|| |   |  _/  |  __| | |_| | |_  _| |  _ \ ----'
    puts'( ( O======== |   \ | |  \ | |    | |  | |   |  >    \ \   |  _  |   ||   |  __| ========O ) )'
    puts'         ---- | |  ||    | | |    | |  | |__ | |__  |\\\ \  | | | |  _||_  | |    ----'
    puts'              _____/|_|\_| |_|    |_|  |____\|____\ |____| |_| |_| |____||___|'
    puts'            ====================================================================='
    puts' '
    puts' '
    puts' '
    puts'= MENU ============================================================='
    puts'enter <p> to play'
    puts'enter <q> to quit'
    puts'enter <b> to change board size'
    puts '================================================='
    puts ' '
    puts ' '
end 

def countdown_hit
    puts`clear`
    3.times do 
        now = Time.now.sec
        loop do 
            if Time.now.sec == (now + 1)
                print '.'
                break
            end 
        end
    end 
    puts 'HIT!!'
end 

def print_different_things
    puts`clear`
    i = 0
    4.times do 
        now = Time.now.sec
        loop do 
            if Time.now.sec == (now + 1)
                puts '.........................' if i == 0
                puts '-------------------------' if i == 1
                puts '~~~~~~~~~~~~~~~~~~~~~~~~~' if i == 2 
                puts '=========================' if i == 3
                i += 1
                break
            end 
        end
    end 
end 

def main_menu_w_animation
    puts`clear`
    i = 0
    5.times do 
        now = Time.now.sec
        loop do 
            if Time.now.sec == (now + 1)
                if i == 0
                    puts "                             ( O===----- WELCOME TO -----===O )"
                    puts' '
                elsif i == 1
                    puts'              ____   ___  _____  _____ ___    ____   ____   _   _   ____  _____'
                    puts'         ---- | , | |   \|_   _||_   _|| |   |  _/  |  __| | |_| | |_  _| |  _ \ ----'
                elsif i == 2
                    puts'( ( O======== |   \ | |  \ | |    | |  | |   |  >    \ \   |  _  |   ||   |  __| ========O ) )'
                    puts'         ---- | |  ||    | | |    | |  | |__ | |__  |\\\ \  | | | |  _||_  | |    ----'
                elsif i == 3
                    puts'              _____/|_|\_| |_|    |_|  |____\|____\ |____| |_| |_| |____||___|'
                    puts'            ====================================================================='
                else 
                    puts' '
                    puts' '
                    puts' '
                    puts'= MENU ============================================================='
                    puts'enter <p> to play'
                    puts'enter <q> to quit'
                    puts'enter <b> to change board size'
                    puts '================================================='
                    puts ' '
                    puts ' '
                end
                i += 1
                break
            end 
        end
    end 
    command = ''
    until command == 'q' || command == 'p' do
        print '(?) - '
        command = gets.chomp
        return if command.downcase == 'q'
        return if command.downcase == 'p'
        puts ' '
        puts '-- invalid command --'
        puts ' '
    end
end 

def boat_explosion_animation
    puts `clear`
    i = 0
    5.times do 
        now = Time.now.sec
        h = 0
        loop do 
            h += 1
            break if h == 1000000000
            if Time.now.sec == (now + 1)
                puts "\n\n\n\n\n\n\n" +
                '                            __/___            
                      _____/______|           
              _______/_____\_______\_____     
              \              < < <       |    
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' if i == 0
                print '..' if i == 1
                print '..' if i == 2 
                print '..' if i == 3
                puts`clear` + '                       ____
                __,-~~/~    `---.
              _/_,---(      ,    )
          __ /        <    /   )  \___
- ------===;;;;====------------------===;;;===----- -  -
             \/  ~"~"~"~"~"~\~"~)~"/
             (_ (   \  (     >    \)
              \_( _ <         >_>`
                 ~ `-i` ::>|--"
                     I;|.|.|
                    <|i::|i|`.
                   (` ^`"`-` ")
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' if i == 4
                i += 1
                break
            end 
        end
    end 
end 
