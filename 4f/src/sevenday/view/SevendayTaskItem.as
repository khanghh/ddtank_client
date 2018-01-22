package sevenday.view
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.BattleGroudManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import littleGame.LittleControl;
   import petsBag.PetsBagManager;
   import ringStation.RingStationManager;
   import sevenday.SevendayManager;
   import wantstrong.WantStrongManager;
   
   public class SevendayTaskItem extends Sprite implements Disposeable
   {
       
      
      private var _taskText:FilterFrameText;
      
      private var _gotoBtn:FilterFrameText;
      
      private var _icon:ScaleFrameImage;
      
      private var _taskSprite:Sprite;
      
      private var _num:int;
      
      private var _iteminfo:ItemTemplateInfo;
      
      private var _lastCreatTime:int;
      
      private var _info:QuestInfo;
      
      public function SevendayTaskItem(){super();}
      
      private function initView() : void{}
      
      private function complete(param1:int) : void{}
      
      private function uncomplete(param1:int) : void{}
      
      private function gotowhere(param1:MouseEvent) : void{}
      
      public function update(param1:QuestInfo, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
