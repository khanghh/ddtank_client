package im
{
   import ddt.manager.PlayerManager;
   import road7th.utils.DateUtils;
   
   public class PresentRecordInfo
   {
      
      public static const SHOW:int = 0;
      
      public static const HIDE:int = 1;
      
      public static const UNREAD:int = 2;
       
      
      public var id:int;
      
      public var teamId:int;
      
      public var exist:int = 2;
      
      public var messages:Vector.<String>;
      
      public var recordMessage:Vector.<Object>;
      
      public function PresentRecordInfo(){super();}
      
      public function addMessage(param1:String, param2:Date, param3:String) : void{}
      
      public function get lastMessage() : String{return null;}
      
      public function get lastRecordMessage() : Object{return null;}
   }
}
