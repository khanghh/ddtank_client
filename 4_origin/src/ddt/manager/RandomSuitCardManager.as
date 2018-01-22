package ddt.manager
{
   import ddt.CoreManager;
   import ddt.data.BuffInfo;
   import ddt.events.PkgEvent;
   import ddt.utils.Helpers;
   import road7th.comm.PackageIn;
   
   public class RandomSuitCardManager extends CoreManager
   {
      
      public static const RANDOM_SUIT_CARD_UPDATED:String = "rsc_random_suit_card_updated";
      
      private static var instance:RandomSuitCardManager;
       
      
      private var _beginDate:Date;
      
      private var _validTime:int;
      
      private var _beginTime:Number;
      
      private var _endTime:Number;
      
      public function RandomSuitCardManager(param1:inner)
      {
         super();
      }
      
      public static function getInstance() : RandomSuitCardManager
      {
         if(!instance)
         {
            instance = new RandomSuitCardManager(new inner());
         }
         return instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(337),onRandomSuit);
      }
      
      protected function onRandomSuit(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _beginDate = _loc2_.readDate();
         _validTime = _loc2_.readInt();
         _validTime = _validTime * 60 * 24;
         _beginTime = _beginDate.time;
         _endTime = _beginTime + _validTime * 60000;
         PlayerManager.Instance.Self.addBuff(new BuffInfo(18,isExist(),_beginDate,_validTime,0,0,11966));
      }
      
      public function quickUse(param1:Boolean) : void
      {
         SocketManager.Instance.out.sendRandomSuitUse(-1,param1);
      }
      
      public function useCard(param1:int) : void
      {
         SocketManager.Instance.out.sendRandomSuitUse(param1,false);
      }
      
      public function remainTime() : String
      {
         var _loc1_:Number = _endTime - TimeManager.Instance.Now().time;
         _loc1_ = Math.max(0,_loc1_);
         if(_loc1_ == 0)
         {
            return "0";
         }
         return Helpers.getTimeString(_loc1_,"cn");
      }
      
      public function isExist() : Boolean
      {
         var _loc1_:Number = NaN;
         if(_beginDate == null)
         {
            return false;
         }
         _loc1_ = TimeManager.Instance.Now().time;
         return _loc1_ < _endTime;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
