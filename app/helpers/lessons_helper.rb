module LessonsHelper

	def s3_lesson_image(lesson)
		lesson_image = "https://pf-doughit-resize.s3-ap-northeast-1.amazonaws.com/uploads/lesson/image/" +lesson.id.to_s + '/' + lesson.image_file_name
	end
end
