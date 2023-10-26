package team02.admin.use;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import team02.db.land.OracleDB;

public class AdminMemberDAO extends OracleDB {
	private static AdminMemberDAO instance = new AdminMemberDAO();

	public static AdminMemberDAO getInstance() {
		return instance;
	}

	private AdminMemberDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<AdminMemberDTO> selectCleanMember(int start, int end) {
		ArrayList<AdminMemberDTO> memberList = new ArrayList<AdminMemberDTO>();

		conn = getConnection();
		try {
			String sql = " select * from (select mem.*, rownum as r from "
					+ " (select * from member where grade>=2 and grade<=99 order by grade desc, reg_date desc) mem ) where r>=? and r<=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AdminMemberDTO dto = new AdminMemberDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setNic(rs.getString("nic"));
				dto.setBirth(rs.getString("birth"));
				dto.setGender(rs.getString("gender"));
				dto.setAddress(rs.getString("address"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setProfile(rs.getString("profile"));
				dto.setReg_date(rs.getString("reg_date"));
				dto.setTotal(rs.getInt("total"));
				dto.setGrade(rs.getInt("grade"));
				memberList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return memberList;
	}

	public int cleanMemberCnt() {
		int cnt = 0;
		conn = getConnection();
		try {
			String sql = " select count(*) from member ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return cnt;
	}

	public String findGradeName(int grade) {
		String gradeName = "";
		conn = getConnection();
		try {
			String sql = " select gradename from membergrade where gradeNum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, grade);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				gradeName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return gradeName;
	}
}
