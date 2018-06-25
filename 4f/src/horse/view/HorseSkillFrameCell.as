package horse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.horse.HorseSkillCell;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import horse.HorseManager;   import horse.data.HorseEvent;   import horse.data.HorseSkillExpVo;   import horse.data.HorseSkillGetVo;      public class HorseSkillFrameCell extends Sprite implements Disposeable   {                   private var _getBtn:SimpleBitmapButton;            private var _upBtn:SimpleBitmapButton;            private var _fullTxt:FilterFrameText;            private var _skillCell:HorseSkillCell;            private var _dataList:Vector.<HorseSkillGetVo>;            private var _isGet:Boolean = false;            private var _curShowSkill:HorseSkillExpVo;            private var _index:int = -1;            public function HorseSkillFrameCell(data:Vector.<HorseSkillGetVo>) { super(); }
            private function confirmCurShowSkillId() : void { }
            private function initView() : void { }
            private function refreshView() : void { }
            private function __mouseClick(evt:MouseEvent) : void { }
            private function initEvent() : void { }
            private function upSkillSucHandler(event:Event) : void { }
            private function upClickHandler(event:MouseEvent) : void { }
            private function getClickHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}