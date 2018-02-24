package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   
   public class NumberImage extends Component
   {
       
      
      private var _countList:Vector.<ScaleFrameImage>;
      
      private var _count:String;
      
      private var _stylename:String;
      
      private var _countWidth:int;
      
      private var _space:int;
      
      public function NumberImage(){super();}
      
      public function set imageStyle(param1:String) : void{}
      
      public function set countWidth(param1:int) : void{}
      
      public function set space(param1:int) : void{}
      
      public function set count(param1:int) : void{}
      
      public function set countStr(param1:String) : void{}
      
      public function get count() : int{return 0;}
      
      private function updateView() : void{}
      
      private function createCountImage(param1:int = 0) : ScaleFrameImage{return null;}
      
      override public function dispose() : void{}
   }
}
