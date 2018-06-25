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
         for each(var timeline in _timelineList)
         {
            timeline.dispose();
         }
         _timelineList.fixed = false;
         _timelineList.length = 0;
         _timelineList = null;
         _slotTimelineList.fixed = false;
         var _loc6_:int = 0;
         var _loc5_:* = _slotTimelineList;
         for each(var slotTimeline in _slotTimelineList)
         {
            slotTimeline.dispose();
         }
         _slotTimelineList.fixed = false;
         _slotTimelineList.length = 0;
         _slotTimelineList = null;
      }
      
      public function getTimeline(timelineName:String) : TransformTimeline
      {
         var i:int = _timelineList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_timelineList[i].name == timelineName)
            {
               return _timelineList[i];
            }
         }
         return null;
      }
      
      public function addTimeline(timeline:TransformTimeline) : void
      {
         if(!timeline)
         {
            throw new ArgumentError();
         }
         if(_timelineList.indexOf(timeline) < 0)
         {
            _timelineList.fixed = false;
            _timelineList[_timelineList.length] = timeline;
            _timelineList.fixed = true;
         }
      }
      
      public function getSlotTimeline(timelineName:String) : SlotTimeline
      {
         var i:int = _slotTimelineList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_slotTimelineList[i].name == timelineName)
            {
               return _slotTimelineList[i];
            }
         }
         return null;
      }
      
      public function addSlotTimeline(timeline:SlotTimeline) : void
      {
         if(!timeline)
         {
            throw new ArgumentError();
         }
         if(_slotTimelineList.indexOf(timeline) < 0)
         {
            _slotTimelineList.fixed = false;
            _slotTimelineList[_slotTimelineList.length] = timeline;
            _slotTimelineList.fixed = true;
         }
      }
   }
}
