package security;

import java.security.spec.KeySpec;
import java.util.UUID;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class SecureNew {

	private static final String UNICODE_FORMAT = "UTF8";
	public static final String DESEDE_ENCRYPTION_SCHEME = "DESede";
	private static KeySpec myKeySpec;
	private static SecretKeyFactory mySecretKeyFactory;
	private static Cipher cipher;
	static byte[] keyAsBytes;
	private static String myEncryptionKey;
	private static String myEncryptionScheme;
	static SecretKey key;

	public String encrypt(String unencryptedString) {
		String encryptedString = null;
		try {

			String usekey = UUID.randomUUID().toString();

			myEncryptionKey = usekey;
			myEncryptionScheme = DESEDE_ENCRYPTION_SCHEME;
			keyAsBytes = myEncryptionKey.getBytes(UNICODE_FORMAT);
			myKeySpec = new DESedeKeySpec(keyAsBytes);
			mySecretKeyFactory = SecretKeyFactory
					.getInstance(myEncryptionScheme);
			cipher = Cipher.getInstance(myEncryptionScheme);
			key = mySecretKeyFactory.generateSecret(myKeySpec);

			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] plainText = unencryptedString.getBytes(UNICODE_FORMAT);
			byte[] encryptedText = cipher.doFinal(plainText);
			BASE64Encoder base64encoder = new BASE64Encoder();
			encryptedString = base64encoder.encode(encryptedText);
			int rand = 10 + (int)(Math.random() * ((99 - 10) + 1));
			int rand2 = 10 + (int)(Math.random() * ((99 - 10) + 1));
			encryptedString = usekey + rand + encryptedString + rand2;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return encryptedString;
	}

	public String decrypt(String encryptedString) {
		String decryptedText = null;
		try {
			
			if(encryptedString==null){
				return null;
			}
			
			int totallen = encryptedString.length();
			String key_got = encryptedString.substring(0, 36);
			String val = encryptedString.substring(38, totallen-2);
		
			myEncryptionKey = key_got;
			myEncryptionScheme = DESEDE_ENCRYPTION_SCHEME;
			keyAsBytes = myEncryptionKey.getBytes(UNICODE_FORMAT);
			myKeySpec = new DESedeKeySpec(keyAsBytes);
			mySecretKeyFactory = SecretKeyFactory
					.getInstance(myEncryptionScheme);
			cipher = Cipher.getInstance(myEncryptionScheme);
			key = mySecretKeyFactory.generateSecret(myKeySpec);
			
			
			cipher.init(Cipher.DECRYPT_MODE, key);
			BASE64Decoder base64decoder = new BASE64Decoder();
			byte[] encryptedText = base64decoder.decodeBuffer(val);
			byte[] plainText = cipher.doFinal(encryptedText);
			decryptedText = bytes2String(plainText);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return decryptedText;
	}

	private static String bytes2String(byte[] bytes) {
		StringBuffer stringBuffer = new StringBuffer();
		for (int i = 0; i < bytes.length; i++) {
			stringBuffer.append((char) bytes[i]);
		}
		return stringBuffer.toString();
	}

	public static void main(String[] args) throws Exception {

//		// Encrypt the data sent as arg
		SecureNew sn = new SecureNew();
		String encrypted = sn.encrypt("secure this data");
//		// Decrpty the data send as arg
		String decrypted = sn.decrypt(encrypted);
		
		//Display Them
		System.out.println("Encrypted Value :" + encrypted);
		System.out.println("Decrypted Value :" + decrypted);

	}

}
