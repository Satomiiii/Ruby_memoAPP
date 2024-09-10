require 'csv'

def create_new_file
  puts "新しいメモを入力してください（終了するには空行を入力）："
  memo = []
  while true
    line = gets.chomp
    break if line.empty?
    memo << line
  end

  CSV.open("memo.csv", "w") do |csv|
    memo.each { |line| csv << [line] }
  end

  puts "新しいメモをmemo.csvに保存しました。"
end

def edit_existing_file
  if !File.exist?("memo.csv")
    puts "memo.csvが存在しません。まずは新規作成してください。"
    return
  end

  puts "現在のメモの内容："
  memo = CSV.read("memo.csv")
  memo.each_with_index { |line, index| puts "#{index + 1}: #{line[0]}" }

  puts "編集する行番号を入力してください（追加する場合は新しい行番号を入力）："
  line_number = gets.to_i

  puts "新しい内容を入力してください："
  new_content = gets.chomp

  if line_number > memo.length
    memo << [new_content]
  else
    memo[line_number - 1] = [new_content]
  end

  CSV.open("memo.csv", "w") do |csv|
    memo.each { |line| csv << line }
  end

  puts "メモを更新しました。"
end

def main
  loop do
    puts "操作を選んでください："
    puts "1: 新規ファイルの作成"
    puts "2: 既存ファイルの編集"
    choice = gets.chomp

    case choice
    when "1"
      create_new_file
    when "2"
      edit_existing_file
    else
      puts "不正な値です。1か2を入力してください。"
    end
  end
end

main


