package dragonBones.objects
{
   public final class AnimationData extends Timeline
   {
       
      
      public var name:String;
      
      public var frameRate:uint;
      
      public var fadeTime:Number;
      
      public var playTimes:int;
      
      public var tweenEasing:Number;
      
      public var autoTween:Boolean;
      
      public var lastFrameDuration:int;
      
      public var hideTimelineNameMap:Vector.<String>;
      
      private var _timelineList:Vector.<TransformTimeline>;
      
      private var _slotTimelineList:Vector.<SlotTimeline>;
      
      public function AnimationData()
      {
         super();
         fadeTime = 0;
         playTimes = 0;
         autoTween = true;
         tweenEasing = NaN;
         hideTimelineNameMap = new Vector.<String>();
         hideTimelineNameMap.fixed = true;
         _timelineList = new Vector.<TransformTimeline>();
         _timelineList.fixed = true;
         _slotTimelineList = new Vector.<SlotTimeline>();
         _slotTimelineList.fixed = true;
      }
      
      public function get timelineList() : Vector.<TransformTimeline>
      {
         return _timelineList;
      }
      
      public function get slotTimelineList() : Vector.<SlotTimeline>
      {
         return _slotTimelineList;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         hideTimelineNameMap.fixed = false;
         hideTimelineNameMap.length = 0;
         hideTimelineNameMap = null;
         _timelineList.fixed = false;
         var _loc4_:int = 0;
         var _loc3_:* = _timelineList;
         for each(var _loc2_ in _timelineList)
         {
            _loc2_.dispose();
         }
         _timelineList.fixed = false;
         _timelineList.length = 0;
         _timelineList = null;
         _slotTimelineList.fixed = false;
         var _loc6_:int = 0;
         var _loc5_:* = _slotTimelineList;
         for each(var _loc1_ in _slotTimelineList)
         {
            _loc1_.dispose();
         }
         _slotTimelineList.fixed = false;
         _slotTimelineList.length = 0;
         _slotTimelineList = null;
      }
      
      public function getTimeline(param1:String) : TransformTimeline
      {
         var _loc2_:int = _timelineList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_timelineList[_loc2_].name == param1)
            {
               return _timelineList[_loc2_];
            }
         }
         return null;
      }
      
      public function addTimeline(param1:TransformTimeline) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_timelineList.indexOf(param1) < 0)
         {
            _timelineList.fixed = false;
            _timelineList[_timelineList.length] = param1;
            _timelineList.fixed = true;
         }
      }
      
      public function getSlotTimeline(param1:String) : SlotTimeline
      {
         var _loc2_:int = _slotTimelineList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_slotTimelineList[_loc2_].name == param1)
            {
               return _slotTimelineList[_loc2_];
            }
         }
         return null;
      }
      
      public function addSlotTimeline(param1:SlotTimeline) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_slotTimelineList.indexOf(param1) < 0)
         {
            _slotTimelineList.fixed = false;
            _slotTimelineList[_slotTimelineList.length] = param1;
            _slotTimelineList.fixed = true;
         }
      }
   }
}
