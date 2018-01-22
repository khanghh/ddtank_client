package treasureRoom.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TreasureRoomViewUI extends View
   {
       
      
      public var oneTreasureBtn:Button = null;
      
      public var tenTreasureBtn:Button = null;
      
      public var label13:Label = null;
      
      public var countdownText:Label = null;
      
      public var feeText1:Label = null;
      
      public var feeText2:Label = null;
      
      public var markBtn:Button = null;
      
      public function TreasureRoomViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TreasureRoomView.xml");
      }
   }
}
