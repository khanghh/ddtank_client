package times.view
{
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import times.TimesController;
   import times.data.TimesPicInfo;
   
   public class TimesThumbnailView extends Sprite implements Disposeable
   {
       
      
      private var _controller:TimesController;
      
      private var _pointArr:Vector.<TimesThumbnailPoint>;
      
      private var _spacing:int;
      
      private var _pointGroup:SelectedButtonGroup;
      
      private var _pointIdx:int;
      
      public function TimesThumbnailView(param1:TimesController)
      {
         super();
         _controller = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc1_:* = null;
         _pointGroup = new SelectedButtonGroup();
         _pointArr = new Vector.<TimesThumbnailPoint>();
         var _loc4_:Vector.<int> = new Vector.<int>();
         var _loc3_:int = 0;
         var _loc2_:Array = _controller.model.contentInfos;
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc4_.push(_loc2_[_loc9_].length);
            _loc7_ = _loc7_ + _loc4_[_loc9_];
            _loc9_++;
         }
         if(_loc7_ != 0)
         {
            _spacing = 360 / (_loc7_ - 1);
         }
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_[_loc6_])
            {
               _loc8_ = new TimesPicInfo();
               _loc8_.targetCategory = _loc6_;
               _loc8_.targetPage = _loc5_;
               _loc1_ = new TimesThumbnailPoint(_loc8_);
               _loc1_.tipStyle = "times.view.TimesThumbnailPointTip";
               _loc1_.tipDirctions = "0";
               _loc1_.tipGapV = 10;
               _loc1_.tipData = {
                  "isRevertTip":_loc3_ > _loc7_ / 2,
                  "category":_loc6_,
                  "page":_loc5_
               };
               _loc3_++;
               _loc1_.x = _loc3_ * _spacing;
               _pointGroup.addSelectItem(_loc1_);
               addChild(_loc1_);
               _pointArr.push(_loc1_);
               _loc5_++;
            }
            _loc6_++;
         }
         _pointGroup.selectIndex = 0;
      }
      
      public function set pointIdx(param1:int) : void
      {
         if(_pointIdx == param1)
         {
            return;
         }
         _pointArr[_pointIdx].pointPlay("rollOut");
         _pointIdx = param1;
         _pointArr[_pointIdx].pointStop("selected");
         _pointGroup.selectIndex = _pointIdx;
      }
      
      public function dispose() : void
      {
         _controller = null;
         ObjectUtils.disposeObject(_pointGroup);
         _pointGroup = null;
         _pointArr = null;
         _controller = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
