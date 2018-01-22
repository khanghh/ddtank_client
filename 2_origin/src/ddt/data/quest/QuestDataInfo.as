package ddt.data.quest
{
   public class QuestDataInfo
   {
       
      
      public var isGet:Boolean;
      
      public var repeatLeft:int;
      
      public var hadChecked:Boolean;
      
      public var quality:int;
      
      private var _questID:int;
      
      private var _progress:Array;
      
      private var _isAutoComplete:Vector.<Boolean>;
      
      public var CompleteDate:Date;
      
      public var AddTiemsDate:Date;
      
      private var _isAchieved:Boolean;
      
      private var _isNew:Boolean;
      
      private var _informed:Boolean;
      
      private var _isExist:Boolean;
      
      public function QuestDataInfo(param1:int)
      {
         super();
         _questID = param1;
         hadChecked = false;
         _isNew = false;
         _informed = false;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         _isExist = param1;
      }
      
      public function get isExist() : Boolean
      {
         return _isExist;
      }
      
      public function get id() : int
      {
         return _questID;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         _isNew = param1;
      }
      
      public function get isNew() : Boolean
      {
         return _isNew;
      }
      
      public function set informed(param1:Boolean) : void
      {
         _informed = param1;
      }
      
      public function get needInformed() : Boolean
      {
         if(!_informed && _isNew)
         {
            return true;
         }
         return false;
      }
      
      public function get isAchieved() : Boolean
      {
         return _isAchieved;
      }
      
      public function set isAchieved(param1:Boolean) : void
      {
         _isAchieved = param1;
      }
      
      public function setProgress(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         if(!_progress)
         {
            _progress = [];
         }
         _progress[0] = param1;
         _progress[1] = param2;
         _progress[2] = param3;
         _progress[3] = param4;
      }
      
      public function setProgressConcoat(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _progress[_loc3_ + 4] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      public function get progress() : Array
      {
         return _progress;
      }
      
      public function setIsAutoComplete(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(_isAutoComplete == null)
         {
            _isAutoComplete = new Vector.<Boolean>();
         }
         _isAutoComplete[0] = param1;
         _isAutoComplete[1] = param2;
         _isAutoComplete[2] = param3;
         _isAutoComplete[3] = param4;
      }
      
      public function setIsAutoCompleteConcoat(param1:Vector.<Boolean>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _isAutoComplete[_loc3_ + 4] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      public function get isAutoComplete() : Vector.<Boolean>
      {
         return _isAutoComplete;
      }
   }
}
