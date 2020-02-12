package com.biz.shop.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
/*
 * spring security�뿉�꽌 �궗�슜�븯�뒗
 * 沅뚰븳 �젙蹂닿� �떞湲곕뒗 �뀒�씠釉�
 * �븳�궗�엺�쓽 username�뿉 ���븯�뿬 蹂듭닔�쓽 沅뚰븳�쓣 遺��뿬�븷�닔 �엳�떎.
 * authority 移쇰읆�쓽 臾몄옄�뿴�쓣 李몄“�븯�뿬
 * expression�쓣 �궗�슜�븳 �꽭遺��쟻�씤 沅뚰븳 遺��뿬�쓣 �닔�뻾�븷�닔 �엳�떎.
 * 
 * ADMIN, USER, MANAGER �벑�벑�쓽 臾몄옄�뿴�쓣 ���옣�븯怨�
 * hasRole('ADMIN'), hasRole('USER'), hasRole('MANGER') �삎�떇�쑝濡�
 * 濡쒓렇�씤�맂 �궗�슜�옄�쓽 沅뚰븳�쓣 李몄“�븷�닔 �엳�떎.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder

@Entity
@Table(name="authorities",schema = "emsDB")
public class Authorities {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long seq;
	private String username;
	private String authority;
	
}




