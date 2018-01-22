package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import kingBless.KingBlessManager;
   
   public class KingBlessIcon extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _isOpen:Boolean;
      
      private var _isSelf:Boolean;
      
      public function KingBlessIcon(param1:int)
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.playerInfo.kingBless" + param1);
         addChild(_icon);
         this.buttonMode = true;
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function __openKingBlessFrameHandlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         KingBlessManager.instance.show();
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
         addEventListener("click",__openKingBlessFrameHandlder);
         KingBlessManager.instance.addEventListener("update_main_event",__refreshBtnState);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__openKingBlessFrameHandlder);
         KingBlessManager.instance.removeEventListener("update_main_event",__refreshBtnState);
      }
      
      private function __refreshBtnState(param1:Event) : void
      {
         var _loc2_:int = KingBlessManager.instance.openType;
         if(_loc2_ > 0)
         {
            _isOpen = true;
            updateIcon();
         }
      }
      
      public function setInfo(param1:Boolean, param2:Boolean) : void
      {
         _isOpen = param1;
         _isSelf = param2;
         updateIcon();
         if(_isSelf)
         {
            addEvent();
         }
         else
         {
            removeEvent();
         }
      }
      
      public function get tipData() : Object
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!_isOpen)
         {
            _loc2_ = {};
            _loc2_.isOpen = false;
            _loc2_.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.noOpenTipTxt");
            return _loc2_;
         }
         if(_isSelf)
         {
            return KingBlessManager.instance.getRemainTimeTxt();
         }
         _loc1_ = {};
         _loc1_.isOpen = true;
         _loc1_.isSelf = false;
         _loc1_.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.openTipTxt");
         return _loc1_;
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
