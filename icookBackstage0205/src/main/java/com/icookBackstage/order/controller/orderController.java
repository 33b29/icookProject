package com.icookBackstage.order.controller;

import java.io.IOException;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.icookBackstage.model.CustomerInfo;
import com.icookBackstage.model.MemberBean;
import com.icookBackstage.model.ProductOrder;
import com.icookBackstage.model.orderBean;
import com.icookBackstage.model.orderDetail;
import com.icookBackstage.order.service.SearchOrdersServiceDao;
import com.icookBackstage.sendmail.service.mailService;
import com.icookBackstage.sendmail.service.sendmailService;

@Controller
public class orderController {

	@Autowired
	SearchOrdersServiceDao service;

	@Autowired
	public void setService(SearchOrdersServiceDao service) {
		this.service = service;
	}
	
	@Autowired
	sendmailService emailservice;

	@Autowired
	public void setService(sendmailService service) {
		this.emailservice = service;
	}
	
	//@RequestBody這個一班是在處理ajax請求中聲明contentType:"application/json; charset=utf-8"時候會用到的
	//如不使用則回傳沒辦法是一個型態
	@RequestMapping(value = "/appJson", method = RequestMethod.POST, produces="text/html;charset=UTF-8")
	@ResponseBody
	public String changeJson(@RequestParam(value="page") String page,Model model, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		HttpSession session = request.getSession(false);
		Gson gson = new Gson();
		MemberBean mem = (MemberBean) session.getAttribute("LoginOK");
		int pag = Integer.parseInt(page);
		session.setAttribute("page", pag);
		int UID = mem.getUserId();
		List<orderBean> orderData = service.searchAllDetails(UID);
		String json = gson.toJson(orderData);
		return json;
	}
	
	//@RequestParam(value="page", required=false) required代表非必要傳入的參數
	@RequestMapping(value = "/MyOrders/Orders", method = RequestMethod.GET)
	public String SearchOrders(@RequestParam(value="page", required=false) String page, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		//如果url沒有帶?page=?進來，則自動導入第一頁
		if(page==null) {
			page = "1";
		}
		HttpSession session = request.getSession(false);
		session.setAttribute("page", page);
		MemberBean mem = (MemberBean) session.getAttribute("LoginOK");
		// 取得登入者資訊
		if (mem == null || session.getAttribute("page") == null) { // 使用逾時
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath()));
			return "index";
		} 
		else {
			session.setAttribute("LogYesNo", "Yes");
			int pag = Integer.parseInt(page);
			session.setAttribute("page", pag);
//			MemberBean mem = (MemberBean) session.getAttribute("LoginOK");
			int UID = mem.getUserId();
			List<orderBean> orderData = service.searchAllDetails(UID);
			if (orderData.isEmpty()) {
				session.setAttribute("stat", false);
			} else {
				session.setAttribute("stat", true);
			}
			session.setAttribute("orderData", orderData);
			return "MyOrders/Orders";
		}
	}
	
	@RequestMapping(value = "/MyOrders/SearchOrderDetails", method = RequestMethod.GET)
	public String SearchOrdDetail(HttpServletRequest request
			,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		MemberBean mem = (MemberBean) session.getAttribute("LoginOK");
		// 取得登入者資訊
		if (mem == null) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath()));
			return "index";
		}
		else {
			Serializable name = request.getQueryString(); //回傳id=2
			//取得從Orders.jsp傳來的URL後面的id=2
			String temp = (String)name;
			//把name從object型態轉換成String
			int orderId = Integer.parseInt(temp.substring(3,temp.length()));
			//把id=多少用substring切出來之後再轉換成integer
			List<orderDetail> detail = service.searchAllOrdDetails(orderId);
			session.setAttribute("orderDetailsData", detail);
			return "MyOrders/SearchOrderDetails";
		}
	}
	
	@RequestMapping(value = "/changeOrderStatus", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String changeOrderStatus(@RequestParam(value = "orderId") String Id,@RequestParam(value="status") String status,@RequestParam(value="userId") int userId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		System.out.println(userId);
		MemberBean temp = (MemberBean)service.searchMember(userId);
		int page = (int) session.getAttribute("page");
		int orderId = Integer.parseInt(Id);
		boolean result = service.changeOrderStatus(orderId, status);
		if(result == true) {
			System.out.println(temp.getNickname());
			if(status.equals("出貨中")  || status.equals("已到貨")) {
				emailservice.sendOrderConfirmation(getDummyOrder(temp,"OrderStatus",orderId,status));
			}
			return "true";
		}
		else {
			return "false";
		}
	}
	
	public static ProductOrder getDummyOrder(MemberBean memberBean,String purpose,int Id,String status) {
		ProductOrder order = new ProductOrder();
		order.setOrderId(String.valueOf(Id));
		order.setProductName(purpose);
		order.setStatus(status);
		CustomerInfo customerInfo = new CustomerInfo();
		customerInfo.setName(memberBean.getNickname());
		customerInfo.setAddress("WallStreet");
		customerInfo.setEmail(memberBean.getAccount());
		order.setCustomerInfo(customerInfo);
		return order;
	}
}
