package utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashing {
	// Method to hash a password
	public static String hashPassword(String plainPassword) {
		return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
	}

	// Method to validate a password against a hash
	public static boolean checkPassword(String plainPassword, String hashedPassword) {
		return BCrypt.checkpw(plainPassword, hashedPassword);
	}
}
