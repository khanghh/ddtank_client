package ddt.utils
{
   import com.pickgliss.utils.MD5;
   import ddt.manager.PlayerManager;
   import flash.net.URLVariables;
   
   public class RequestVairableCreater
   {
       
      
      public function RequestVairableCreater()
      {
         super();
      }
      
      public static function creatWidthKey(mustNew:Boolean) : URLVariables
      {
         var data:URLVariables = new URLVariables();
         data["selfid"] = PlayerManager.Instance.Self.ID;
         data["key"] = MD5.hash(PlayerManager.Instance.Account.Password);
         if(mustNew)
         {
            data["rnd"] = Math.random();
         }
         return data;
      }
   }
}
