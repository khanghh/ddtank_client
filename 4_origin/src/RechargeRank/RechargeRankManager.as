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
      
      protected function __updateInfo(event:PkgEvent) : void
      {
         var count:int = 0;
         var k:int = 0;
         var vo:* = null;
         var i:int = 0;
         var vo1:* = null;
         var pkg:PackageIn = event.pkg;
         actId = pkg.readUTF();
         var isOpen:Boolean = pkg.readBoolean();
         var activityData:Dictionary = WonderfulActivityManager.Instance.activityData;
         var leftViewInfoDic:Dictionary = WonderfulActivityManager.Instance.leftViewInfoDic;
         if(isOpen)
         {
            status = pkg.readInt();
            xmlData = activityData[actId];
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
               leftViewInfoDic[actId] = new LeftViewInfoVo(61,"· " + xmlData.activityName,xmlData.icon);
               WonderfulActivityManager.Instance.addElement(actId);
            }
            rankList = [];
            count = pkg.readInt();
            if(count <= 0)
            {
               for(k = 0; k < 10; )
               {
                  vo = new RechargeRankVo();
                  vo.userId = 0;
                  vo.name = "";
                  vo.vipLvl = 0;
                  vo.consume = 0;
                  rankList.push(vo);
                  k++;
               }
            }
            else
            {
               i = 0;
               while(i <= count - 1)
               {
                  vo1 = new RechargeRankVo();
                  vo1.userId = pkg.readInt();
                  vo1.name = pkg.readUTF();
                  vo1.vipLvl = pkg.readByte();
                  vo1.consume = pkg.readInt();
                  rankList.push(vo1);
                  i++;
               }
            }
            myConsume = pkg.readInt();
            dispatchEvent(new Event("rechargeUpdateView"));
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(actId);
         }
      }
   }
}
