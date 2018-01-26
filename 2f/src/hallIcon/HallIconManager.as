package hallIcon
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import firstRecharge.FirstRechargeManger;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hallIcon.event.HallIconEvent;
   import hallIcon.info.HallIconInfo;
   import hallIcon.model.HallIconModel;
   import kingBless.KingBlessManager;
   import worldboss.WorldBossManager;
   
   public class HallIconManager extends EventDispatcher
   {
      
      public static var ISLEAGUE:Boolean;
      
      private static var _instance:HallIconManager;
       
      
      public var model:HallIconModel;
      
      public function HallIconManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : HallIconManager{return null;}
      
      public function setup() : void{}
      
      public function checkDefaultIconShow() : void{}
      
      public function checkIconCall() : void{}
      
      private function initEvent() : void{}
      
      private function firstRechargeOpenHandler() : void{}
      
      private function __vipLvlIsOpenHandler(param1:Event) : void{}
      
      private function cacheRightIcon(param1:String, param2:HallIconInfo) : void{}
      
      public function checkCacheRightIconShow() : void{}
      
      public function executeCacheRightIconLevelLimit(param1:String, param2:Boolean, param3:int = 0) : void{}
      
      private function __onPlayerPropertyChange(param1:PlayerPropertyEvent) : void{}
      
      public function updateSwitchHandler(param1:String, param2:Boolean, param3:String = null, param4:int = -1, param5:Boolean = false) : void{}
      
      private function convertIconInfo(param1:String, param2:Boolean, param3:String, param4:int, param5:Boolean) : HallIconInfo{return null;}
      
      public function showCommonFrame(param1:DisplayObject, param2:String = "", param3:Number = 530, param4:Number = 545) : Frame{return null;}
      
      private function __commonFrameResponse(param1:FrameEvent) : void{}
      
      public function checkHallIconExperienceTask(param1:Boolean = true) : void{}
      
      public function checkCacheRightIconTask() : void{}
   }
}
