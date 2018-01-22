package church.vo
{
   public class FatherBallConfigVO
   {
       
      
      private var _isMask:String;
      
      private var _rowNumber:int;
      
      private var _rowWitdh:Number;
      
      private var _rowHeight:Number;
      
      private var _frameStep:Number;
      
      private var _sleepSecond:int;
      
      public function FatherBallConfigVO()
      {
         super();
      }
      
      public function get isMask() : String
      {
         return _isMask;
      }
      
      public function set isMask(param1:String) : void
      {
         _isMask = param1;
      }
      
      public function get sleepSecond() : int
      {
         return _sleepSecond;
      }
      
      public function set sleepSecond(param1:int) : void
      {
         _sleepSecond = param1;
      }
      
      public function get frameStep() : Number
      {
         return _frameStep;
      }
      
      public function set frameStep(param1:Number) : void
      {
         _frameStep = param1;
      }
      
      public function get rowHeight() : Number
      {
         return _rowHeight;
      }
      
      public function set rowHeight(param1:Number) : void
      {
         _rowHeight = param1;
      }
      
      public function get rowWitdh() : Number
      {
         return _rowWitdh;
      }
      
      public function set rowWitdh(param1:Number) : void
      {
         _rowWitdh = param1;
      }
      
      public function get rowNumber() : int
      {
         return _rowNumber;
      }
      
      public function set rowNumber(param1:int) : void
      {
         _rowNumber = param1;
      }
   }
}
