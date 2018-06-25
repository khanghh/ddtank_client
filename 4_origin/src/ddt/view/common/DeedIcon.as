package ddt.view.common
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import ddtDeed.DeedManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class DeedIcon extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _isOpen:Boolean;
      
      private var payMoney:int;
      
      public function DeedIcon()
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.playerInfo.ddtDeed");
         addChild(_icon);
         this.buttonMode = true;
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function __openDeedFrameHandlder(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!judgeOpen())
         {
            return;
         }
         openConfirmFrame();
      }
      
      private function judgeOpen() : Boolean
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         payMoney = ServerConfigManager.instance.getDeedPrices[0];
         return true;
      }
      
      private function openConfirmFrame() : void
      {
         var msg:String = LanguageMgr.GetTranslation("ddt.deedFrame.openPromptTxt",payMoney);
         if(_isOpen)
         {
            msg = LanguageMgr.GetTranslation("ddt.deedFrame.openPromptTxt2",DeedManager.instance.deedTimeStr.toLowerCase(),payMoney);
         }
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         var id:int = 0;
         var msg:* = null;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            id = PlayerManager.Instance.Self.ID;
            msg = "";
            if(BuriedManager.Instance.checkMoney(confirmFrame.isBand,payMoney))
            {
               return;
            }
            SocketManager.Instance.out.sendOpenDeed(10,id,msg,confirmFrame.isBand);
            confirmFrame.dispose();
         }
         confirmFrame.removeEventListener("response",__confirm);
      }
      
      private function updateIcon() : void
      {
         if(!_isOpen)
         {
            _icon.filters = [new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0])];
         }
         else
         {
            _icon.filters = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.removeTip(this);
         removeChild(_icon);
         _icon.bitmapData.dispose();
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__openDeedFrameHandlder);
         DeedManager.instance.addEventListener("update_main_event",__refreshBtnState);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__openDeedFrameHandlder);
         DeedManager.instance.removeEventListener("update_main_event",__refreshBtnState);
      }
      
      private function __refreshBtnState(event:Event) : void
      {
         _isOpen = DeedManager.instance.isOpen;
         updateIcon();
      }
      
      public function setInfo(isOpen:Boolean, isSelf:Boolean) : void
      {
         _isOpen = isOpen;
         updateIcon();
         addEvent();
      }
      
      public function get tipData() : Object
      {
         return DeedManager.instance.getRemainTimeTxt();
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
