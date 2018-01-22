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
      
      public function NumberImage()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         _countList = new Vector.<ScaleFrameImage>();
      }
      
      public function set imageStyle(param1:String) : void
      {
         _stylename = param1;
      }
      
      public function set countWidth(param1:int) : void
      {
         _countWidth = param1;
      }
      
      public function set space(param1:int) : void
      {
         _space = param1;
      }
      
      public function set count(param1:int) : void
      {
         if(_count == param1.toString())
         {
            return;
         }
         _count = param1.toString();
         updateView();
      }
      
      public function set countStr(param1:String) : void
      {
         if(_count == param1)
         {
            return;
         }
         _count = param1;
         updateView();
      }
      
      public function get count() : int
      {
         return int(_count);
      }
      
      private function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = _count.length;
         var _loc3_:Array = _count.split("");
         while(_loc4_ > _countList.length)
         {
            _countList.unshift(createCountImage(10));
         }
         while(_loc4_ < _countList.length)
         {
            ObjectUtils.disposeObject(_countList.shift());
         }
         var _loc1_:int = 0;
         if(_countWidth > 0)
         {
            _loc1_ = (_countWidth - _countList[0].width * _loc4_) / 2;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _countList[_loc5_].x = _loc1_;
            _loc2_ = int(_loc3_[_loc5_]) == 0?10:int(_loc3_[_loc5_]);
            _countList[_loc5_].setFrame(_loc2_);
            _loc1_ = _loc1_ + (_countList[_loc5_].width + _space);
            _loc5_++;
         }
         width = _loc1_;
      }
      
      private function createCountImage(param1:int = 0) : ScaleFrameImage
      {
         var _loc2_:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename(_stylename);
         _loc2_.setFrame(param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         while(_countList.length)
         {
            ObjectUtils.disposeObject(_countList.shift());
         }
         _countList = null;
      }
   }
}
