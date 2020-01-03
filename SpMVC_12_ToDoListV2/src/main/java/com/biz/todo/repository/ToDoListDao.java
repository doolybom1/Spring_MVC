package com.biz.todo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.UpdateProvider;

import com.biz.todo.domain.ToDoList;

public interface ToDoListDao {
	
	// mybatis의 mapper를 대신하는 annotation
	@Select("SELECT * FROM tbl_todolist")
	public List<ToDoList> selectAll();
	
	@InsertProvider(type = ToDoListSQL.class,method = "insert_sql")
	public int insert(ToDoList todoList);
	
	/*
	 * mapper annotation에는 문자열로 sql문을 작성해야 하는데 sql문이 복잡할경우는 별도의 String 문자열 변수를 불러와서 사용할 수 있다
	 * 이때, sql문을 작성하는 String 문자열 변수는 반드시 final static String 형식으로 작성해야 한다
	 */
	@Update(ToDoListSQL.complete_SQL)
	public int complete(@Param("td_seq")long td_seq);
	
	
	/*
	 * ToDoListSQL 클래스의 정의된 alarm_sql method 를 호출하여 동적 쿼리를 가져와서 Update를 수행하라
	 */
	@UpdateProvider(type = ToDoListSQL.class,method = "alarm_sql")
	public int alarm(@Param("td_seq")long td_seq);
	
	@Delete("DELETE FROM tbl_todolist WHERE td_seq = #{td_seq}")
	public int delete(long td_seq);
	
	@UpdateProvider(type = ToDoListSQL.class, method = "update_sql")
	public int update(ToDoList toDoList);

	@Select("SELECT * FROM tbl_todolist WHERE td_seq = #{td_seq}")
	public ToDoList findBySeq(long tdSeq);

	@Select("SELECT * FROM tbl_todolist WHERE like '%' || #{td_subject} || '%'")
	public List<ToDoList> findBySubject(String tdSubject);
}
