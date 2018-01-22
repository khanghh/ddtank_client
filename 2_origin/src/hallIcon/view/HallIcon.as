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
      
      public function HallIcon(param1:String, param2:HallIconInfo)
      {
         super();
         _iconString = param1;
         iconInfo = param2;
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
      
      public function updateIcon(param1:HallIconInfo) : void
      {
         iconInfo = param1;
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
      
      private function setTimeTxt(param1:String) : void
      {
         if(param1 == "" || iconInfo.timeShow)
         {
            _icon.alpha = 1;
            buttonCursorMode(true);
         }
         else
         {
            _icon.alpha = 0.6;
            buttonCursorMode(false);
         }
         _timeTxt.text = param1;
      }
      
      private function setGlow(param1:Boolean) : void
      {
         if(param1)
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
      
      private function setFightState(param1:Boolean) : void
      {
         if(param1)
         {
            _icon.alpha = 0.6;
         }
         else
         {
            _icon.alpha = 1;
         }
      }
      
      private function setNumShow(param1:int) : void
      {
         _iconTxt.text = param1.toString();
         if(param1 > -1)
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
      
      private function buttonCursorMode(param1:Boolean) : void
      {
         this.buttonMode = param1;
         this.mouseEnabled = param1;
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
