package dragonBones.objects
{
   public class Timeline
   {
       
      
      public var duration:int;
      
      public var scale:Number;
      
      private var _frameList:Vector.<Frame>;
      
      public function Timeline()
      {
         super();
         _frameList = new Vector.<Frame>(0,true);
         duration = 0;
         scale = 1;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = _frameList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _frameList[_loc1_].dispose();
         }
         _frameList.fixed = false;
         _frameList.length = 0;
         _frameList = null;
      }
      
      public function addFrame(param1:Frame) : void
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         if(_frameList.indexOf(param1) < 0)
         {
            _frameList.fixed = false;
            _frameList[_frameList.length] = param1;
            _frameList.fixed = true;
            return;
         }
         throw new ArgumentError();
      }
      
      public function get frameList() : Vector.<Frame>
      {
         return _frameList;
      }
   }
}
