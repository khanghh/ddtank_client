package floatParade.views
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
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import floatParade.FloatParadeManager;
   import floatParade.data.FloatParadeCarInfo;
   
   public class FloatParadeFrameItemCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _awardBmp:Bitmap;
      
      private var _currentBoat:Bitmap;
      
      private var _awardInfoTxt1:FilterFrameText;
      
      private var _awardInfoTxt2:FilterFrameText;
      
      private var _defaultTxt:FilterFrameText;
      
      private var _dressUpBtn:TextButton;
      
      private var _index:int;
      
      private var _info:FloatParadeCarInfo;
      
      public function FloatParadeFrameItemCell(param1:int, param2:FloatParadeCarInfo){super();}
      
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
