package kr.pe.lahuman.config.security;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import kr.pe.lahuman.utils.PasswordHash;

import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordGenerator implements PasswordEncoder {

	@Override
	public String encode(CharSequence rawPassword) {
		try {
			return PasswordHash.createHash(rawPassword.toString());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		try {
			return PasswordHash.validatePassword(rawPassword.toString(), encodedPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
