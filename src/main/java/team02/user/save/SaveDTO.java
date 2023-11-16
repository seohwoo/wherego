package team02.user.save;


public class SaveDTO {
	
		private String contentid;
		private String id;
		private String title;
		private String firstimage;
		private String areacodename;
		private String sigungucodename;
		private String category;
		private double stars;
		private int totalstars;

		public String getContentid() {
			return contentid;
		}

		public void setContentid(String contentid) {
			this.contentid = contentid;
		}

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getTitle() {
			return title;
		}

		public void setTitle(String title) {
			this.title = title;
		}

		public String getFirstimage() {
			return firstimage;
		}

		public void setFirstimage(String firstimage) {
			this.firstimage = firstimage;
		}

		public String getAreacodename() {
			return areacodename;
		}

		public void setAreacodename(String areacodename) {
			this.areacodename = areacodename;
		}

		public String getSigungucodename() {
			return sigungucodename;
		}

		public void setSigungucodename(String sigungucodename) {
			this.sigungucodename = sigungucodename;
		}

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public double getStars() {
			return stars;
		}

		public void setStars(double stars) {
			this.stars = stars;
		}

		public int getTotalstars() {
			return totalstars;
		}

		public void setTotalstars(int totalstars) {
			this.totalstars = totalstars;
		}

}
