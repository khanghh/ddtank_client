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
      
      protected function __updateInfo(event:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var vo:* = null;
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
               leftViewInfoDic[actId] = new LeftViewInfoVo(23,"· " + xmlData.activityName,xmlData.icon);
               WonderfulActivityManager.Instance.addElement(actId);
            }
            rankList = [];
            count = pkg.readInt();
            for(i = 0; i <= count - 1; )
            {
               vo = new ConsumeRankVo();
               vo.userId = pkg.readInt();
               vo.name = pkg.readUTF();
               vo.vipLvl = pkg.readByte();
               vo.consume = pkg.readInt();
               rankList.push(vo);
               i++;
            }
            myConsume = pkg.readInt();
            dispatchEvent(new Event("consumeUpdateView"));
         }
         else
         {
            WonderfulActivityManager.Instance.removeElement(actId);
         }
      }
   }
}
