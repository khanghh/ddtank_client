package times.view
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenLite;
   import com.greensock.easing.Circ;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesThumbnailPoint extends Sprite implements ISelectable, ITipedDisplay, Disposeable
   {
      
      public static const THUMBNAIL_POINT_MAIN:int = 0;
      
      public static const THUMBNAIL_POINT_CATEGORY:int = 1;
      
      public static const THUMBNAIL_POINT_NORMAL:int = 2;
       
      
      private var _controller:TimesController;
      
      private var _point:MovieClip;
      
      private var _info:TimesPicInfo;
      
      private var _type:int;
      
      private var _selected:Boolean;
      
      private var _tipData:Object;
      
      private var _tipDirections:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _lineLite:TimelineLite;
      
      public function TimesThumbnailPoint(param1:TimesPicInfo)
      {
         super();
         _info = param1;
         init();
      }
      
      private function init() : void
      {
         _controller = TimesController.Instance;
         buttonMode = true;
         _point = ComponentFactory.Instance.creat("asset.times.ThumbnailPoint");
         addEventListener("click",__pointClick);
         addEventListener("rollOver",__overEffect);
         addEventListener("rollOut",__outEffect);
         addChild(_point);
         ShowTipManager.Instance.addTip(this);
         mouseChildren = false;
      }
      
      public function pointPlay(param1:Object) : void
      {
         _point.gotoAndPlay(param1);
      }
      
      public function pointStop(param1:Object) : void
      {
         _point.gotoAndStop(param1);
      }
      
      private function __overEffect(param1:MouseEvent) : void
      {
         if(_lineLite == null)
         {
            _lineLite = new TimelineLite();
            _lineLite.append(new TweenLite(this,0.2,{
               "x":"-3",
               "y":"-3",
               "scaleX":1.5,
               "scaleY":1.5,
               "ease":Circ.easeOut
            }));
         }
         if(_selected)
         {
            return;
         }
         _lineLite.play();
         pointPlay("rollOver");
      }
      
      private function __outEffect(param1:MouseEvent) : void
      {
         if(_selected)
         {
            return;
         }
         _lineLite.reverse();
         pointPlay("rollOut");
      }
      
      private function __pointClick(param1:MouseEvent) : void
      {
         _controller.dispatchEvent(new TimesEvent("playSound"));
         if(_info)
         {
            _controller.dispatchEvent(new TimesEvent("gotoContent",_info));
         }
         else
         {
            _controller.dispatchEvent(new TimesEvent("gotoHomepage"));
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         if(_lineLite == null)
         {
            _lineLite = new TimelineLite();
            _lineLite.append(new TweenLite(this,0.2,{
               "x":"-3",
               "y":"-3",
               "scaleX":1.5,
               "scaleY":1.5,
               "ease":Circ.easeOut
            }));
         }
         _selected = param1;
         if(_selected)
         {
            _lineLite.play();
            pointStop("selected");
         }
         else
         {
            _lineLite.reverse();
            pointPlay("rollOut");
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
      
      public function get tipData() : Object
      {
         _tipData.bitmapDatas = _controller.thumbnailLoaders;
         return _tipData;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirections;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirections = param1;
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
      
      public function dispose() : void
      {
         if(_lineLite)
         {
            _lineLite.kill();
         }
         _lineLite = null;
         removeEventListener("click",__pointClick);
         removeEventListener("rollOver",__overEffect);
         removeEventListener("rollOut",__outEffect);
         ShowTipManager.Instance.removeTip(this);
         if(_point)
         {
            removeChild(_point);
            _point = null;
         }
         _info = null;
         if(_tipData && _tipData.bitmapData)
         {
            _tipData.bitmapData.dispose();
            _tipData.bitmapData = null;
         }
         _tipData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
