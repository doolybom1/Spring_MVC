package com.biz.todo.service;

import java.util.List;

import com.biz.todo.domain.ToDoList;

public interface ToDoService {
	
	public List<ToDoList> selectAll();
	public ToDoList findBySeq(long tdSeq);
	public List<ToDoList> findBySubject(String tdSubject);
	
	public int insert(ToDoList toDoList);
	public int update(ToDoList toDoList);
	public int delete(long tdSeq);
	public int complete(String strSeq, String tdComplete);
	public int alarm(String strSeq, String tdAlarm);
}
