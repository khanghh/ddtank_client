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
      
      public function KingBlessIcon(id:int)
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.playerInfo.kingBless" + id);
         addChild(_icon);
         this.buttonMode = true;
         ShowTipManager.Instance.addTip(this);
      }
      
      protected function __openKingBlessFrameHandlder(event:MouseEvent) : void
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
      
      private function __refreshBtnState(event:Event) : void
      {
         var openType:int = KingBlessManager.instance.openType;
         if(openType > 0)
         {
            _isOpen = true;
            updateIcon();
         }
      }
      
      public function setInfo(isOpen:Boolean, isSelf:Boolean) : void
      {
         _isOpen = isOpen;
         _isSelf = isSelf;
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
         var obj:* = null;
         var obj2:* = null;
         if(!_isOpen)
         {
            obj = {};
            obj.isOpen = false;
            obj.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.noOpenTipTxt");
            return obj;
         }
         if(_isSelf)
         {
            return KingBlessManager.instance.getRemainTimeTxt();
         }
         obj2 = {};
         obj2.isOpen = true;
         obj2.isSelf = false;
         obj2.content = LanguageMgr.GetTranslation("ddt.kingBlessFrame.openTipTxt");
         return obj2;
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
