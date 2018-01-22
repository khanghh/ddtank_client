package consumeRank
{
   import consumeRank.data.ConsumeRankVo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.LeftViewInfoVo;
   
   public class ConsumeRankManager extends EventDispatcher
   {
      
      public static const CONSUME_UPDATEVIEW:String = "consumeUpdateView";
      
      private static var _instance:ConsumeRankManager;
       
      
      public var actId:String;
      
      public var status:int;
      
      public var xmlData:GmActivityInfo;
      
      public var myConsume:int;
      
      public var rankList:Array;
      
      private var requestCount:int = 0;
      
      public function ConsumeRankManager()
      {
         super();
      }
      
      public static function get instance() : ConsumeRankManager
      {
         if(!_instance)
         {
            _instance = new ConsumeRankManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(259),__updateInfo);
      }
      
      protected function __updateInfo(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         actId = _loc4_.readUTF();
         var _loc8_:Boolean = _loc4_.readBoolean();
         var _loc2_:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc5_:Dictionary = WonderfulActivityManager.Instance.leftViewInfoDic;
         if(_loc8_)
         {
            status = _loc4_.readInt();
            xmlData = _loc2_[actId];
            if(!xmlData)
            {
               requestCount = Number(requestCount) + 1;
               if(requestCount <= 5)
               {
                  SocketManager.Instance.out.requestWonderfulActInit(0);
               }
               return;
            }
            if(WonderfulActivityManager.Instance.actList.indexOf(actId) == -1)
            {
               _loc5_[actId] = new LeftViewInfoVo(23,"· " + xmlData.activityName,xmlData.icon);
               WonderfulActivityManager.Instance.addElement(actId);
            }
            rankList = [];
            _loc3_ = _loc4_.readInt();
            _loc7_ = 0;
            while(_loc7_ <= _loc3_ - 1)
            {
               _loc6_ = new ConsumeRankVo();
               _loc6_.userId = _loc4_.readInt();
               _loc6_.name = _loc4_.readUTF();
               _loc6_.vipLvl = _loc4_.readByte();
               _loc6_.consume = _loc4_.readInt();
               rankList.push(_loc6_);
               _loc7_++;
            }
            myConsume = _loc4_.readInt();
            dispatchEvent(new Event("consumeUpdateView"));
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(actId);
         }
      }
   }
}
