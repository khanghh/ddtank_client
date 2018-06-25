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
      
      public function set imageStyle(stylename:String) : void
      {
         _stylename = stylename;
      }
      
      public function set countWidth(value:int) : void
      {
         _countWidth = value;
      }
      
      public function set space(value:int) : void
      {
         _space = value;
      }
      
      public function set count(value:int) : void
      {
         if(_count == value.toString())
         {
            return;
         }
         _count = value.toString();
         updateView();
      }
      
      public function set countStr(value:String) : void
      {
         if(_count == value)
         {
            return;
         }
         _count = value;
         updateView();
      }
      
      public function get count() : int
      {
         return int(_count);
      }
      
      private function updateView() : void
      {
         var i:int = 0;
         var index:int = 0;
         var len:int = _count.length;
         var _countArr:Array = _count.split("");
         while(len > _countList.length)
         {
            _countList.unshift(createCountImage(10));
         }
         while(len < _countList.length)
         {
            ObjectUtils.disposeObject(_countList.shift());
         }
         var countX:int = 0;
         if(_countWidth > 0)
         {
            countX = (_countWidth - _countList[0].width * len) / 2;
         }
         i = 0;
         while(i < len)
         {
            _countList[i].x = countX;
            index = int(_countArr[i]) == 0?10:int(_countArr[i]);
            _countList[i].setFrame(index);
            countX = countX + (_countList[i].width + _space);
            i++;
         }
         width = countX;
      }
      
      private function createCountImage(frame:int = 0) : ScaleFrameImage
      {
         var num:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename(_stylename);
         num.setFrame(frame);
         addChild(num);
         return num;
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
