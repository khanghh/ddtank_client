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
      
      protected function __openDeedFrameHandlder(param1:MouseEvent) : void
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
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.deedFrame.openPromptTxt",payMoney);
         if(_isOpen)
         {
            _loc2_ = LanguageMgr.GetTranslation("ddt.deedFrame.openPromptTxt2",DeedManager.instance.deedTimeStr.toLowerCase(),payMoney);
         }
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,1);
         _loc1_.moveEnable = false;
         _loc1_.addEventListener("response",__confirm);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = PlayerManager.Instance.Self.ID;
            _loc4_ = "";
            if(BuriedManager.Instance.checkMoney(_loc3_.isBand,payMoney))
            {
               return;
            }
            SocketManager.Instance.out.sendOpenDeed(10,_loc2_,_loc4_,_loc3_.isBand);
            _loc3_.dispose();
         }
         _loc3_.removeEventListener("response",__confirm);
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
      
      private function __refreshBtnState(param1:Event) : void
      {
         _isOpen = DeedManager.instance.isOpen;
         updateIcon();
      }
      
      public function setInfo(param1:Boolean, param2:Boolean) : void
      {
         _isOpen = param1;
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
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
