package room.view
{
   import battleGroud.BattleGroudControl;
   import battleSkill.BattleSkillManager;
   import battleSkill.event.BattleSkillEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import room.RoomManager;
   import room.model.RoomInfo;
   
   public class BattleRoomRightPropView extends RoomRightPropView
   {
       
      
      private var _watchIco:Bitmap;
      
      private var _watchBg:Bitmap;
      
      private var _downContainer:HBox;
      
      protected var _combatskillIcon:BaseButton;
      
      protected var _lastFightNumTxt:FilterFrameText;
      
      protected var _lastFightValueTxt:FilterFrameText;
      
      protected var _upSkillCells:DictionaryData;
      
      protected var _allSkillCells:DictionaryData;
      
      private var _downCells:DictionaryData;
      
      public function BattleRoomRightPropView(){super();}
      
      override protected function initView() : void{}
      
      protected function createInitiativeSkillList() : void{}
      
      protected function createPassiveSkillList() : void{}
      
      protected function createChanelName() : void{}
      
      protected function createRoomName() : void{}
      
      private function updateRemainCount() : void{}
      
      private function get getFightRemainData() : String{return null;}
      
      override protected function initEvents() : void{}
      
      protected function updateProView(param1:BattleSkillEvent) : void{}
      
      protected function __updateBattleRemainData(param1:CEvent) : void{}
      
      override protected function removeEvents() : void{}
      
      override protected function creatTipShapeTip() : void{}
      
      override protected function updateSkillStatus(param1:Event) : void{}
      
      private function openBattleSkillFrame(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
