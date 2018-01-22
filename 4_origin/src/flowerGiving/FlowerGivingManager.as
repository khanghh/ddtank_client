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
      
      public function FlowerGivingManager(param1:inner)
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
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc1_:Dictionary = WonderfulActivityManager.Instance.activityData;
         var _loc5_:int = 0;
         var _loc4_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_.activityType == 11 && _loc2_.time >= Date.parse(_loc3_.beginTime) && _loc2_.time <= Date.parse(_loc3_.endShowTime))
            {
               switch(int(_loc3_.activityChildType))
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
               actId = _loc3_.activityId;
               xmlData = _loc1_[actId];
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
      
      protected function __flowerGivingOpenHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         checkOpen();
      }
      
      protected function __flowerFallHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         var _loc5_:String = StateManager.currentStateType;
         if(_loc5_ == "main" || _loc5_ == "roomlist" || _loc5_ == "consortia" || _loc5_ == "auction" || _loc5_ == "farm" || _loc5_ == "shop" || _loc5_ == "tofflist" || _loc5_ == "ddtchurchroomlist" || _loc5_ == "consortiaBattleScene" || _loc5_ == "matchRoom" || _loc5_ == "dungeon" || _loc5_ == "dungeonRoom" || _loc5_ == "challengeRoom")
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
