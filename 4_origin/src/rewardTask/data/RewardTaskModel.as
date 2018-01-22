package rewardTask.data
{
   public class RewardTaskModel
   {
       
      
      private var _detail:String;
      
      private var _id:int;
      
      private var _multiple:int;
      
      private var _buyTimes:int;
      
      private var _times:int;
      
      private var _status:int;
      
      private var _refreshRewardAlertAgain:Boolean = true;
      
      private var _refreshTaskAlertAgain:Boolean = true;
      
      private var _rewardisBind:Boolean = true;
      
      private var _taskisBind:Boolean = true;
      
      public function RewardTaskModel()
      {
         super();
      }
      
      public function get taskisBind() : Boolean
      {
         return _taskisBind;
      }
      
      public function set taskisBind(param1:Boolean) : void
      {
         _taskisBind = param1;
      }
      
      public function get rewardisBind() : Boolean
      {
         return _rewardisBind;
      }
      
      public function set rewardisBind(param1:Boolean) : void
      {
         _rewardisBind = param1;
      }
      
      public function get refreshTaskAlertAgain() : Boolean
      {
         return _refreshTaskAlertAgain;
      }
      
      public function set refreshTaskAlertAgain(param1:Boolean) : void
      {
         _refreshTaskAlertAgain = param1;
      }
      
      public function get refreshRewardAlertAgain() : Boolean
      {
         return _refreshRewardAlertAgain;
      }
      
      public function set refreshRewardAlertAgain(param1:Boolean) : void
      {
         _refreshRewardAlertAgain = param1;
      }
      
      public function get questID() : int
      {
         return _id;
      }
      
      public function set questID(param1:int) : void
      {
         _id = param1;
      }
      
      public function get multiple() : int
      {
         return _multiple;
      }
      
      public function set multiple(param1:int) : void
      {
         _multiple = param1;
      }
      
      public function get buyTimes() : int
      {
         return _buyTimes;
      }
      
      public function set buyTimes(param1:int) : void
      {
         _buyTimes = param1;
      }
      
      public function get times() : int
      {
         return _times;
      }
      
      public function set times(param1:int) : void
      {
         _times = param1;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(param1:int) : void
      {
         _status = param1;
      }
   }
}
