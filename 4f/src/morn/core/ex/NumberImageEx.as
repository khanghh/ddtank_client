package morn.core.ex
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import morn.core.components.Clip;
   import morn.core.components.Component;
   
   public class NumberImageEx extends Component
   {
      
      public static const LEFT:String = "left";
      
      public static const CENTER:String = "center";
      
      public static const RIGHT:String = "right";
       
      
      private var _countList:Vector.<Clip>;
      
      private var _countSprite:Sprite;
      
      private var _count:int;
      
      private var _skin:String;
      
      private var _space:int;
      
      private var _clipsUrl:String;
      
      private var _clipsUrlSimple:String;
      
      private var _align:String;
      
      private var _skinType:String;
      
      public function NumberImageEx(){super();}
      
      override protected function initialize() : void{}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      public function set space(param1:int) : void{}
      
      public function get space() : int{return 0;}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function set clipsUrl(param1:String) : void{}
      
      public function set clipsUrlSimple(param1:String) : void{}
      
      public function set align(param1:String) : void{}
      
      private function updateSkin(param1:String, param2:int) : void{}
      
      private function updateSize() : void{}
      
      private function createCountClip(param1:int) : Clip{return null;}
      
      override public function dispose() : void{}
   }
}
