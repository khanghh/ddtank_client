package RechargeRank
{
   import RechargeRank.data.RechargeRankVo;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.LeftViewInfoVo;
   
   public class RechargeRankManager extends EventDispatcher
   {
      
      public static const RECHARGE_UPDATEVIEW:String = "rechargeUpdateView";
      
      private static var _instance:RechargeRankManager;
       
      
      public var actId:String;
      
      public var status:int;
      
      public var xmlData:GmActivityInfo;
      
      public var myConsume:int;
      
      public var rankList:Array;
      
      private var requestCount:int = 0;
      
      public function RechargeRankManager()
      {
         super();
      }
      
      public static function get instance() : RechargeRankManager
      {
         if(!_instance)
         {
            _instance = new RechargeRankManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(352),__updateInfo);
      }
      
      protected function __updateInfo(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:* = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         actId = _loc4_.readUTF();
         var _loc10_:Boolean = _loc4_.readBoolean();
         var _loc2_:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc7_:Dictionary = WonderfulActivityManager.Instance.leftViewInfoDic;
         if(_loc10_)
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
               _loc7_[actId] = new LeftViewInfoVo(61,"· " + xmlData.activityName,xmlData.icon);
               WonderfulActivityManager.Instance.addElement(actId);
            }
            rankList = [];
            _loc3_ = _loc4_.readInt();
            if(_loc3_ <= 0)
            {
               _loc6_ = 0;
               while(_loc6_ < 10)
               {
                  _loc9_ = new RechargeRankVo();
                  _loc9_.userId = 0;
                  _loc9_.name = "";
                  _loc9_.vipLvl = 0;
                  _loc9_.consume = 0;
                  rankList.push(_loc9_);
                  _loc6_++;
               }
            }
            else
            {
               _loc8_ = 0;
               while(_loc8_ <= _loc3_ - 1)
               {
                  _loc5_ = new RechargeRankVo();
                  _loc5_.userId = _loc4_.readInt();
                  _loc5_.name = _loc4_.readUTF();
                  _loc5_.vipLvl = _loc4_.readByte();
                  _loc5_.consume = _loc4_.readInt();
                  rankList.push(_loc5_);
                  _loc8_++;
               }
            }
            myConsume = _loc4_.readInt();
            dispatchEvent(new Event("rechargeUpdateView"));
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(actId);
         }
      }
   }
}
