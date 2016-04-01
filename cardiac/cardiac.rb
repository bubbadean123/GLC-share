class Integer
  def digits
    Enumerator.new do |x|
      to_s.chars.map{|c| x << c.to_i }
    end
  end
end
in_cards=[]
out_cards=[]
mem=[001,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,000,800]
acc=0
pc=0
print ".cards file:"
infile=gets.chomp
unless infile.include? ".cards"
  infile=infile+".cards"
end
File.readlines(infile).each do |line|
in_cards.push(line.to_i)  
end
i=0
while true
  ins=mem[pc]
  pc=pc+1
  op=ins/100
  a=ins%100
  puts "Op:#{op}"
  puts "Addr:#{a}"
  case op
  when 0
    if in_cards.length==0
        puts "No more cards"
        puts "Cards:"
        puts out_cards
        break
    else
        card=in_cards.shift
        puts "Setting mem[#{a}] to card #{card}"
        mem[a]=card
      end
  when 1
    puts "Setting accumulator to mem[#{a}]"
    acc=mem[a]
  when 2
    puts "Setting accumulator to accumulator plus mem[#{a}]"
    acc=acc+mem[a]
  when 3
    if acc < 0
      "Accumulator negative, jumping to #{a}"
      pc = a
    end
  when 4
    l=a/10
    r=a%10
    puts "Shifting accumulator left #{l} digits and right #{r} digits"
    acc=accx10^l/10^r
  when 5
    puts "Outputting accumulator"
    out_cards.push(mem[a])
  when 6
    puts "Setting mem[#{a}] to accumulator"
    mem[a]=acc
   when 7
    puts "Setting accumulator to accumulator minus mem[#{a}]"
    acc=acc-mem[a]
   when 8
    puts "Storing program counter in location 99 and jumping to location #{a}"
    d=pc.digits.to_a
    mem[99]=d.unshift(8)
    pc=a
   when 9
    puts "Halted"
    pc=a
    puts "Cards:"
    puts out_cards
    break
   end
  puts "Remaining Cards:"
  puts in_cards
  puts "PC:#{pc}"
  puts "Accumulator:#{acc}"
end

memfile=File.open(infile.gsub(".cards",".mem"),"w")
outfile=File.open(infile.gsub(".cards",".out"),"w")
mem.each do |v| 
  memfile.puts v
end
out_cards.each do |v|
  outfile.puts v
end
memfile.rewind
memfile.close
outfile.rewind
outfile.close