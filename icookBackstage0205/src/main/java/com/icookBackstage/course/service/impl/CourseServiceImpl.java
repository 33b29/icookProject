package com.icookBackstage.course.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.icookBackstage.course.dao.CourseDao;
import com.icookBackstage.course.service.CourseService;
import com.icookBackstage.model.ClassRoomBean;
import com.icookBackstage.model.CourseBean;

@Transactional
@Service
public class CourseServiceImpl implements CourseService {

	CourseDao dao;

	@Autowired
	public void setDao(CourseDao dao) {
		this.dao = dao;
	}

	@Transactional
	@Override
	public List<CourseBean> queryCourse(String courseName) {
		return dao.queryCourse(courseName);
	}

	@Transactional
	@Override
	public List<CourseBean> queryAllCourse() {
		return dao.queryAllCourse();
	}

	@Transactional
	@Override
	public CourseBean getCourseById(int courseId) {
		return dao.getCourseById(courseId);
	}

	@SuppressWarnings("null")
	@Transactional
	@Override
	public Map<Integer, Integer> courseStock() {
//		int courseCapacity = dao.courseCapacity(courseId);
		Map<Integer, Integer> courStock = new HashMap<>();
		List<CourseBean> cbl = dao.queryAllCourse();

		for (CourseBean cb : cbl) {
//			找出課程訂單
			List<Integer> courseOrderQty = dao.courseOrderQty(cb.getCourseId());
			int sum = 0;
			System.out.println("courseOrderQty: "+courseOrderQty.size());
//			if (courseOrderQty == null) {
			if (courseOrderQty.size() == 0) {
				courStock.put(cb.getCourseId(),dao.courseCapacity(cb.getCourseId()) );
			} else {
//			把每筆訂單的數量加起來
				for (Integer i : courseOrderQty) {
					sum += i;
				}
//			計算課程: 教室容納的數量-訂單數量
				Integer courseStock = dao.courseCapacity(cb.getCourseId()) - sum;
//			System.out.println("courseStock: "+courseStock());
				System.out.println("courseStock: " + courseStock);
				courStock.put(cb.getCourseId(), courseStock);
			}
		}
		return courStock;
	}

	@SuppressWarnings("null")
	@Transactional
	@Override
	public Map<Integer, CourseBean> courseODMap(Set<Integer> cartSet) {
		Map<Integer, CourseBean> courseMap = null;
		for (Integer c : cartSet) {
			System.out.println("c: " + c);
			courseMap.put(c, dao.getCourseById(c));
		}
		return courseMap;
	}

	@Transactional
	@Override
	public void insertCourse(CourseBean bean) {
		dao.insertCourse(bean);
	}

	@Transactional
	@Override
	public List<ClassRoomBean> roomList() {
		return dao.roomList();
	}

	@Transactional
	@Override
	public Map<String, String> queryClassRoom() {
//		Map<教室名稱, json-使用時間>
		Map<String, String> mapRoom = new LinkedHashMap<>();
		List<CourseBean> rooms = dao.queryAllCourse();
//		測試新的方法 ==> OK
		GsonBuilder builder = new GsonBuilder();
		builder.excludeFieldsWithoutExposeAnnotation();
		Gson gson1 = builder.create();
		for (CourseBean room : rooms) {
			String json = null;
//			取得List-教室使用資訊
			List<CourseBean> courList = dao.queryClassRoom(room.getRoomNo());
//			將List的內容轉為Json
			json = gson1.toJson(courList);
			mapRoom.put(room.getRoomNo(), json);
//			System.out.println("courList: "+courList);
//			System.out.println("json: "+mapRoom.get(room.getRoomNo()));
		}
//		String jsonMap = gson2.toJson(mapRoom);	

		return mapRoom;
	}

	@Transactional
	@Override
	public void deleteCourse(CourseBean bean) {
		dao.deleteCourse(bean);
	}

	@Override
	public Boolean updateCourse(CourseBean bean) {
		return dao.updateCourse(bean);
	}

//	@Transactional
//	@Override
//	public Map<Integer,CourseBean> courseCartList(Set<Integer> courseId) {
//		Map<Integer,CourseBean> cbm = null;
//		System.out.println("Set courseId: " + courseId);
//		for(int i:courseId) {
//			cbm.put(i, dao.getCourseById(i));
//		}		
//		return cbm;
//	}

}
