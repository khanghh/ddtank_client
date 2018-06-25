package hallIcon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import hallIcon.info.HallIconInfo;
   
   public class HallIcon extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const WONDERFULPLAY:int = 1;
      
      public static const ACTIVITY:int = 2;
       
      
      private var _timeTxt:FilterFrameText;
      
      private var _glowMovie:MovieClip;
      
      private var _icon:DisplayObject;
      
      private var _iconString:String;
      
      private var _iconNumBg:Bitmap;
      
      private var _iconTxt:FilterFrameText;
      
      private var _tipStyle:String;
      
      private var _tipDirctions:String;
      
      private var _tipData:Object;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      public var iconInfo:HallIconInfo;
      
      public function HallIcon($iconString:String, $iconInfo:HallIconInfo)
      {
         super();
         _iconString = $iconString;
         iconInfo = $iconInfo;
         initView();
         buttonCursorMode(true);
         this.mouseChildren = false;
      }
      
      public function initView() : void
      {
         _icon = ComponentFactory.Instance.creat(_iconString);
         addChild(_icon);
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("hallicon.IconTimeTxt");
         addChild(_timeTxt);
         _glowMovie = ClassUtils.CreatInstance("assets.hallIcon.iconGlow" + iconInfo.halltype);
         _glowMovie.stop();
         _glowMovie.visible = false;
         PositionUtils.setPos(_glowMovie,"hallIcon.iconGlowPos" + iconInfo.halltype);
         addChild(_glowMovie);
         _iconNumBg = ComponentFactory.Instance.creatBitmap("assets.hallIcon.numIconBg");
         _iconNumBg.visible = false;
         addChild(_iconNumBg);
         _iconTxt = ComponentFactory.Instance.creatComponentByStylename("assets.hallIcon.numTxt");
         _iconTxt.visible = false;
         addChild(_iconTxt);
      }
      
      public function updateIcon($iconInfo:HallIconInfo) : void
      {
         iconInfo = $iconInfo;
         if(iconInfo.timemsg == null)
         {
            iconInfo.timemsg = "";
         }
         setTimeTxt(iconInfo.timemsg);
         if(iconInfo.timemsg == "" || iconInfo.timeShow)
         {
            setFightState(iconInfo.fightover);
         }
         if(iconInfo.timemsg == "" && !iconInfo.fightover || iconInfo.timeShow)
         {
            setGlow(true);
         }
         else
         {
            setGlow(false);
         }
         setNumShow(iconInfo.num);
      }
      
      private function setTimeTxt(str:String) : void
      {
         if(str == "" || iconInfo.timeShow)
         {
            _icon.alpha = 1;
            buttonCursorMode(true);
         }
         else
         {
            _icon.alpha = 0.6;
            buttonCursorMode(false);
         }
         _timeTxt.text = str;
      }
      
      private function setGlow($isglow:Boolean) : void
      {
         if($isglow)
         {
            _glowMovie.play();
            _glowMovie.visible = true;
         }
         else if(_glowMovie)
         {
            _glowMovie.stop();
            _glowMovie.visible = false;
         }
      }
      
      private function setFightState($fightover:Boolean) : void
      {
         if($fightover)
         {
            _icon.alpha = 0.6;
         }
         else
         {
            _icon.alpha = 1;
         }
      }
      
      private function setNumShow(num:int) : void
      {
         _iconTxt.text = num.toString();
         if(num > -1)
         {
            _iconNumBg.visible = true;
            _iconTxt.visible = true;
         }
         else
         {
            _iconNumBg.visible = false;
            _iconTxt.visible = false;
         }
      }
      
      private function buttonCursorMode($isBool:Boolean) : void
      {
         this.buttonMode = $isBool;
         this.mouseEnabled = $isBool;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
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
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         if(_glowMovie)
         {
            _glowMovie.stop();
            ObjectUtils.disposeObject(_glowMovie);
            _glowMovie = null;
         }
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
