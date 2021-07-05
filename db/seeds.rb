users = []
10.times do |i|
  users << User.new(nickname: "dummy-#{i+1}", email: "test#{i+1}@test.com", password: '111111', character_name: 'たまご', level: 1, experience_point: 0 )
end
User.import users

levels = []
100.times do |l|
  level =+ l+1
  levels << LevelSetting.new(level: l+1, thresold: level**3)
end
LevelSetting.import levels

EvolutionSetting.create(id:1, level:5,  character_name:'ようちゅう')
EvolutionSetting.create(id:2, level:15, character_name:'サナギ')
EvolutionSetting.create(id:3, level:30, character_name:'カブトムシ')
EvolutionSetting.create(id:4, level:40, character_name:'エレファスゾウカブト')
EvolutionSetting.create(id:5, level:50, character_name:'アトラスオオカブト')
EvolutionSetting.create(id:6, level:60, character_name:'ネプチューンオオカブト')
EvolutionSetting.create(id:7, level:70, character_name:'コーカサスオオカブト')
EvolutionSetting.create(id:8, level:85, character_name:'ヘラクレスオオカブト')

Question.create(id: 1, genre_id:'2', question_name:'あわせていくつ？', question_content: '○○  ○○○ あわせていくつかな？',tip: 'まるをかぞえてみよう', model_answer: '5つ', point: '50', user_id: '5' )
Question.create(id: 2, genre_id:'2', question_name:'あわせていくつ？', question_content: '☆  ☆☆☆☆ あわせていくつかな？',tip: 'ほしをかぞえてみよう', model_answer: '5つ', point: '50', user_id: '5' )
Question.create(id: 3, genre_id:'2', question_name:'ぜんぶでなんほん?', question_content: 'しろいおはなが6ほん、あおいおはなが2ほん。ぜんぶでなんほん？',tip: '⑥と②を合わせると・・・', model_answer: '8ほん', point: '100', user_id: '5' )
Question.create(id: 4, genre_id:'2', question_name:'ぜんぶでなんひき？', question_content: 'くろいさかなが5ひき、あかいさかなが3ひき。ぜんぶでなんひき？',tip: 'しきになおすと5と３をたすから・・・', model_answer: '8ひき', point: '120', user_id: '5' )
Question.create(id: 5, genre_id:'2', question_name:'たしざん', question_content: '2+5',tip: 'チョキとパーだね', model_answer: '7', point: '70', user_id: '5' )
Question.create(id: 6, genre_id:'2', question_name:'たしざん', question_content: '4+2',tip: 'ヒントなし', model_answer: '6', point: '200', user_id: '5' )
Question.create(id: 7, genre_id:'2', question_name:'しきになおしてみよう', question_content: '○○○ + ○○○○',tip: 'それぞれなんこずつあるかな？', model_answer: '3+4', point: '130', user_id: '5' )
Question.create(id: 8, genre_id:'2', question_name:'しきになおしてみよう', question_content: 'ネコが5ひきいます。そこにほかのネコが3ひきやってきました。みんなでなんひきになるか、しきをかこう',tip: 'こたえじゃなくてしきをかくんだよ', model_answer: '5+3', point: '180', user_id: '5' )
Question.create(id: 9, genre_id:'2', question_name:'しきになおしてみよう', question_content: 'アヒルが2ひきいます。そこにほかのアヒルが4ひきやってきました。みんなでなんひきになるか、しきをかこう',tip: 'しきをかくんだよ', model_answer: '2+4', point: '180', user_id: '5' )
Question.create(id: 10, genre_id:'2', question_name:'たしざん', question_content: '2+1',tip: 'ヒントなし', model_answer: '3', point: '100', user_id: '5' )
Question.create(id: 11, genre_id:'2', question_name:'たしざん', question_content: '1+3',tip: 'ヒントなし', model_answer: '4', point: '100', user_id: '5' )
Question.create(id: 12, genre_id:'2', question_name:'たしざん', question_content: '2+3',tip: 'ヒントなし', model_answer: '5', point: '100', user_id: '5' )
Question.create(id: 13, genre_id:'2', question_name:'たしざん', question_content: '5+4',tip: 'ヒントなし', model_answer: '9', point: '100', user_id: '5' )
Question.create(id: 14, genre_id:'2', question_name:'たしざん', question_content: '3+5',tip: 'ヒントなし', model_answer: '8', point: '100', user_id: '5' )
Question.create(id: 15, genre_id:'2', question_name:'たしざん', question_content: '7+2',tip: 'ヒントなし', model_answer: '9', point: '100', user_id: '5' )
Question.create(id: 16, genre_id:'2', question_name:'たしざん', question_content: '3+3',tip: 'ヒントなし', model_answer: '6', point: '100', user_id: '5' )
Question.create(id: 17, genre_id:'2', question_name:'たしざん', question_content: '8+2',tip: 'ヒントなし', model_answer: '10', point: '200', user_id: '5' )
Question.create(id: 18, genre_id:'2', question_name:'たしざん', question_content: '4+6',tip: 'ヒントなし', model_answer: '10', point: '200', user_id: '5' )
Question.create(id: 19, genre_id:'2', question_name:'これ、なぁんだ', question_content: '0 (なんとよむかな？)',tip: '1よりもっとちいさいよ', model_answer: 'れい (ゼロでもせいかい!)', point: '200', user_id: '5' )
Question.create(id: 20, genre_id:'2', question_name:'ふえないたしざん', question_content: '2+0',tip: '0をたすとふえるのかな？', model_answer: '2', point: '150', user_id: '5' )
Question.create(id: 21, genre_id:'2', question_name:'ふえないたしざん', question_content: '0+3',tip: '0に３をたすんだね', model_answer: '3', point: '150', user_id: '5' )
Question.create(id: 22, genre_id:'2', question_name:'ふえないたしざん', question_content: '0+0',tip: '', model_answer: '0', point: '220', user_id: '5' )
Question.create(id: 23, genre_id:'2', question_name:'たしざん', question_content: '3+1',tip: 'ヒントなし', model_answer: '4', point: '100', user_id: '5' )
Question.create(id: 24, genre_id:'2', question_name:'たしざん', question_content: '4+5',tip: 'ヒントなし', model_answer: '9', point: '100', user_id: '5' )
Question.create(id: 25, genre_id:'2', question_name:'たしざん', question_content: '7+1',tip: 'ヒントなし', model_answer: '8', point: '100', user_id: '5' )
Question.create(id: 26, genre_id:'2', question_name:'たしざん', question_content: '2+7',tip: 'ヒントなし', model_answer: '9', point: '100', user_id: '5' )
Question.create(id: 27, genre_id:'2', question_name:'たしざん', question_content: '1+6',tip: 'ヒントなし', model_answer: '7', point: '100', user_id: '5' )
Question.create(id: 28, genre_id:'2', question_name:'たしざん', question_content: '4+2',tip: 'ヒントなし', model_answer: '6', point: '100', user_id: '5' )
Question.create(id: 29, genre_id:'2', question_name:'たしざん', question_content: '3+4',tip: 'ヒントなし', model_answer: '7', point: '100', user_id: '5' )
Question.create(id: 30, genre_id:'2', question_name:'たしざん', question_content: '3+7',tip: 'ヒントなし', model_answer: '10', point: '160', user_id: '5' )
Question.create(id: 31, genre_id:'2', question_name:'たしざん', question_content: '9+1',tip: 'ヒントなし', model_answer: '10', point: '160', user_id: '5' )