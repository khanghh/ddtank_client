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
      
      public function set AuncherExperienceAddition(val:Number) : void
      {
         _auncherExperienceAddition = val;
      }
      
      public function get GMExperienceAdditionType() : Number
      {
         return _gmExperienceAdditionType;
      }
      
      public function set GMExperienceAdditionType(val:Number) : void
      {
         _gmExperienceAdditionType = val;
      }
      
      public function get GMOfferAddition() : Number
      {
         return _gmOfferAddition;
      }
      
      public function set GMOfferAddition(val:Number) : void
      {
         _gmOfferAddition = val;
      }
      
      public function get AuncherOfferAddition() : Number
      {
         return _auncherOfferAddition;
      }
      
      public function set AuncherOfferAddition(val:Number) : void
      {
         _auncherOfferAddition = val;
      }
      
      public function get GMRichesAddition() : Number
      {
         return _gmRichesAddition;
      }
      
      public function set GMRichesAddition(val:Number) : void
      {
         _gmRichesAddition = val;
      }
      
      public function get AuncherRichesAddition() : Number
      {
         return _auncherRichesAddition;
      }
      
      public function set AuncherRichesAddition(val:Number) : void
      {
         _auncherRichesAddition = val;
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
