package flowerGiving
{
   import com.pickgliss.ui.image.MovieImage;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.utils.Dictionary;
   import flowerGiving.events.FlowerGiveEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class FlowerGivingManager extends CoreManager
   {
      
      private static var _ins:FlowerGivingManager;
       
      
      public var hallView:HallStateView;
      
      public var isShowIcon:Boolean;
      
      public var actId:String;
      
      public var xmlData:GmActivityInfo;
      
      private var _flowerGivingIcon:MovieImage;
      
      public var flowerTempleteId:int;
      
      public function FlowerGivingManager(single:inner)
      {
         super();
         addEvents();
      }
      
      public static function get instance() : FlowerGivingManager
      {
         if(!_ins)
         {
            _ins = new FlowerGivingManager(new inner());
         }
         return _ins;
      }
      
      public function get flowerGivingIcon() : MovieImage
      {
         return _flowerGivingIcon;
      }
      
      public function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(257,2),__flowerFallHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(257,7),__flowerGivingOpenHandler);
      }
      
      public function removeEvents() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,2),__flowerFallHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(257,7),__flowerGivingOpenHandler);
      }
      
      public function checkOpen() : void
      {
         isShowIcon = false;
         var now:Date = TimeManager.Instance.Now();
         var activityData:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc5_:int = 0;
         var _loc4_:* = activityData;
         for each(var item in activityData)
         {
            if(item.activityType == 11 && now.time >= Date.parse(item.beginTime) && now.time <= Date.parse(item.endShowTime))
            {
               switch(int(item.activityChildType))
               {
                  case 0:
                     flowerTempleteId = 334128;
                     break;
                  case 1:
                     flowerTempleteId = 334129;
                     break;
                  case 2:
                     flowerTempleteId = 334130;
                     break;
                  case 3:
                     flowerTempleteId = 334133;
                     break;
                  case 4:
                     flowerTempleteId = 334134;
                     break;
                  case 5:
                     flowerTempleteId = 334132;
               }
               actId = item.activityId;
               xmlData = activityData[actId];
               isShowIcon = true;
            }
         }
         if(isShowIcon)
         {
            createFlowerIcon();
         }
         else
         {
            deleteFlowerIcon();
         }
      }
      
      protected function __flowerGivingOpenHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var isOpen:int = pkg.readInt();
         checkOpen();
      }
      
      protected function __flowerFallHandler(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var from:int = pkg.readInt();
         var to:int = pkg.readInt();
         var curState:String = StateManager.currentStateType;
         if(curState == "main" || curState == "roomlist" || curState == "consortia" || curState == "auction" || curState == "farm" || curState == "shop" || curState == "tofflist" || curState == "ddtchurchroomlist" || curState == "consortiaBattleScene" || curState == "matchRoom" || curState == "dungeon" || curState == "dungeonRoom" || curState == "challengeRoom")
         {
            dispatchEvent(new FlowerGiveEvent("fg_flower_fall"));
         }
      }
      
      private function createFlowerIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("flowerGiving",true);
      }
      
      public function deleteFlowerIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("flowerGiving",false);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new FlowerGiveEvent("fg_show"));
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
