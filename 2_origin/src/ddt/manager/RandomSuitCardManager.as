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
      
      public function RandomSuitCardManager(single:inner)
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
      
      protected function onRandomSuit(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _beginDate = pkg.readDate();
         _validTime = pkg.readInt();
         _validTime = _validTime * 60 * 24;
         _beginTime = _beginDate.time;
         _endTime = _beginTime + _validTime * 60000;
         PlayerManager.Instance.Self.addBuff(new BuffInfo(18,isExist(),_beginDate,_validTime,0,0,11966));
      }
      
      public function quickUse(isBind:Boolean) : void
      {
         SocketManager.Instance.out.sendRandomSuitUse(-1,isBind);
      }
      
      public function useCard(place:int) : void
      {
         SocketManager.Instance.out.sendRandomSuitUse(place,false);
      }
      
      public function remainTime() : String
      {
         var timeRemain:Number = _endTime - TimeManager.Instance.Now().time;
         timeRemain = Math.max(0,timeRemain);
         if(timeRemain == 0)
         {
            return "0";
         }
         return Helpers.getTimeString(timeRemain,"cn");
      }
      
      public function isExist() : Boolean
      {
         var nowTime:Number = NaN;
         if(_beginDate == null)
         {
            return false;
         }
         nowTime = TimeManager.Instance.Now().time;
         return nowTime < _endTime;
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
