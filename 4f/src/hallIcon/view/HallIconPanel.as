package hallIcon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   
   public class HallIconPanel extends Sprite implements Disposeable
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const BOTTOM:String = "bottom";
       
      
      private var _mainIcon:DisplayObject;
      
      private var _mainIconString:String;
      
      private var _hotNumBg:Bitmap;
      
      private var _hotNum:FilterFrameText;
      
      private var _iconArray:Array;
      
      private var _iconBox:HallIconBox;
      
      private var direction:String;
      
      private var vNum:int;
      
      private var hNum:int;
      
      private var WHSize:Array;
      
      private var tweenLiteMax:TweenLite;
      
      private var tweenLiteSmall:TweenLite;
      
      private var isExpand:Boolean;
      
      public function HallIconPanel(param1:String, param2:String = "left", param3:int = -1, param4:int = -1, param5:Array = null){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function addIcon(param1:DisplayObject, param2:String, param3:int = 0, param4:Boolean = false) : DisplayObject{return null;}
      
      public function getIconByType(param1:String) : DisplayObject{return null;}
      
      public function removeIconByType(param1:String) : void{}
      
      public function arrange() : void{}
      
      private function updateIconsPos() : void{}
      
      private function updateDirectionPos() : void{}
      
      public function iconSortOn() : void{}
      
      private function sortFunctin(param1:Object, param2:Object) : Number{return 0;}
      
      public function expand(param1:Boolean) : void{}
      
      private function tweenLiteSmallCloseComplete() : void{}
      
      private function tweenLiteMaxCloseComplete() : void{}
      
      private function getIconSpriteWidth() : Number{return 0;}
      
      private function getIconSpriteHeight() : Number{return 0;}
      
      public function removeChildrens() : void{}
      
      private function __mainIconHandler(param1:MouseEvent) : void{}
      
      private function updateHotNum() : void{}
      
      public function get mainIcon() : DisplayObject{return null;}
      
      public function get count() : int{return 0;}
      
      override public function get height() : Number{return 0;}
      
      override public function get width() : Number{return 0;}
      
      private function killTweenLiteMax() : void{}
      
      private function killTweenLiteSmall() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
