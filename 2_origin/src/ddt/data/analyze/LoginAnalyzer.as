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
      
      public function LoginAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = new XML(data);
         var result:String = xml.@value;
         message = xml.@message;
         if(result == "true")
         {
            PlayerManager.Instance.isReportGameProfile = false;
            PlayerManager.Instance.Self.beginChanges();
            ObjectUtils.copyPorpertiesByXML(PlayerManager.Instance.Self,xml..Item[0]);
            PlayerManager.Instance.Self.commitChanges();
            PlayerManager.Instance.Account.Password = tempPassword;
            ChurchManager.instance.selfRoom = xml..Item[0].@IsCreatedMarryRoom == "false"?null:new ChurchRoomInfo();
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
