package ddt.view.buff.buffButton
{
   import ddt.data.BuffInfo;
   import ddt.view.tips.BuffTipInfo;
   import flash.events.MouseEvent;
   
   public class FreeBuffButton extends BuffButton
   {
       
      
      public function FreeBuffButton()
      {
         super("asset.core.freeAsset");
         info = new BuffInfo(15);
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
      }
      
      override public function set info(param1:BuffInfo) : void
      {
      }
      
      override public function get tipData() : Object
      {
         if(_tipData == null)
         {
            _tipData = new BuffTipInfo();
            _tipData.isActive = true;
            _tipData.isFree = true;
         }
         return _tipData;
      }
   }
}
