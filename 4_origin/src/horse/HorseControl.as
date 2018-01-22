package horse
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horse.amulet.HorseAmuletMainView;
   import horse.data.HorsePicCherishVo;
   import horse.horsePicCherish.HorsePicCherishFrame;
   import horse.horsePicCherish.HorsePicCherishTip;
   import horse.view.HorseFrame;
   import horse.view.HorseGetSkillView;
   import horse.view.HorseSkillCellTip;
   
   public class HorseControl extends EventDispatcher
   {
      
      private static var _instance:HorseControl;
       
      
      private var _horseFrame:HorseFrame;
      
      private var _horseAmuletFrame:HorseAmuletMainView;
      
      public function HorseControl(param1:IEventDispatcher = null)
      {
         super(param1);
         HorseSkillCellTip;
      }
      
      public static function get instance() : HorseControl
      {
         if(_instance == null)
         {
            _instance = new HorseControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         HorseManager.instance.addEventListener("showNewSkillView",__onShowSkillView);
         HorseManager.instance.addEventListener("horseOpenView",__onOpenView);
         HorseManager.instance.addEventListener("horseHideView",__onHideView);
      }
      
      protected function __onHideView(param1:Event) : void
      {
         closeFrame();
      }
      
      protected function __onOpenView(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(!_horseFrame)
         {
            _horseFrame = ComponentFactory.Instance.creatComponentByStylename("HorseFrame");
            _horseFrame.addEventListener("dispose",frameDisposeHandler,false,0,true);
            LayerManager.Instance.addToLayer(_horseFrame,3,true,1);
            if(HorseManager.instance.isSkipFromBagView)
            {
               _loc2_ = 1;
               _loc5_ = HorseManager.instance.getHorsePicCherishData();
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  if(_loc5_[_loc3_].ID == HorseManager.instance.skipHorsePicCherishId)
                  {
                     if(_loc3_ != 0)
                     {
                        _loc2_ = int(_loc3_ / 8) + 1;
                     }
                     break;
                  }
                  _loc3_++;
               }
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("HorsePicCherishFrame");
               _loc4_.index = _loc2_;
               LayerManager.Instance.addToLayer(_loc4_,3,true,1);
            }
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(110))
         {
            SocketManager.Instance.out.syncWeakStep(110);
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(111))
         {
            SocketManager.Instance.out.syncWeakStep(111);
         }
      }
      
      private function frameDisposeHandler(param1:ComponentEvent) : void
      {
         if(_horseFrame)
         {
            _horseFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         _horseFrame = null;
      }
      
      public function closeFrame() : void
      {
         if(_horseFrame)
         {
            _horseFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         ObjectUtils.disposeObject(_horseFrame);
         _horseFrame = null;
      }
      
      public function upFloatCartoonPlayComplete() : void
      {
         HorseManager.instance.isUpFloatCartoonComplete = true;
         HorseManager.instance.dispatchEvent(new Event("horseUpHorseStep2"));
         if(HorseManager.instance.isNeedPlayGetNewSkillCartoon)
         {
            openGetNewSkillView();
         }
      }
      
      protected function __onShowSkillView(param1:Event) : void
      {
         openGetNewSkillView();
      }
      
      private function openGetNewSkillView() : void
      {
         var _loc1_:HorseGetSkillView = new HorseGetSkillView();
         _loc1_.show(HorseManager.instance.curHasSkillList[HorseManager.instance.curHasSkillList.length - 1].skillId);
         HorseManager.instance.isNeedPlayGetNewSkillCartoon = false;
         HorseManager.instance.isUpFloatCartoonComplete = false;
      }
      
      private function updateHorse() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = PlayerManager.Instance.Self.horsePicCherishDic;
         for(var _loc1_ in PlayerManager.Instance.Self.horsePicCherishDic)
         {
            PlayerManager.Instance.Self.horsePicCherishDic[_loc1_].isUsed = int(_loc1_) == HorseManager.instance.curUseHorse;
         }
         dispatchEvent(new Event("horseChangeHorse"));
      }
      
      public function getHorsePicCherishState(param1:int, param2:int) : Array
      {
         var _loc5_:Boolean = false;
         var _loc4_:* = false;
         var _loc3_:Boolean = false;
         _loc5_ = PlayerManager.Instance.Self.horsePicCherishDic.hasKey(param1);
         _loc4_ = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(param2) != null;
         if(_loc5_)
         {
            _loc3_ = PlayerManager.Instance.Self.horsePicCherishDic[param1].isUsed;
         }
         return [_loc5_,_loc4_,_loc3_];
      }
      
      public function getHorsePicCherishAddProperty(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = HorseManager.instance.getHorsePicCherishData();
         for each(var _loc2_ in HorseManager.instance.getHorsePicCherishData())
         {
            if(_loc2_.ID == param1)
            {
               return [_loc2_.AddHurt,_loc2_.AddGuard,_loc2_.AddBlood,_loc2_.MagicAttack,_loc2_.MagicDefence];
            }
         }
         return [0,0,0,0,0];
      }
      
      public function openHorseMainView() : void
      {
         if(_horseAmuletFrame == null)
         {
            new HelperUIModuleLoad().loadUIModule(["horseAmulet","ddtbagandinfo"],function():void
            {
               closeFrame();
               _horseAmuletFrame = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.mainView");
               _horseAmuletFrame.addEventListener("dispose",__onDispose);
               _horseAmuletFrame.show();
            });
         }
      }
      
      private function __onDispose(param1:ComponentEvent) : void
      {
         _horseAmuletFrame = null;
      }
   }
}
