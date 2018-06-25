package rewardTask.data{   public class RewardTaskModel   {                   private var _detail:String;            private var _id:int;            private var _multiple:int;            private var _buyTimes:int;            private var _times:int;            private var _status:int;            private var _refreshRewardAlertAgain:Boolean = true;            private var _refreshTaskAlertAgain:Boolean = true;            private var _rewardisBind:Boolean = true;            private var _taskisBind:Boolean = true;            public function RewardTaskModel() { super(); }
            public function get taskisBind() : Boolean { return false; }
            public function set taskisBind(value:Boolean) : void { }
            public function get rewardisBind() : Boolean { return false; }
            public function set rewardisBind(value:Boolean) : void { }
            public function get refreshTaskAlertAgain() : Boolean { return false; }
            public function set refreshTaskAlertAgain(value:Boolean) : void { }
            public function get refreshRewardAlertAgain() : Boolean { return false; }
            public function set refreshRewardAlertAgain(value:Boolean) : void { }
            public function get questID() : int { return 0; }
            public function set questID(value:int) : void { }
            public function get multiple() : int { return 0; }
            public function set multiple(value:int) : void { }
            public function get buyTimes() : int { return 0; }
            public function set buyTimes(value:int) : void { }
            public function get times() : int { return 0; }
            public function set times(value:int) : void { }
            public function get status() : int { return 0; }
            public function set status(value:int) : void { }
   }}