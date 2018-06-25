package ddt.utils
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.math.BigInteger;
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   
   public class CrytoUtils
   {
       
      
      public function CrytoUtils()
      {
         super();
      }
      
      public static function rsaEncry(m:String, e:String, src:String) : String
      {
         return rsaEncry2(Base64.decodeToByteArray(m),Base64.decodeToByteArray(e),src);
      }
      
      public static function rsaEncry2(m:ByteArray, e:ByteArray, src:String) : String
      {
         var mi:BigInteger = new BigInteger(m);
         var ei:BigInteger = new BigInteger(e);
         var rsa:RSAKey = new RSAKey(mi,ei.intValue());
         return rsaEncry3(rsa,src);
      }
      
      public static function generateRsaKey(m:String, e:String) : RSAKey
      {
         return generateRsaKey2(Base64.decodeToByteArray(m),Base64.decodeToByteArray(e));
      }
      
      public static function generateRsaKey2(m:ByteArray, e:ByteArray) : RSAKey
      {
         var mi:BigInteger = new BigInteger(m);
         var ei:BigInteger = new BigInteger(e);
         return new RSAKey(mi,ei.intValue());
      }
      
      public static function rsaEncry3(rsa:RSAKey, src:String) : String
      {
         var sData:ByteArray = new ByteArray();
         sData.writeUTF(src);
         var dData:ByteArray = new ByteArray();
         rsa.encrypt(sData,dData,sData.length);
         return Base64.encodeByteArray(dData);
      }
      
      public static function rsaEncry4(rsa:RSAKey, src:ByteArray) : String
      {
         var dData:ByteArray = new ByteArray();
         rsa.encrypt(src,dData,src.length);
         return Base64.encodeByteArray(dData);
      }
      
      public static function rsaEncry5(rsa:RSAKey, src:ByteArray) : ByteArray
      {
         var dData:ByteArray = new ByteArray();
         rsa.encrypt(src,dData,src.length);
         return dData;
      }
   }
}
