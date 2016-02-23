class String
  def fix(size, padstr=' ')
    self[0...size].rjust(size, padstr)
  end
end
insset={"INP"=>0,"LOD"=>1,"ADD"=>2,"TAC"=>3,"SFT"=>4,"OUT"=>5,"STO"=>6,"SUB"=>7,"JMP"=>8,"HRS" =>9}
conv={}
dat=[]
labeltable={}
memcounter=3
puts ".asm file:"
infile = gets.chomp
infilef=File.open("#{infile}.asm","r")
outfilef=File.open("#{infile}.cards","w")
outfilef.puts "002"
outfilef.puts "800"
infilef.each_line do |line|
  line=line.split(" ")
  puts line.inspect
  if line[0] == "DAT"
    puts "Skipped DAT opcode"
    dat.push(line[1])
    next
  end
  if line[0] == "ORG"
    puts "Skipped ORG opcode"
    memcounter = line[1].to_i+3
    puts "memcounter=#{memcounter}"
    next
  end
  op=insset[line[0]].to_s
  if op == ""
    puts "Invalid opcode"
    next
  end
  arg=line[1]
  puts "Address and op pair written"
  outfilef.puts "%03d" % memcounter
  outfilef.puts op+arg
  memcounter=memcounter+1
end
outfilef.puts "002"
outfilef.puts "803"
dat.each do |val|
  puts "Data written"
  outfilef.puts val.fix(3,"0")
end