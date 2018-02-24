package escort.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import escort.EscortControl;
   import escort.EscortManager;
   import escort.data.EscortCarInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class EscortFrameItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleTip:FilterFrameText;
      
      private var _awardInfoTxt1:FilterFrameText;
      
      private var _awardInfoTxt2:FilterFrameText;
      
      private var _awardInfoTxt3:FilterFrameText;
      
      private var _escortDefault:FilterFrameText;
      
      private var _escortBtn:TextButton;
      
      private var _index:int;
      
      private var _info:EscortCarInfo;
      
      private var _calledIcon:Bitmap;
      
      public function EscortFrameItemCell(param1:int, param2:EscortCarInfo){super();}
      
      private function initView() : void{}
      
      private function refreshView(param1:Event) : void{}
      
      private function initEvent() : void{}
      
      private function clickHandler(param1:MouseEvent) : void{}
      
      private function callConfirm(param1:FrameEvent) : void{}
      
      private function callCarReConfirm(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
