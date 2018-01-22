package dragonBones.fast
{
   import dragonBones.events.FrameEvent;
   import dragonBones.fast.animation.FastAnimationState;
   import dragonBones.fast.animation.FastBoneTimelineState;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.Frame;
   
   public class FastBone extends FastDBObject
   {
       
      
      public var slotList:Vector.<FastSlot>;
      
      public var boneList:Vector.<FastBone>;
      
      var _timelineState:FastBoneTimelineState;
      
      var _needUpdate:int;
      
      public function FastBone(){super();}
      
      public static function initWithBoneData(param1:BoneData) : FastBone{return null;}
      
      public function getBones(param1:Boolean = true) : Vector.<FastBone>{return null;}
      
      public function getSlots(param1:Boolean = true) : Vector.<FastSlot>{return null;}
      
      override public function dispose() : void{}
      
      public function invalidUpdate() : void{}
      
      override protected function calculateRelativeParentTransform() : void{}
      
      override function updateByCache() : void{}
      
      function update(param1:Boolean = false) : void{}
      
      function arriveAtFrame(param1:Frame, param2:FastAnimationState) : void{}
      
      public function get childArmature() : Object{return null;}
      
      public function get display() : Object{return null;}
      
      public function set display(param1:Object) : void{}
      
      override public function set visible(param1:Boolean) : void{}
      
      public function get slot() : FastSlot{return null;}
   }
}
