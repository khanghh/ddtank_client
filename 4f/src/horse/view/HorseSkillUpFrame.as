package horse.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameRightBottomItemCell;
   import ddt.view.horse.HorseSkillCell;
   import ddtDeed.DeedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import shop.manager.ShopBuyManager;
   
   public class HorseSkillUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _expBg:Bitmap;
      
      private var _expCover:Bitmap;
      
      private var _expPerTxt:FilterFrameText;
      
      private var _rightArrow:Bitmap;
      
      private var _countTitleTxt:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _freeUpBtn:SimpleBitmapButton;
      
      private var _freeUpTxt:FilterFrameText;
      
      private var _curSkillCell:HorseSkillCell;
      
      private var _upCurSkillCell:HorseSkillCell;
      
      private var _upNextSkillCell:HorseSkillCell;
      
      private var _itemCell:HorseFrameRightBottomItemCell;
      
      private var _index:int;
      
      private var _skillExp:HorseSkillExpVo;
      
      private var _dataList:Vector.<HorseSkillGetVo>;
      
      private var _lastUpClickTime:int = 0;
      
      private var _maxCount:int;
      
      private var _itemCount:int;
      
      protected var _toLinkTxt:FilterFrameText;
      
      public function HorseSkillUpFrame(){super();}
      
      private function initView() : void{}
      
      public function show(param1:int, param2:HorseSkillExpVo, param3:Vector.<HorseSkillGetVo>) : void{}
      
      private function refreshView(param1:Boolean = true) : void{}
      
      private function calMaxCountUpAndItem() : void{}
      
      private function initEvent() : void{}
      
      private function refreshFreeTipTxt(param1:Event = null) : void{}
      
      private function itemUpdateHandler(param1:BagEvent) : void{}
      
      private function upSkillSucHandler(param1:Event) : void{}
      
      private function countTxtChangeHandler(param1:Event) : void{}
      
      private function maxClickHandler(param1:MouseEvent) : void{}
      
      private function upClickHandler(param1:MouseEvent) : void{}
      
      private function buyConfirm(param1:FrameEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __toLinkTxtHandler(param1:TextEvent) : void{}
      
      override public function dispose() : void{}
   }
}
