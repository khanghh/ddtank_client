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
      
      public function QuestDataInfo(id:int)
      {
         super();
         _questID = id;
         hadChecked = false;
         _isNew = false;
         _informed = false;
      }
      
      public function set isExist(value:Boolean) : void
      {
         _isExist = value;
      }
      
      public function get isExist() : Boolean
      {
         return _isExist;
      }
      
      public function get id() : int
      {
         return _questID;
      }
      
      public function set isNew(value:Boolean) : void
      {
         _isNew = value;
      }
      
      public function get isNew() : Boolean
      {
         return _isNew;
      }
      
      public function set informed(value:Boolean) : void
      {
         _informed = value;
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
      
      public function set isAchieved(isAchieved:Boolean) : void
      {
         _isAchieved = isAchieved;
      }
      
      public function setProgress(con0:int, con1:int = 0, con2:int = 0, con3:int = 0) : void
      {
         if(!_progress)
         {
            _progress = [];
         }
         _progress[0] = con0;
         _progress[1] = con1;
         _progress[2] = con2;
         _progress[3] = con3;
      }
      
      public function setProgressConcoat(proArray:Array) : void
      {
         var i:int = 0;
         var tmpLen:int = proArray.length;
         for(i = 0; i < tmpLen; )
         {
            _progress[i + 4] = proArray[i];
            i++;
         }
      }
      
      public function get progress() : Array
      {
         return _progress;
      }
      
      public function setIsAutoComplete($AutoCom0:Boolean, $AutoCom1:Boolean, $AutoCom2:Boolean, $AutoCom3:Boolean) : void
      {
         if(_isAutoComplete == null)
         {
            _isAutoComplete = new Vector.<Boolean>();
         }
         _isAutoComplete[0] = $AutoCom0;
         _isAutoComplete[1] = $AutoCom1;
         _isAutoComplete[2] = $AutoCom2;
         _isAutoComplete[3] = $AutoCom3;
      }
      
      public function setIsAutoCompleteConcoat($autoComArray:Vector.<Boolean>) : void
      {
         var i:int = 0;
         var tmpLen:int = $autoComArray.length;
         for(i = 0; i < tmpLen; )
         {
            _isAutoComplete[i + 4] = $autoComArray[i];
            i++;
         }
      }
      
      public function get isAutoComplete() : Vector.<Boolean>
      {
         return _isAutoComplete;
      }
   }
}
