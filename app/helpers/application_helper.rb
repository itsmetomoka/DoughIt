module ApplicationHelper

	def non_active_user_image
		"https://pf-doughit-resize.s3-ap-northeast-1.amazonaws.com/uploads/user/image/no-user.jpg"
	end

	def no_user_image_url
		"https://pf-doughit-resize.s3-ap-northeast-1.amazonaws.com/uploads/user/image/noimage.png"
	end

	def user_image_url(user)
		"https://pf-doughit-resize.s3-ap-northeast-1.amazonaws.com/uploads/user/image/" + user.id.to_s + '/' + user.image_file_name
	end
end
