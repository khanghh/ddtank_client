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
      
      public function set taskisBind(value:Boolean) : void
      {
         _taskisBind = value;
      }
      
      public function get rewardisBind() : Boolean
      {
         return _rewardisBind;
      }
      
      public function set rewardisBind(value:Boolean) : void
      {
         _rewardisBind = value;
      }
      
      public function get refreshTaskAlertAgain() : Boolean
      {
         return _refreshTaskAlertAgain;
      }
      
      public function set refreshTaskAlertAgain(value:Boolean) : void
      {
         _refreshTaskAlertAgain = value;
      }
      
      public function get refreshRewardAlertAgain() : Boolean
      {
         return _refreshRewardAlertAgain;
      }
      
      public function set refreshRewardAlertAgain(value:Boolean) : void
      {
         _refreshRewardAlertAgain = value;
      }
      
      public function get questID() : int
      {
         return _id;
      }
      
      public function set questID(value:int) : void
      {
         _id = value;
      }
      
      public function get multiple() : int
      {
         return _multiple;
      }
      
      public function set multiple(value:int) : void
      {
         _multiple = value;
      }
      
      public function get buyTimes() : int
      {
         return _buyTimes;
      }
      
      public function set buyTimes(value:int) : void
      {
         _buyTimes = value;
      }
      
      public function get times() : int
      {
         return _times;
      }
      
      public function set times(value:int) : void
      {
         _times = value;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function set status(value:int) : void
      {
         _status = value;
      }
   }
}
