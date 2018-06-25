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
      
      public function TimesThumbnailView($controller:TimesController)
      {
         super();
         _controller = $controller;
         init();
      }
      
      private function init() : void
      {
         var pointSum:int = 0;
         var i:int = 0;
         var k:int = 0;
         var j:int = 0;
         var info:* = null;
         var point:* = null;
         _pointGroup = new SelectedButtonGroup();
         _pointArr = new Vector.<TimesThumbnailPoint>();
         var lenArr:Vector.<int> = new Vector.<int>();
         var idx:int = 0;
         var infos:Array = _controller.model.contentInfos;
         for(i = 0; i < infos.length; )
         {
            lenArr.push(infos[i].length);
            pointSum = pointSum + lenArr[i];
            i++;
         }
         if(pointSum != 0)
         {
            _spacing = 360 / (pointSum - 1);
         }
         for(k = 0; k < infos.length; )
         {
            for(j = 0; j < lenArr[k]; )
            {
               info = new TimesPicInfo();
               info.targetCategory = k;
               info.targetPage = j;
               point = new TimesThumbnailPoint(info);
               point.tipStyle = "times.view.TimesThumbnailPointTip";
               point.tipDirctions = "0";
               point.tipGapV = 10;
               point.tipData = {
                  "isRevertTip":idx > pointSum / 2,
                  "category":k,
                  "page":j
               };
               idx++;
               point.x = idx * _spacing;
               _pointGroup.addSelectItem(point);
               addChild(point);
               _pointArr.push(point);
               j++;
            }
            k++;
         }
         _pointGroup.selectIndex = 0;
      }
      
      public function set pointIdx(value:int) : void
      {
         if(_pointIdx == value)
         {
            return;
         }
         _pointArr[_pointIdx].pointPlay("rollOut");
         _pointIdx = value;
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
