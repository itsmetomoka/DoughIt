class Batch::EditLessons
  def self.edit_lessons
    # 投稿を全て削除
    lessons = Lesson.all
    lessons.each do |lesson|
      p　"参加人数"
      p lesson.max_attendees <= lesson.reservations.count
      p "日付"
      p lesson.deadline < DateTime.now

    	if lesson.max_attendees <= lesson.reservations.count || lesson.deadline < DateTime.now
				lesson.update(is_active: false)
        p "予約不可能なレッスンを削除しました。"
			end
		end
    p '表示されるか'
  end
end
