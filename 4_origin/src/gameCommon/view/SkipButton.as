package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SkipButton extends Sprite implements Disposeable, ITipedDisplay
   {
       
      
      private var _back:Bitmap;
      
      private var _shine:Bitmap;
      
      private var _tipData:String;
      
      private var _enabled:Boolean = true;
      
      public function SkipButton()
      {
         super();
         _back = ComponentFactory.Instance.creatBitmap("asset.game.mark.SkipBack");
         addChild(_back);
         _shine = ComponentFactory.Instance.creatBitmap("asset.game.mark.SkipShine");
         buttonMode = true;
         mouseChildren = false;
         _tipData = LanguageMgr.GetTranslation("tank.game.SelfMark.Skip");
         ShowTipManager.Instance.addTip(this);
         addEvent();
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
      
      public function set enabled(val:Boolean) : void
      {
         if(_enabled != val)
         {
            _enabled = val;
            if(_enabled)
            {
               filters = null;
            }
            else
            {
               filters = ComponentFactory.Instance.creatFilters("grayFilter");
               if(_shine.parent)
               {
                  _shine.parent.removeChild(_shine);
               }
            }
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         if(_shine.parent)
         {
            _shine.parent.removeChild(_shine);
         }
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         if(_enabled)
         {
            _shine.x = -3;
            _shine.y = -3;
            addChild(_shine);
         }
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
            _back = null;
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
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "7";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 4;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 4;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "ddt.view.tips.OneLineTip";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
   }
}
