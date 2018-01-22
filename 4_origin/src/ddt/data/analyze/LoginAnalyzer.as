package ddt.data.analyze
{
   import church.ChurchManager;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ChurchRoomInfo;
   import ddt.manager.IMManager;
   import ddt.manager.PlayerManager;
   
   public class LoginAnalyzer extends DataAnalyzer
   {
       
      
      public var tempPassword:String;
      
      public function LoginAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc3_:XML = new XML(param1);
         var _loc2_:String = _loc3_.@value;
         message = _loc3_.@message;
         if(_loc2_ == "true")
         {
            PlayerManager.Instance.isReportGameProfile = false;
            PlayerManager.Instance.Self.beginChanges();
            ObjectUtils.copyPorpertiesByXML(PlayerManager.Instance.Self,_loc3_..Item[0]);
            PlayerManager.Instance.Self.commitChanges();
            PlayerManager.Instance.Account.Password = tempPassword;
            ChurchManager.instance.selfRoom = _loc3_..Item[0].@IsCreatedMarryRoom == "false"?null:new ChurchRoomInfo();
            PlayerManager.Instance.isReportGameProfile = true;
            onAnalyzeComplete();
            IMManager.Instance.setupRecentContactsList();
         }
         else
         {
            onAnalyzeError();
         }
      }
   }
}
