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
      
      public function QuestDataInfo(param1:int){super();}
      
      public function set isExist(param1:Boolean) : void{}
      
      public function get isExist() : Boolean{return false;}
      
      public function get id() : int{return 0;}
      
      public function set isNew(param1:Boolean) : void{}
      
      public function get isNew() : Boolean{return false;}
      
      public function set informed(param1:Boolean) : void{}
      
      public function get needInformed() : Boolean{return false;}
      
      public function get isAchieved() : Boolean{return false;}
      
      public function set isAchieved(param1:Boolean) : void{}
      
      public function setProgress(param1:int, param2:int = 0, param3:int = 0, param4:int = 0) : void{}
      
      public function setProgressConcoat(param1:Array) : void{}
      
      public function get progress() : Array{return null;}
      
      public function setIsAutoComplete(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void{}
      
      public function setIsAutoCompleteConcoat(param1:Vector.<Boolean>) : void{}
      
      public function get isAutoComplete() : Vector.<Boolean>{return null;}
   }
}
