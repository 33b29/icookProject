package com.icookBackstage.course.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.icookBackstage.model.ClassRoomBean;
import com.icookBackstage.model.CourseBean;

public interface CourseService {
	
	List<CourseBean> queryAllCourse();
	List<CourseBean> queryCourse(String courseName);
	
	public CourseBean getCourseById(int courseId);
	public Map<Integer, Integer> courseStock();
	
	Map<Integer, CourseBean> courseODMap(Set<Integer> cartSet);
	public void insertCourse(CourseBean bean);
	List<ClassRoomBean> roomList();
	public Map<String, String> queryClassRoom();
	public void deleteCourse(CourseBean bean);
	Boolean updateCourse(CourseBean bean);
//	public String queryClassRoom();
}
