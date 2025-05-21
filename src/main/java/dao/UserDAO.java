package dao;

import model.Department;
import model.User;
import utils.DbUtil;
import utils.PasswordHashing;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	public static String getUserNameFromId(int id) {
		String query = "select name from users where id = ?";
		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString("name");
			}
			return "";
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	// Register User Method
	public static boolean registerUser(User user) {
		boolean result = false;
		String query = "INSERT INTO users (name, email, password, phone, picture_path, role, is_active, is_deleted, department_id, hire_date) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		String hashedPassword = PasswordHashing.hashPassword(user.getPassword());

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, hashedPassword);
			ps.setString(4, user.getPhone());
			ps.setBytes(5, user.getPicturePath());
			ps.setInt(6, user.getRole());
			ps.setBoolean(7, user.isActive());
			ps.setBoolean(8, false);
			ps.setInt(9, user.getDepartmentId());
			ps.setDate(10, user.getHireDate());

			int rows = ps.executeUpdate();
			result = rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// Validate User on Login
	public static User validateUser(String email, String password) {
		User user = null;
		String query = "SELECT * FROM users WHERE email=? AND is_deleted=FALSE";
		boolean validated = false;
		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = mapUserFromResultSet(rs);
				validated = PasswordHashing.checkPassword(password, user.getPassword());

				if (!validated) {
					return null;
				}
				DepartmentDAO departmentDAO = new DepartmentDAO();
				Department department = departmentDAO.getDepartmentById(user.getDepartmentId());
				user.setDepartment(department);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	// Get User by Email
	public static User getUserByEmail(String email) {
		User user = null;
		String query = "SELECT * FROM users WHERE email=?";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = mapUserFromResultSet(rs);
				DepartmentDAO departmentDAO = new DepartmentDAO();
				Department department = departmentDAO.getDepartmentById(user.getDepartmentId());
				user.setDepartment(department);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	// Get User by Email
	public static User getUserByUserName(String userName) {
		User user = null;
		String query = "SELECT * FROM users WHERE name = ?";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, userName);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = mapUserFromResultSet(rs);
				DepartmentDAO departmentDAO = new DepartmentDAO();
				Department department = departmentDAO.getDepartmentById(user.getDepartmentId());
				user.setDepartment(department);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	// Get User by ID
	public static User getUserById(int id) {
		User user = null;
		String query = "SELECT * FROM users WHERE id=?";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				user = mapUserFromResultSet(rs);
				DepartmentDAO departmentDAO = new DepartmentDAO();
				Department department = departmentDAO.getDepartmentById(user.getDepartmentId());
				user.setDepartment(department);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	// Get All Users
	public static List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String query = "SELECT * FROM users WHERE is_deleted=FALSE ORDER BY name";

		try (Connection conn = DbUtil.getConnection()) {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				User user = mapUserFromResultSet(rs);
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return users;
	}

	// Get All Users With Role and Department Names
	public static List<User> getAllUsersWithRoleAndDepartment() {
		List<User> users = new ArrayList<>();

		String sql = "SELECT u.*, d.name AS department_name, r.name AS role_name " + "FROM users u "
				+ "JOIN department d ON u.department_id = d.id " + "JOIN roles r ON u.role = r.id "
				+ "WHERE u.is_deleted = FALSE ORDER BY u.name";

		try (Connection conn = DbUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				User user = mapUserFromResultSet(rs);
				user.setDepartmentName(rs.getString("department_name"));
				user.setRoleName(rs.getString("role_name"));
				users.add(user);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return users;
	}

	// Get Users by Department
	public static List<User> getUsersByDepartment(int departmentId) {
		List<User> users = new ArrayList<>();
		String query = "SELECT * FROM users WHERE department_id=? AND is_deleted=FALSE ORDER BY name";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, departmentId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				User user = mapUserFromResultSet(rs);
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return users;
	}

	// Update User
	public static boolean updateUser(User user) {
		boolean result = false;
		String query = "UPDATE users SET name=?, email=?, phone=?, picture_path=?, role=?, is_active=?, department_id=?, hire_date=? WHERE id=?";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setBytes(4, user.getPicturePath());
			ps.setInt(5, user.getRole());
			ps.setBoolean(6, user.isActive());
			ps.setInt(7, user.getDepartmentId());
			ps.setDate(8, user.getHireDate());
			ps.setInt(9, user.getId());

			int rows = ps.executeUpdate();
			result = rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// Update Password
	public static boolean updatePassword(int userId, String newPassword) {
		String query = "UPDATE users SET password=? WHERE id=?";

		try (Connection conn = DbUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
			ps.setString(1, newPassword);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Soft Delete User
	public static boolean deleteUser(int userId) {
		boolean result = false;
		String query = "UPDATE users SET is_deleted=TRUE WHERE id=?";

		try (Connection conn = DbUtil.getConnection()) {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, userId);

			int rows = ps.executeUpdate();
			result = rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// Map ResultSet to User
	private static User mapUserFromResultSet(ResultSet rs) throws SQLException {
		User user = new User();
		user.setId(rs.getInt("id"));
		user.setName(rs.getString("name"));
		user.setEmail(rs.getString("email"));
		user.setPassword(rs.getString("password"));
		user.setPhone(rs.getString("phone"));
		user.setPicturePath(rs.getBytes("picture_path"));
		user.setRole(rs.getInt("role"));
		user.setActive(rs.getBoolean("is_active"));
		user.setDeleted(rs.getBoolean("is_deleted"));
		user.setDepartmentId(rs.getInt("department_id"));
		user.setHireDate(rs.getDate("hire_date"));
		user.setCreatedAt(rs.getTimestamp("created_at"));
		return user;
	}
}
