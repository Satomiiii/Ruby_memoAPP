require 'csv'

def create_new_file
  puts "新しいメモを入力してください（終了するにはCtrl+Dを押してください）："
  memo = []

  begin
    while line = gets
      memo << line.chomp
    end
  rescue EOFError
    puts "\n入力を終了します。"
  end

  # メモが存在する場合のみ保存
  if memo.any?
    CSV.open("memo.csv", "w") do |csv|
      memo.each { |line| csv << [line] }
    end
    puts "新しいメモをmemo.csvに保存しました。"
  else
    puts "メモが保存されませんでした。"
  end
end


def edit_existing_file
  if !File.exist?("memo.csv")
    puts "memo.csvが存在しません。まずは新規作成してください。"
    return
  end

  loop do
    puts "\n現在のメモの内容："
    memo = CSV.read("memo.csv")
    memo.each_with_index { |line, index| puts "#{index + 1}: #{line[0]}" }

    puts "\n編集する行番号を入力してください（終了するには0を入力）："
    input = gets.chomp
    line_number = input.to_i

    if line_number == 0
      puts "編集を終了します。"
      break
    elsif line_number < 0 || line_number > memo.length
      puts "無効な行番号です。再度入力してください。"
      next
    end

    puts "新しい内容を入力してください："
    new_content = gets.chomp

    memo[line_number - 1] = [new_content]

    CSV.open("memo.csv", "w") do |csv|
      memo.each { |line| csv << line }
    end

    puts "メモを更新しました。"
  end
end

def main
  loop do
    puts "\n操作を選んでください："
    puts "1: 新規ファイルの作成"
    puts "2: 既存ファイルの編集"
    puts "3: アプリを終了する"
    print "選択: "
    choice = gets.chomp

    case choice
    when "1"
      create_new_file
    when "2"
      edit_existing_file
    when "3"
      puts "アプリを終了します。"
      break
    else
      puts "不正な値です。1、2、または3を入力してください。"
    end
  end
end

main
