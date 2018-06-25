package dragonBones.objects{   public final class AnimationData extends Timeline   {                   public var name:String;            public var frameRate:uint;            public var fadeTime:Number;            public var playTimes:int;            public var tweenEasing:Number;            public var autoTween:Boolean;            public var lastFrameDuration:int;            public var hideTimelineNameMap:Vector.<String>;            private var _timelineList:Vector.<TransformTimeline>;            private var _slotTimelineList:Vector.<SlotTimeline>;            public function AnimationData() { super(); }
            public function get timelineList() : Vector.<TransformTimeline> { return null; }
            public function get slotTimelineList() : Vector.<SlotTimeline> { return null; }
            override public function dispose() : void { }
            public function getTimeline(timelineName:String) : TransformTimeline { return null; }
            public function addTimeline(timeline:TransformTimeline) : void { }
            public function getSlotTimeline(timelineName:String) : SlotTimeline { return null; }
            public function addSlotTimeline(timeline:SlotTimeline) : void { }
   }}