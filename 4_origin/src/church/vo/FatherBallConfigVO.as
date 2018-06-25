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
      
      public function set isMask(value:String) : void
      {
         _isMask = value;
      }
      
      public function get sleepSecond() : int
      {
         return _sleepSecond;
      }
      
      public function set sleepSecond(value:int) : void
      {
         _sleepSecond = value;
      }
      
      public function get frameStep() : Number
      {
         return _frameStep;
      }
      
      public function set frameStep(value:Number) : void
      {
         _frameStep = value;
      }
      
      public function get rowHeight() : Number
      {
         return _rowHeight;
      }
      
      public function set rowHeight(value:Number) : void
      {
         _rowHeight = value;
      }
      
      public function get rowWitdh() : Number
      {
         return _rowWitdh;
      }
      
      public function set rowWitdh(value:Number) : void
      {
         _rowWitdh = value;
      }
      
      public function get rowNumber() : int
      {
         return _rowNumber;
      }
      
      public function set rowNumber(value:int) : void
      {
         _rowNumber = value;
      }
   }
}
