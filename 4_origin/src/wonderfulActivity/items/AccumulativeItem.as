package wonderfulActivity.items
{
   import com.gskinner.geom.ColorMatrix;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   
   public class AccumulativeItem extends Component implements Disposeable
   {
       
      
      private var _box:MovieClip;
      
      private var _numberBG:Bitmap;
      
      private var _number:FilterFrameText;
      
      private var _progressPoint:Bitmap;
      
      private var _questionMark:FilterFrameText;
      
      private var glintFilter:GlowFilter;
      
      private var lightFilter:ColorMatrixFilter;
      
      private var grayFilters:Array;
      
      public var index:int;
      
      private var tempfilters:Array;
      
      private var glintFlag:Boolean = true;
      
      public function AccumulativeItem()
      {
         tempfilters = [];
         super();
         initFilter();
      }
      
      private function initFilter() : void
      {
         tempfilters = [];
         grayFilters = ComponentFactory.Instance.creatFilters("grayFilter");
         var _loc1_:ColorMatrix = new ColorMatrix();
         lightFilter = new ColorMatrixFilter();
         _loc1_.adjustColor(50,4,4,2);
         lightFilter.matrix = _loc1_;
      }
      
      public function initView(param1:int) : void
      {
         this.index = param1;
         _numberBG = ComponentFactory.Instance.creat("wonderful.accumulative.numberBG");
         addChild(_numberBG);
         _questionMark = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.questionMark");
         _questionMark.text = "?";
         addChild(_questionMark);
         _number = ComponentFactory.Instance.creatComponentByStylename("wonderful.accumulative.number");
         _number.visible = false;
         addChild(_number);
         _box = ComponentFactory.Instance.creat("wonderful.accumulative.box");
         PositionUtils.setPos(_box,"wonderful.Accumulative.boxPos");
         _box.gotoAndStop(param1);
         _progressPoint = ComponentFactory.Instance.creat("wonderful.accumulative.progress1");
         _progressPoint.visible = false;
         addChild(_progressPoint);
         addChild(_box);
      }
      
      public function lightProgressPoint() : void
      {
         _progressPoint.visible = true;
      }
      
      public function setNumber(param1:int) : void
      {
         _questionMark.visible = false;
         _number.visible = true;
         var _loc2_:int = 0;
         if(param1 >= 100000)
         {
            _loc2_ = Math.floor(param1 / 10000);
            _number.text = _loc2_.toString() + "w";
         }
         else
         {
            _number.text = param1.toString();
         }
      }
      
      public function turnGray(param1:Boolean) : void
      {
         glint(false);
         var _loc2_:int = tempfilters.indexOf(lightFilter);
         if(_loc2_ >= 0)
         {
            tempfilters = [lightFilter];
         }
         else
         {
            tempfilters = [];
         }
         if(param1)
         {
            tempfilters = tempfilters.concat(grayFilters);
         }
         _box.filters = tempfilters;
      }
      
      public function turnLight(param1:Boolean) : void
      {
         var _loc2_:int = tempfilters.indexOf(lightFilter);
         if(param1)
         {
            if(_loc2_ == -1)
            {
               tempfilters.push(lightFilter);
            }
         }
         else if(_loc2_ >= 0)
         {
            tempfilters.splice(_loc2_,1);
         }
         if(glintFilter)
         {
            _box.filters = tempfilters.concat(glintFilter);
         }
         else
         {
            _box.filters = tempfilters;
         }
      }
      
      public function glint(param1:Boolean) : void
      {
         if(param1)
         {
            addEventListener("enterFrame",__enterFrame);
            glintFilter = new GlowFilter(16768512,1,10,10,2.7,3);
            _box.filters = tempfilters.concat(glintFilter);
         }
         else
         {
            if(hasEventListener("enterFrame"))
            {
               removeEventListener("enterFrame",__enterFrame);
            }
            _box.filters = tempfilters;
            glintFilter = null;
         }
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(glintFlag)
         {
            glintFilter.blurX = glintFilter.blurX - 0.17;
            glintFilter.blurY = glintFilter.blurY - 0.17;
            glintFilter.strength = glintFilter.strength - 0.1;
            if(glintFilter.blurX < 8)
            {
               glintFlag = false;
            }
         }
         else
         {
            glintFilter.blurX = glintFilter.blurX + 0.17;
            glintFilter.blurY = glintFilter.blurY + 0.17;
            glintFilter.strength = glintFilter.strength + 0.1;
            if(glintFilter.blurX > 10)
            {
               glintFlag = true;
            }
         }
         _box.filters = tempfilters.concat(glintFilter);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_number)
         {
            ObjectUtils.disposeObject(_number);
         }
         _number = null;
         if(_numberBG)
         {
            ObjectUtils.disposeObject(_numberBG);
         }
         _numberBG = null;
         if(_box)
         {
            ObjectUtils.disposeObject(_box);
         }
         _box = null;
         super.dispose();
      }
      
      public function get box() : MovieClip
      {
         return _box;
      }
   }
}
