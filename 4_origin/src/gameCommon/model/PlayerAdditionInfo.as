package gameCommon.model
{
   public class PlayerAdditionInfo
   {
       
      
      private var _auncherExperienceAddition:Number = 1;
      
      private var _gmExperienceAdditionType:Number = 1;
      
      private var _gmOfferAddition:Number = 1;
      
      private var _auncherOfferAddition:Number = 1;
      
      private var _gmRichesAddition:Number = 1;
      
      private var _auncherRichesAddition:Number = 1;
      
      public function PlayerAdditionInfo()
      {
         super();
      }
      
      public function get AuncherExperienceAddition() : Number
      {
         return _auncherExperienceAddition;
      }
      
      public function set AuncherExperienceAddition(param1:Number) : void
      {
         _auncherExperienceAddition = param1;
      }
      
      public function get GMExperienceAdditionType() : Number
      {
         return _gmExperienceAdditionType;
      }
      
      public function set GMExperienceAdditionType(param1:Number) : void
      {
         _gmExperienceAdditionType = param1;
      }
      
      public function get GMOfferAddition() : Number
      {
         return _gmOfferAddition;
      }
      
      public function set GMOfferAddition(param1:Number) : void
      {
         _gmOfferAddition = param1;
      }
      
      public function get AuncherOfferAddition() : Number
      {
         return _auncherOfferAddition;
      }
      
      public function set AuncherOfferAddition(param1:Number) : void
      {
         _auncherOfferAddition = param1;
      }
      
      public function get GMRichesAddition() : Number
      {
         return _gmRichesAddition;
      }
      
      public function set GMRichesAddition(param1:Number) : void
      {
         _gmRichesAddition = param1;
      }
      
      public function get AuncherRichesAddition() : Number
      {
         return _auncherRichesAddition;
      }
      
      public function set AuncherRichesAddition(param1:Number) : void
      {
         _auncherRichesAddition = param1;
      }
      
      public function resetAddition() : void
      {
         _auncherExperienceAddition = 1;
         _gmExperienceAdditionType = 1;
         _gmOfferAddition = 1;
         _auncherOfferAddition = 1;
         _gmRichesAddition = 1;
         _auncherRichesAddition = 1;
      }
   }
}
