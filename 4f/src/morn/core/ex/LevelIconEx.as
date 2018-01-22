package morn.core.ex
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import morn.core.components.Component;
   import morn.core.components.FrameClip;
   import morn.core.components.Image;
   
   public class LevelIconEx extends Component
   {
      
      private static const BIG:String = "big";
      
      private static const SMALL:String = "small";
      
      private static const MAX:int = 70;
      
      private static const MIN:int = 1;
      
      private static const LEVEL_EFFECT_CLASSPATH:String = "asset.LevelIcon.LevelEffect_";
      
      private static const LEVEL_ICON_CLASSPATH:String = "asset.LevelIcon.Level_";
       
      
      private var _level:int;
      
      private var _size:String;
      
      private var _levelTipInfo:Object;
      
      private var _isBitmap:Boolean;
      
      private var _bmContainer:Sprite;
      
      private var _levelImage:Image;
      
      private var _levelEffect:FrameClip;
      
      public function LevelIconEx(){super();}
      
      public function get level() : int{return 0;}
      
      public function set level(param1:int) : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      public function setInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = true, param9:Boolean = true, param10:int = 1) : void{}
      
      private function updateView() : void{}
      
      private function addCurrentLevelBitmap() : void{}
      
      private function addCurrentLevelEffect() : void{}
      
      private function getValueInRange(param1:Number, param2:Number, param3:Number) : Number{return 0;}
      
      private function isInRange(param1:Number, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = true) : Boolean{return false;}
      
      override public function get tipData() : Object{return null;}
      
      public function set size(param1:String) : void{}
      
      public function get size() : String{return null;}
      
      private function updateSize() : void{}
      
      override public function dispose() : void{}
   }
}
