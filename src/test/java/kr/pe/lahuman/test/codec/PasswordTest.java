package kr.pe.lahuman.test.codec;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import kr.pe.lahuman.utils.PasswordHash;

public class PasswordTest {
	
	public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeySpecException {
		System.out.println(PasswordHash.createHash("DbWlRhksFl"));
		System.out.println(PasswordHash.validatePassword("admin", "1000:768b5fd12e8edb7eac8e41dcd29d37e15af828603a32e494:ef4e01be9fc956f85bf63d121cbe20bf5563eeecdc531120"));
		
//		
//		1000:69477d484316b6cdd5cdaad87fc82d9ce1a9f63f595bf2d9:b3194991f074178b077cb3d59874f43d441c9c891d023175
	}

}
