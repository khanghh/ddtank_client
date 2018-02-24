package ddt.data
{
   import church.events.WeddingRoomEvent;
   import flash.events.EventDispatcher;
   
   public class ChurchRoomInfo extends EventDispatcher
   {
      
      public static const WEDDING_NONE:String = "wedding_none";
      
      public static const WEDDING_ING:String = "wedding_ing";
       
      
      public var id:int;
      
      public var roomName:String = "";
      
      public var brideID:int;
      
      public var brideName:String;
      
      public var groomID:int;
      
      public var groomName:String;
      
      public var createID:int;
      
      public var createName:String;
      
      public var mapID:int;
      
      public var isLocked:Boolean;
      
      public var password:String = "";
      
      public var discription:String = "";
      
      public var canInvite:Boolean;
      
      public var isUsedSalute:Boolean;
      
      public var creactTime:Date;
      
      private var _validTimes:uint;
      
      public var maxNum:uint = 200;
      
      private var _status:String = "wedding_none";
      
      private var _currentNum:uint;
      
      private var _isStarted:Boolean;
      
      public var seniorType:int = 0;
      
      public function ChurchRoomInfo(){super();}
      
      public function get isStarted() : Boolean{return false;}
      
      public function set isStarted(param1:Boolean) : void{}
      
      public function get valideTimes() : uint{return null;}
      
      public function set valideTimes(param1:uint) : void{}
      
      public function get currentNum() : uint{return null;}
      
      public function set currentNum(param1:uint) : void{}
      
      public function get status() : String{return null;}
      
      public function set status(param1:String) : void{}
   }
}
