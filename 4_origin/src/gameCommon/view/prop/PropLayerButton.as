package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PropLayerButton extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _background:ScaleFrameImage;
      
      private var _shine:Bitmap;
      
      private var _tipData:String;
      
      private var _mode:int;
      
      private var _mouseOver:Boolean = false;
      
      private var _tipDirction:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      public function PropLayerButton(param1:int)
      {
         super();
         _mode = param1;
         configUI();
         addEvent();
         buttonMode = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseOut(param1:MouseEvent) : void
      {
         if(_shine && _shine.parent)
         {
            _shine.parent.removeChild(_shine);
         }
         _mouseOver = false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return true;
      }
      
      private function __mouseOver(param1:MouseEvent) : void
      {
         if(_shine)
         {
            addChild(_shine);
         }
         _mouseOver = true;
      }
      
      private function configUI() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("asset.game.prop.ModeBack");
         addChild(_background);
         tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.proplayer" + _mode);
         DisplayUtils.setFrame(_background,_mode);
         _shine = ComponentFactory.Instance.creatBitmap("asset.game.prop.ModeShine");
         ShowTipManager.Instance.addTip(this);
         var _loc1_:int = -3;
         _shine.y = _loc1_;
         _shine.x = _loc1_;
      }
      
      public function setMode(param1:int) : void
      {
         tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.proplayer" + param1);
         DisplayUtils.setFrame(_background,param1);
         if(_mouseOver)
         {
            ShowTipManager.Instance.showTip(this);
         }
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEvent();
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
            _background = null;
         }
         if(_shine)
         {
            ObjectUtils.disposeObject(_shine);
            _shine = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1.toString();
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirction;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirction = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
