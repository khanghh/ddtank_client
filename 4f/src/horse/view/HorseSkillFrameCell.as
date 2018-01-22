package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.horse.HorseSkillCell;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import trainer.view.NewHandContainer;
   
   public class HorseSkillFrameCell extends Sprite implements Disposeable
   {
       
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _fullTxt:FilterFrameText;
      
      private var _skillCell:HorseSkillCell;
      
      private var _dataList:Vector.<HorseSkillGetVo>;
      
      private var _isGet:Boolean = false;
      
      private var _curShowSkill:HorseSkillExpVo;
      
      private var _index:int = -1;
      
      public function HorseSkillFrameCell(param1:Vector.<HorseSkillGetVo>){super();}
      
      private function confirmCurShowSkillId() : void{}
      
      private function initView() : void{}
      
      private function refreshView() : void{}
      
      private function __mouseClick(param1:MouseEvent) : void{}
      
      private function initEvent() : void{}
      
      private function upSkillSucHandler(param1:Event) : void{}
      
      private function upClickHandler(param1:MouseEvent) : void{}
      
      private function getClickHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
